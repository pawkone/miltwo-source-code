if !surface_exists(surf)
	surf = surface_create(960,540)
surface_set_target(surf)
draw_clear(c_black)
draw_sprite(spr_menunew, 1, 0, 0)

if state == "tv"
{
	draw_set_alpha(1)
	draw_set_colour(c_white)
	var _p = video_get_status() != video_status_playing
	if _p
	{
		draw_clear(#D0FF96)
		draw_set_colour(#2e3a1a)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_set_font(global.npcfont)
		draw_text_transformed(480+light_final*5, 270-light_final*5, tv_nsbuffer-- > 0 ? "SELECTED VIDEO NOT SUPPORTED..." : "NO SIGNAL\n\nLEFT RIGHT : SCROLL BUILTIN VIDEOS\nJUMP : PICK CUSTOM VIDEO\nGRAB : STOP VIDEO", 0.8, 1, 2)
		draw_set_halign(0)
		draw_set_valign(0)
		draw_set_colour(c_white)
		tv_index = 0
	}
	else
	{
		var _data = video_draw()
		if _data[0] == 0
		{
			tv_nsbuffer = 0
			draw_surface_stretched(_data[1], 81, 41, 797, 461)
			
			var _t = tv_index == -1 ? "Custom" : $"{tv_index}/{tv_max}"
			
			draw_set_halign(2)
			draw_set_valign(2)
			draw_set_font(global.creditsfont)
			draw_set_colour(c_white)
			draw_text(836, 438, _t)
			draw_set_halign(0)
			draw_set_valign(0)
			
			
			var _pos = video_get_position()/video_get_duration()
			var _x1 = 836-string_width(_t)
			
			draw_rectangle_colour(_x1-1, 440, 837, 444,0,0,0,0,false)
			draw_circle_colour(lerp(_x1, 836, _pos),442,5,c_black,c_black,false)
			
			draw_healthbar(_x1, 441, 836, 443,_pos*100,c_ltgray,c_lime,c_lime,0,true,false)
			draw_circle_colour(lerp(_x1, 836, _pos),442,4,c_lime,c_lime,false)
		}
	}
	if tv_static >= 0
		draw_sprite(spr_tvstatic, tv_static, 0, 0)
	draw_sprite(spr_menunew, 13, 0, 0)
	
	if mousemoved
	{
		var _alpha = tv_static == -1 ? 1 : 0.5
		var _alpha2 = tv_index == -1 ? 0.5 : _alpha
		var _c = mouse_check_button(mb_left)
		var _c2 = mouse_check_button_released(mb_left)
		
		var _t1 = point_in_circle(mouse_x,mouse_y,60,270,30)
		draw_sprite_ext(spr_menunew_tvhint, 0, 60, 270, 1, 1, 0, _t1 ? (_c ? c_yellow : c_aqua) : c_white, _alpha2)
		if _t1 && _c2
			pky_left2 = 1
		
		var _t2 = point_in_circle(mouse_x,mouse_y,900,270,30)
		draw_sprite_ext(spr_menunew_tvhint, 1, 900, 270, 1, 1, 0, _t2 ? (_c ? c_yellow : c_aqua) : c_white, _alpha2)
		if _t2 && _c2
			pky_right2 = 1
			
		var _t3 = point_in_circle(mouse_x,mouse_y,480+32,48,30)
		draw_sprite_ext(spr_menunew_tvhint, 2, 480+20, 48, 1, 1, 0, _t3 ? (_c ? c_yellow : c_aqua) : c_white, _alpha)
		if _t3 && _c2
			pky_jump2 = 1
			
		var _t4 = point_in_circle(mouse_x,mouse_y,480-32,48,30)
		draw_sprite_ext(spr_menunew_tvhint, 3, 480-20, 48, 1, 1, 0, _t4 ? (_c ? c_yellow : c_aqua) : c_white, _p ? 0.5 : _alpha)
		if _t4 && _c2
			pky_grab2 = 1
	}
}