if playerupdate >= 2
{
	playerupdate = 0
	if instance_exists(obj_player)
	{
		var sockets = ds_map_keys_to_array(plrsconnected)
		for (var i = 0; i < array_length(sockets); i++)
		{
			var _value = ds_map_find_value(plrsconnected, sockets[i])
			if _value[0]-1 <= 0
			{
				ds_map_delete(plrsconnected, sockets[i])
				with obj_onlinePlayer
				{
					if sockets[i] == idds
						instance_destroy()
				}
				if idds == 0
					ds_map_delete(plrs, sockets[i])
			}
			else
				ds_map_set(plrsconnected, sockets[i], [_value[0]-1, _value[1]])
		}
		oldplayer = {
		    x: obj_player.x,
		    y: obj_player.y,
		    sprite_index: (obj_player.character == chars.soda ? spr_soda : obj_player.sprite_index),
		    image_index: obj_player.image_index,
		    xscale: obj_player.xscale,
		    image_alpha: obj_player.image_alpha,
		    image_blend: obj_player.image_blend,
		    flash: obj_player.flash,
		    state: obj_player.state,
		    depth: obj_player.depth,
		    spr_palette: obj_player.spr_palette,
		    palIndex: obj_player.palIndex,
		    breakdance: obj_player.breakdancespeed > 0.5 && obj_player.sprite_index == obj_player.sprites.breakdance,
		}
	}
	var _prophunt = global.prophuntmode.active && instance_exists(obj_onlineProphunt)
	var _isprop = _prophunt && global.prophuntmode.select >= 0
	var p = oldplayer
	buffer_seek(playerBuff, buffer_seek_start, 0)
	buffer_write(playerBuff, buffer_u8, networkpacket.player)
	buffer_write(playerBuff, buffer_u32, idds)
	buffer_write(playerBuff, buffer_u16, floor(clamp((p.x/2)+64,0,65435)))
	buffer_write(playerBuff, buffer_u16, floor(clamp((p.y/2)+64,0,65435)))
	buffer_write(playerBuff, buffer_u16, room)
	buffer_write(playerBuff, buffer_u16, _isprop ? obj_onlineProphunt.sprite_index : p.sprite_index)
	buffer_write(playerBuff, buffer_u8, floor(clamp(_isprop ? obj_onlineProphunt.image_index : p.image_index,0,255)))
	buffer_write(playerBuff, buffer_u8, floor(clamp(p.image_alpha*255,0,255)))
	buffer_write(playerBuff, buffer_u8, floor(clamp(colour_get_value(p.image_blend),0,255)))
	buffer_write(playerBuff, buffer_u8, p.state)
	buffer_write(playerBuff, buffer_u8, floor(clamp(p.depth+122,0,255)))
	buffer_write(playerBuff, buffer_u16, p.spr_palette)
	buffer_write(playerBuff, buffer_u16, global.patternSpr)
	buffer_write(playerBuff, buffer_u8, p.palIndex)
	if _prophunt
		buffer_write(playerBuff, buffer_s8, global.prophuntmode.select)
	else
		buffer_write(playerBuff, buffer_s8, -1)
	var flags = 0
	flags |= p.flash << 0
	flags |= (!instance_exists(obj_player) ? 1 : 0) << 1
	flags |= ((p.xscale == -1) ? 1 : 0) << 2
	flags |= (p.breakdance ? 1 : 0) << 3
	buffer_write(playerBuff, buffer_u8, flags)
	buffer_write(playerBuff, buffer_string, global.username)
	self.network_send_packetServ(playerBuff, buffer_get_size(playerBuff));



	if idds == 0
	{
		var buff = buffer_create(32, buffer_grow, 1)
		buffer_write(buff, buffer_u8, networkpacket.mode)
		if global.prophuntmode.active
		{
			buffer_write(buff, buffer_u8, 2)
			buffer_write(buff, buffer_u8, global.prophuntmode.waitphase)
			buffer_write(buff, buffer_u8, global.prophuntmode.ran)
			buffer_write(buff, buffer_u16, global.prophuntmode.room)
			buffer_write(buff, buffer_f16, global.prophuntmode.timer)
			buffer_write(buff, buffer_u32, global.prophuntmode.pickedhunter)
			buffer_write(buff, buffer_u8, obj_onlineProphunt.win)
		}
		else if global.racemode.active
		{
			buffer_write(buff, buffer_u8, 1)
			buffer_write(buff, buffer_u8, global.racemode.ran)
			buffer_write(buff, buffer_u16, global.racemode.room)
			buffer_write(buff, buffer_f16, global.racemode.timer)
		}
		else
			buffer_write(buff, buffer_u8, 0)
		self.network_send_packetServ(buff, buffer_get_size(buff))
		buffer_delete(buff)
	}
}
else
	playerupdate++
if !global.prophuntmode
{
	with obj_onlinePlayer
	{
		if distance_to_object(obj_player) < 25 && room == currentRoom
		{
			obj_player.image_alpha = 1
			global.prophuntmode.select = -4
			obj_onlineHandler.create_notifAsync(global.username + lang_get_phrase("online_prophunt_caught") + name)
			break
		}
	}
}
if idds == 0
{
	if global.racemode.active
	{
		if global.racemode.timer > 0
			global.racemode.timer -= 1/60
	}
	if global.prophuntmode.active
	{
		global.prophuntmode.timer -= 1/60
		if global.prophuntmode.waitphase && global.prophuntmode.timer <= 0
		{
			global.prophuntmode.waitphase = false
			global.prophuntmode.timer = 240
		}
		if !global.prophuntmode.waitphase
		{
			var _hunters = 0
			with obj_onlinePlayer
			{
				if hunter
					_hunters++
			}
			if global.prophuntmode.timer < -5
			{
				global.prophuntmode.active = false
				instance_destroy(obj_onlineProphunt)
				with obj_player
				{
					generalReset()
					image_alpha = 1
				}
				room_goto(Mainmenu)
			}
			else if global.prophuntmode.select == -4 && instance_number(obj_onlinePlayer) == _hunters
			|| (!global.prophuntmode.waitphase && global.prophuntmode.timer == 0)
			{
				if global.prophuntmode.timer > 0
					global.prophuntmode.timer = 0
				global.prophuntmode.waitphase = 0
				var _text = (global.prophuntmode.select == -4 && instance_number(obj_onlinePlayer) == _hunters)+1
				with obj_onlineProphunt
					win = _text
			}
		}
	}
}