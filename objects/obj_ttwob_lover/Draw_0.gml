if !active
	draw_self()
else
{
	if !surface_exists(paperSurf)
    	paperSurf = surface_create(200, 200)
	
	surface_set_target(paperSurf)
	draw_clear_alpha(c_black, 0)
	gpu_set_blendmode_ext(bm_one, bm_zero)
	draw_sprite_ext(spr_ttwob_doodlepaper, paper.index, 100, 100, paper.scale, paper.scale, 0, c_white, 1)
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	draw_sprite_ext(sprite_index, image_index, 100, 100, paper.scale, paper.scale, 0, c_white, 1)
	gpu_set_blendmode(bm_normal)
	surface_reset_target()
	draw_sprite_ext(spr_ttwob_doodlepaper, paper.index, x, y, paper.scale, paper.scale, 0, c_white, 1)
	draw_surface(paperSurf, x - 100, y - 100)
	
	paper.scale = approach(paper.scale, 1, 0.1)
}