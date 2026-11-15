if instance_exists(obj_option) exit
gpu_set_blendmode(bm_normal)
if is_callable(pause_scr_draw)
	pause_scr_draw()
draw_set_colour(c_white)