if instance_exists(obj_option) exit

if keyboard_check_pressed(vk_f2)
{
	var _rm = hotel_start;
	var _dr = "A";
	with (obj_player)
	{
		global.saveFile = wsbMOmInfo.dir + "sandbox1.xda"
		xdata_open(global.saveFile)
		character = xdata_read("Modded", "c_char", chars.mildred)
		palIndex = xdata_read("Modded", "c_pal", 1)
		xdata_close()
		event_user(0)
		generalReset();
	    targetRoom = _rm;
	    door = _dr;
	    movespeed = 0;
	    vsp = 0;
	    hsp = 0;
	    state = states.enterdoor;
	}
	global.level = -4;
	global.resetRoom = _rm;
	room_goto(_rm)
	instance_destroy(obj_fadeout)
	with instance_create(0, 0, obj_fadeout)
	{
		image_alpha = 1
		fadein = 0
	}
	surface_reset_target()
	instance_destroy()
	exit
}

if light_timer-- < 0
{
	light_final = lerp(light_final, random_range(-0.01,0.01)+0.225, 0.5)
	light_timer = 1
}

mouse_xspd = lerp(mouse_xspd, mky_right + mky_left, 0.2)
mouse_yspd = lerp(mouse_yspd, mky_down - mky_up, 0.2)
mouse_xfake += mouse_xspd*12
mouse_yfake += mouse_yspd*12
mouse_xfake = clamp(mouse_xfake, 0, 960)
mouse_yfake = clamp(mouse_yfake, 0, 540)

if window_mouse_get_delta_x() > 0 || window_mouse_get_delta_y() > 0
	mousemoved = true
	
hand_y = clamp(hand_y, 0, 540)






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
	var mbright = mky_slap || mouse_check_button(mb_right)
	
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
	else if mbright
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

hand_x_old = hand_x
hand_y_old = hand_y