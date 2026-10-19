draw_sprite(spr_menunew, 1, 0, 0)

if state == "files"
{
	draw_sprite_ext(spr_menunew, 3, drawer1_x, drawer1_y,1,1,drawer1_x/4,c_white,1)
	draw_sprite_ext(spr_menunew, 3, drawer2_x+300, drawer2_y,1,1,drawer2_x/4,c_white,1)
	draw_sprite_ext(spr_menunew, 3, drawer3_x+600, drawer3_y,1,1,drawer3_x/4,c_white,1)

	draw_sprite(spr_menunew, 2, 0, 0)
}
if state == "draw"
{
	var mbleft = mky_jump || mouse_check_button(mb_left)
	var mbright = !mbleft && (mky_slap || mouse_check_button(mb_right))
	
	var _offset = 132
	
	draw_sprite(spr_menunew, 10, 0, 0)

	if !surface_exists(drawsurf)
	{
		drawsurf = surface_create(960-_offset*2,540)
		surface_set_target(drawsurf)
		draw_clear(#5860aa)
		draw_sprite(spr_menunew,11,0,0)
		surface_reset_target()
	}
	
	surface_set_target(drawsurf)
	if mbleft
		draw_line_width_colour(hand_x_old-_offset+135,hand_y_old+20,hand_x-_offset+135,hand_y+20,2,#3c1e3e,#3c1e3e)
	if mbright
	{
		draw_circle_colour(hand_x_old-_offset+135,hand_y_old+20,64,#5860aa,#5860aa,false)
		draw_circle_colour(hand_x-_offset+135,hand_y+20,64,#5860aa,#5860aa,false)
		draw_line_width_colour(hand_x_old-_offset+135,hand_y_old+20,hand_x-_offset+135,hand_y+20,64,#5860aa,#5860aa)
	}
	surface_reset_target()
	
	draw_surface(drawsurf,_offset,0)
	
	draw_circle_colour(hand_x+135,hand_y+20,64,#3c1e3e,#3c1e3e,true)
	draw_circle_colour(hand_x+135,hand_y+20,2,#3c1e3e,#3c1e3e,true)
}
if state == "tv"
{
	draw_set_alpha(1)
	draw_set_colour(c_white)
	if video_get_status() != video_status_playing
	{
		draw_clear(#D0FF96)
		draw_set_colour(#2e3a1a)
		draw_set_halign(1)
		draw_set_valign(1)
		draw_set_font(global.npcfont)
		draw_text_transformed(480+light_final*5, 270-light_final*5, "NO SIGNAL\n\nLEFT RIGHT : SCROLL BUILTIN VIDEOS\nJUMP : PICK CUSTOM VIDEO\nGRAB : TO STOP VIDEO", 0.8, 1, 2)
		draw_set_halign(0)
		draw_set_valign(0)
		draw_set_colour(c_white)
	}
	else
	{
		var _data = video_draw()
		if _data[0] == 0
		{
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
}