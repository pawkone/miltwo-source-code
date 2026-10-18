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