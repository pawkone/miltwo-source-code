draw_set_font(-1)
draw_set_halign(1)
draw_set_valign(2)

if plrId >= 0
{
	var _t = sprite_get_bbox_top(plrObj.sprite_index)
	plrDrawMe = lerp(plrDrawMe, _t, 0.2)
	plrDrawMe = approach(plrDrawMe, _t, 0.1)
	draw_text(plrObj.x, plrObj.y + plrDrawMe - 64, $"onlinetest:{plrId}")
}

for (var i = 0; i < array_length(plrDraw); i++)
{
	var _q = plrDraw[i]
	var _qb = plrDrawExtra[i]
	if _q != -4
	{
		if _q[14] == room
		{
			//position lerp
			plrDrawExtra[i][0] = lerp(_qb[0], _q[2], _qb[0] == -1000 ? 1 :0.2)
			plrDrawExtra[i][1] = lerp(_qb[1], _q[3], _qb[1] == -1000 ? 1 :0.2)
		
			//squash lerp
			plrDrawExtra[i][2] = lerp(_qb[2], _q[5], 0.2)
			plrDrawExtra[i][3] = lerp(_qb[3], _q[6], 0.2)
		
			//name y lerp
			var _t = sprite_get_bbox_top(_q[0])
			plrDrawExtra[i][4] = lerp(_qb[4], _t, 0.2)
			plrDrawExtra[i][4] = approach(_qb[4], _t, 0.1)
		
			//animation sync??
			if sprite_get_number(_q[0])-1 > _q[1]
				plrDraw[i][1] += _q[4] * sprite_get_speed(_q[0])
			
			if _q[9] //mach3 effect
				draw_sprite_ext(spr_chargeeffect, (current_time/1000)*60*0.35, _qb[0]+12*_q[8], _qb[1]+5, _q[8], 1, 0, c_white, 1)
			if _q[10] //groundpound effect
				draw_sprite_ext(spr_chargeeffect, (current_time/1000)*60*0.35, _qb[0], _qb[1]+32, 1, 1, -90, c_white, 1)
			
			//main draw
			if _q[7]
				shader_set(shd_silo)
			else
			{
				pattern_draw(_q[0],_q[1],_qb[0],_qb[1],_q[8]*_qb[2],_qb[3],0,_q[16],1,_q[13],spr_playerPatCol,_q[11],_q[12])
				pal_swap_set(_q[11], _q[12], false)
			}
			draw_sprite_ext(_q[0],_q[1],_qb[0],_qb[1],_q[8]*_qb[2],_qb[3],0,_q[16],1)
			if _q[7]
				shader_reset()
				
			draw_text(_qb[0],_qb[1] + _qb[4] - 64, $"onlinetest:{i}")
			if _q[15]
				draw_text(_qb[0],_qb[1], $"PLACEHOLDER BREAKDANCE TEXT")
		}
		else
		{
			plrDrawExtra[i][0] = -1000
			plrDrawExtra[i][1] = -1000
		}
	}
}

draw_set_halign(0)
draw_set_valign(0)