if !surface_exists(gameSurface)
    gameSurface = surface_create(960, 540)
surface_set_target(gameSurface)
gpu_set_blendmode(bm_normal)
if surface_exists(application_surface) && room != rm_loading
	draw_surface_ext(application_surface, global.modifiers.flipped ? 960 : 0, 0, global.modifiers.flipped ? -1 : 1, 1, 0, c_white, 1);