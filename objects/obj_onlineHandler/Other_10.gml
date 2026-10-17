///@description hunt mode - update
/*
if socket == 0 && global.prophuntmode.active
{
	var _oldtimer = ceil(global.prophuntmode.timer)
	global.prophuntmode.timer -= 1/60
	if _oldtimer != ceil(global.prophuntmode.timer)
	{
		if global.prophuntmode.waitphase && global.prophuntmode.timer <= 0
		{
			global.prophuntmode.waitphase = false
			global.prophuntmode.timer = 240
		}
		var _hunters = 0
		with obj_onlinePlayer
		{
			if hunter
				_hunters++
		}
		if global.prophuntmode.timer < -5
		{
			global.prophuntmode.active = false
			instance_destroy(obj_prophuntmode)
			with obj_player
			{
				generalReset()
				image_alpha = 1
			}
			room_goto(Mainmenu)
			
			var buff = buffer_create(64, buffer_fixed, 1)
			buffer_write(buff, buffer_u8, networkpacket.prophunt_start)
			buffer_write(buff, buffer_u8, 3) // 3 means end game
			self.network_send_packetServ(buff, buffer_get_size(buff))
			buffer_delete(buff);
			exit
		}
		if global.prophuntmode.select == -4 && instance_number(obj_onlinePlayer) == _hunters
		|| (!global.prophuntmode.waitphase && global.prophuntmode.timer == 0)
		{
			if global.prophuntmode.timer > 0
				global.prophuntmode.timer = 0
			global.prophuntmode.waitphase = 0
			var _text = (global.prophuntmode.select == -4 && instance_number(obj_onlinePlayer) == _hunters)+1
			with obj_prophuntmode
				win = _text

			var buff = buffer_create(64, buffer_fixed, 1)
			buffer_write(buff, buffer_u8, networkpacket.prophunt_start)
			buffer_write(buff, buffer_u8, 2) // 2 means win text
			buffer_write(buff, buffer_u8, _text)
			self.network_send_packetServ(buff, buffer_get_size(buff))
			buffer_delete(buff);
		}
		if obj_prophuntmode.win != -4
		{
			var buff = buffer_create(64, buffer_fixed, 1)
			buffer_write(buff, buffer_u8, networkpacket.prophunt_start)
			buffer_write(buff, buffer_u8, 1) // 1 means time update
			buffer_write(buff, buffer_u8, max(global.prophuntmode.timer,0))
			buffer_write(buff, buffer_u8, global.prophuntmode.waitphase)
			self.network_send_packetServ(buff, buffer_get_size(buff))
			buffer_delete(buff);
		}
	}
}