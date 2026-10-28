var _paused = !instance_exists(obj_player)
if async_load[? "type"] == network_type_data
{
    var buff = async_load[? "buffer"];
    if buffer_exists(buff)
    {
        buffer_seek(buff, buffer_seek_start, 0)
		var _type = buffer_read(buff, buffer_u8)
		var _socket = -4
		if _type == networkpacket.player
		{
			_socket = buffer_read(buff, buffer_u32)
			if idds == 0 && _socket != 0
			{
				ds_map_set(plrs, _socket, [async_load[? "ip"], async_load[? "port"]])
				var sockets = ds_map_keys_to_array(plrs)
				for (var i = 0; i < array_length(sockets); i++)	
				{
					var _dsmap = ds_map_find_value(plrs, sockets[i])
					network_send_udp(global.server, _dsmap[0], _dsmap[1], buff, buffer_get_size(buff))
				}
			}
			if _socket == idds
				exit
		}
        switch _type
        {
			case networkpacket.mode:
				var _mode = buffer_read(buff, buffer_u8)
				if _mode == 2
				{
					global.prophuntmode.active = 1
					global.prophuntmode.waitphase = buffer_read(buff, buffer_u8)
					global.prophuntmode.ran = buffer_read(buff, buffer_u8)
					global.prophuntmode.room = buffer_read(buff, buffer_u16)
					global.prophuntmode.timer = buffer_read(buff, buffer_f16)
					global.prophuntmode.pickedhunter = buffer_read(buff, buffer_u32)
					var _win = buffer_read(buff, buffer_u8)
					with (obj_player)
					{
						if global.level != string("prophunt{0}", global.prophuntmode.ran)
						{
							generalReset();
							room_goto(global.prophuntmode.room)
							state = states.enterdoor
							sprite_index = sprites.walkfront
							targetRoom = global.prophuntmode.room
							door = "A"
							global.level = string("prophunt{0}", global.prophuntmode.ran)
							backtohubRoom = Mainmenu;
							backtohubX = 0;
							backtohubY = 0;
							global.resetRoom = global.prophuntmode.room;
							
							global.prophuntmode.select = global.prophuntmode.pickedhunter == obj_onlineHandler.idds ? -4 : irandom(array_length(global.prophuntmode.sprites)-1)
							
							instance_destroy(obj_onlineProphunt)
							instance_create(0,0,obj_onlineProphunt)
						}
					}
					with obj_onlineProphunt
						win = _win
				}
				else if _mode == 1
				{
					global.racemode.active = 1
					global.racemode.ran = buffer_read(buff, buffer_u8)
					global.racemode.room = buffer_read(buff, buffer_u16)
					global.racemode.timer = buffer_read(buff, buffer_f16)
					with (obj_player)
					{
						if global.level != string("race{0}", global.racemode.ran)
						{
							generalReset();
							room_goto(global.racemode.room)
							targetRoom = global.racemode.room;
							door = "A";
							global.level = string("race{0}", global.racemode.ran);
							backtohubRoom = Mainmenu;
							backtohubX = 0;
							backtohubY = 0;
							global.resetRoom = global.racemode.room;
							instance_destroy(obj_onlineRace)
							instance_create(0,0,obj_onlineRace)
						}
					}
				}
				else
				{
					if global.racemode.active
					{
						global.racemode.active = 0
						generalReset()
						instance_destroy(obj_onlineRace)
						with obj_player
							image_alpha = 1
						room_goto(Mainmenu)
						break
					}
					else if global.prophuntmode.active
					{
						global.prophuntmode.active = 0
						generalReset()
						instance_destroy(obj_onlineProphunt)
						with obj_player
							image_alpha = 1
						room_goto(Mainmenu)
						exit
					}
				}
                break;
			
            case networkpacket.notification:
				var _buf = string_lower(buffer_read(buff, buffer_string))
				scr_soundeffect(sfx_pop, random_range(0.98,1.02))
                array_push(notifs, [_buf, 400, c_white]);
                break;
            
            case networkpacket.player:
				if !_paused && idds >= 0 && idds != _socket
				{
	                var _found = false, _objPl = -4
	                with obj_onlinePlayer
					{
	                    if idds == _socket
	                    {
	                        _found = true
	                        _objPl = id
							break
	                    }
	                }
	                if !_found
					{
	                    _objPl = instance_create(0, 0, obj_onlinePlayer)
						_objPl.idds = _socket
					}
	                with _objPl
	                {
	                    x = (buffer_read(buff, buffer_u16)-64)*2;
	                    y = (buffer_read(buff, buffer_u16)-64)*2;
						currentRoom = buffer_read(buff, buffer_u16);
	                    sprite_index = buffer_read(buff, buffer_u16);
						image_index = buffer_read(buff, buffer_u8);
	                    image_alpha = buffer_read(buff, buffer_u8)/255;
						image_blend = make_colour_hsv(0,0,buffer_read(buff, buffer_u8));
	                    state = buffer_read(buff, buffer_u8);
						depth = buffer_read(buff, buffer_u8)-122;
	                    spr_palette = buffer_read(buff, buffer_u16);
	                    spr_pattern = buffer_read(buff, buffer_u16);
						palIndex = buffer_read(buff, buffer_u8);
						
						var _huntmode = buffer_read(buff, buffer_s8)
						hunter = _huntmode == -4
						object = _huntmode >= 0 ? _huntmode : -4
						
						var flags = buffer_read(buff, buffer_u8)
						paused = (flags & (1 << 1)) != 0
						flash = (flags & (1 << 0)) != 0
						xscale = ((flags & (1 << 2)) != 0) ? -1 : 1
						breakdance = (flags & (1 << 3)) != 0
						
						name = buffer_read(buff, buffer_string)
						
						var _lastestMessageNum = buffer_read(buff, buffer_u8)
						var _lastestMessage = buffer_read(buff, buffer_string)
						if _lastestMessageNum != lastestMessageNum || _lastestMessage != lastestMessage
						{
							lastestMessageNum = _lastestMessageNum
							lastestMessage = _lastestMessage
							if lastestMessage != ""
							{
								if lastestMessageNum >= 234
									obj_onlineHandler.create_notifAsyncClientSide(lastestMessage)
								else if lastestMessageNum >= 123
									obj_onlineHandler.create_notifAsyncClientSide(name + lastestMessage, name)
								else
									obj_onlineHandler.create_notifAsyncClientSide("<" + name + "> " + lastestMessage, name)
							}
						}
	                }
					if instance_exists(_objPl)
					{
						if !ds_map_exists(plrsconnected, _socket)
							self.create_notifAsyncClientSide(_objPl.name + " has connected")
						ds_map_set(plrsconnected, _socket, [240, _objPl.name])
					}
				}
                
                break;
        }
    }
}
