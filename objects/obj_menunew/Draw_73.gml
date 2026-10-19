draw_sprite(spr_menunew, 4+(hand_grab >= 0 ? 2 : hand_hover), hand_x, hand_y)

if state == "files"
	draw_sprite_ext(spr_menunew, 9, 0, 0, 1, 1, 0, c_white, light_final)
if state == "draw"
	draw_sprite_ext(spr_menunew, 12, 0, 0, 1, 1, 0, c_white, light_final*2)
if state == "tv" && !(tv_static > 7 || video_get_status() == video_status_playing)
	draw_sprite_ext(spr_menunew, 14, 0, 0, 1, 1, 0, c_white, light_final)


surface_reset_target()