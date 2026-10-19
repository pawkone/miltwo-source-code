if global.modded_phototaunt
{
	if !surface_exists(photoSurf)
		photoSurf = surface_create(110, 110)
	surface_set_target(photoSurf)
	draw_clear_alpha(c_black, 0)
	gpu_set_blendmode_ext(bm_one, bm_zero)
	draw_sprite_ext(spr_taunteffectMask, image_index, 55, 55, 1, 1, image_angle, c_white, 1)
	gpu_set_blendmode_ext(bm_dest_alpha, bm_zero)
	draw_sprite_ext(spr_tauntEffectBackground, photoIndex, 55, 55, 1, 1, image_angle, c_white, 1)
	gpu_set_blendmode_default()
	surface_reset_target()
	draw_set_alpha(image_alpha)
	draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, image_angle, c_white, image_alpha)
	draw_surface(photoSurf, x - 55, y - 55)
	draw_set_alpha(1)
}
else
	draw_self()