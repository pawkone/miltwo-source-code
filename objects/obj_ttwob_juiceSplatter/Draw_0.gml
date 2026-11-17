if !surface_exists(tileSurf)
	tileSurf = surface_create(sprite_width * scale, sprite_height * scale)
var _x = surface_get_width(tileSurf) / 2
var _y = surface_get_height(tileSurf) / 2
surface_set_target(tileSurf)
draw_clear_alpha(c_black, 0)
draw_tilemap(tiles, 0 - x + _x, 0 - y + _y)
gpu_set_blendmode(bm_subtract)
draw_sprite_ext(spr_ttwob_juiceSplatterMask, 0, _x, _y, scale, scale, image_angle, c_white, 1)
gpu_set_blendmode(bm_normal)
gpu_set_colorwriteenable(1, 1, 1, 0)
if spr_pal >= 0 && pal_index > 0
	pal_swap_set(spr_pal, pal_index, false)
draw_sprite_ext(spr_ttwob_juiceSplatter, 0, _x, _y, scale, scale, image_angle, c_white, 1)
if spr_pal >= 0 && pal_index > 0
	shader_reset()
gpu_set_colorwriteenable(1, 1, 1, 1)
surface_reset_target()
draw_set_alpha(0.5)
draw_surface(tileSurf, x - _x, y - _y)
draw_set_alpha(1)