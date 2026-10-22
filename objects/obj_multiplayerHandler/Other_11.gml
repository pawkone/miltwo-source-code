///@description Client Data Handle
var _asBuf = tempInfo; tempInfo = -4

var _id = buffer_read(_asBuf, buffer_u8)
switch _id
{
	case multiplayerType.assignId:
		plrId = buffer_read(_asBuf, buffer_u8)
	break case multiplayerType.updatePlayer:
		var _plr = buffer_read(_asBuf, buffer_u8)
		plrList[_plr] = 240
		
		if !is_array(plrDraw[_plr])
		{
			plrDraw[_plr] = array_create(17 + 1, -4)
			plrDrawExtra[_plr] = array_create(5 + 1, -4)
		}
		
		plrDraw[_plr][0] = buffer_read(_asBuf, buffer_u16)
		plrDraw[_plr][1] = buffer_read(_asBuf, buffer_u8)
		plrDraw[_plr][2] = buffer_read(_asBuf, buffer_u16)-100
		plrDraw[_plr][3] = buffer_read(_asBuf, buffer_u16)-100
		plrDraw[_plr][4] = buffer_read(_asBuf, buffer_u8)/255
		plrDraw[_plr][5] = buffer_read(_asBuf, buffer_s8)/50
		plrDraw[_plr][6] = buffer_read(_asBuf, buffer_s8)/50
		
		var _flags = buffer_read(_asBuf, buffer_u8)
		plrDraw[_plr][7] = _flags & (1 << 0) != 0
		plrDraw[_plr][8] = _flags & (1 << 1) ? -1 : 1
		plrDraw[_plr][9] = _flags & (1 << 2) != 0
		plrDraw[_plr][10] = _flags & (1 << 3) != 0
		
		plrDraw[_plr][11] = buffer_read(_asBuf, buffer_u16)
		plrDraw[_plr][12] = buffer_read(_asBuf, buffer_u8)
		plrDraw[_plr][13] = buffer_read(_asBuf, buffer_u16)
		plrDraw[_plr][14] = buffer_read(_asBuf, buffer_u16)
		plrDraw[_plr][15] = _flags & (1 << 4) != 0
		plrDraw[_plr][16] = make_colour_hsv(0,0,buffer_read(_asBuf, buffer_u8))
	break case multiplayerType.createParticle:
		if buffer_read(_asBuf, buffer_u16) == room
		{
			with instance_create(0,0,obj_particle)
			{
				onlineSynced = true
				sprite_index = buffer_read(_asBuf, buffer_u16)
				image_index = buffer_read(_asBuf, buffer_u8)
				x = buffer_read(_asBuf, buffer_u16)-100
				y = buffer_read(_asBuf, buffer_u16)-100
				hsp = buffer_read(_asBuf, buffer_u16)/100
				vsp = buffer_read(_asBuf, buffer_u16)/100
				grav = buffer_read(_asBuf, buffer_u16)/100
				image_angle = (buffer_read(_asBuf, buffer_u8)/255)*360
				image_speed = buffer_read(_asBuf, buffer_u8)/255
				image_xscale = buffer_read(_asBuf, buffer_s8)
				depth = buffer_read(_asBuf, buffer_s16)
			}
		}
	break case multiplayerType.createAfterimage:
		if buffer_read(_asBuf, buffer_u16) == room
		{
			var _plrid = buffer_read(_asBuf, buffer_u8)
			if is_array(plrDraw[_plrid])
			{
				with create_afterimage(plrDraw[_plrid][0], plrDraw[_plrid][1], plrDrawExtra[_plrid][0], plrDrawExtra[_plrid][1], plrDraw[_plrid][8])
				{
					onlineDelay = -1
					image_alpha = buffer_read(_asBuf, buffer_u8)/255
					fadeoutAlpha = buffer_read(_asBuf, buffer_u8)/255
					alpha = buffer_read(_asBuf, buffer_u8)/255
					type = buffer_read(_asBuf, buffer_u8)
					image_blend = buffer_read(_asBuf, buffer_u32)
				}
			}
		}
	break default:
		show_debug_message($"Client - Unknown multiplayerType: {_id}")
}