obj_player.state = -4

if instance_exists(obj_option) exit

hand_x_old = hand_x
hand_y_old = hand_y

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

if state == "files"
	event_user(0)
if state == "draw"
	event_user(1)
	
hand_y = clamp(hand_y, 0, 540)