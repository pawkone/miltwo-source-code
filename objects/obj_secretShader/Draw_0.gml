if obj_secretManager.patternAlpha <= 0
	exit

var _w = ceil(camera_get_view_width(view_camera[0]))
var _h = ceil(camera_get_view_height(view_camera[0]))
var _x = camera_get_view_x(view_camera[0])
var _y = camera_get_view_y(view_camera[0])

if !surface_exists(tileSurf)
    tileSurf = surface_create(_w, _h)

if surface_get_width(tileSurf) != _w || surface_get_height(tileSurf) != _h
	surface_resize(tileSurf, _w, _h)

surface_set_target(tileSurf)
draw_clear_alpha(c_black, 0)
shader_sset(shd_pattern)
var p = obj_secretManager.thing_p
texture_set_stage(global.patternColors, obj_secretManager.thing_q)
shader_set_uniform_f(global.patternUVs, p[0], p[1], p[2], p[3])
shader_set_uniform_f(global.patternTexel, obj_secretManager.thing_s)
draw_set_alpha(1)
draw_tilemap(tile, -_x, -_y)
shader_reset()
gpu_set_blendmode(bm_min)
draw_sprite_tiled(spr_tileDoodles, obj_secretManager.patternIndex, -_x, -_y + obj_secretManager.patternPos + depth)
gpu_set_blendmode_default()
surface_reset_target()
draw_set_alpha(obj_secretManager.patternAlpha)
pal_swap_set(spr_whitefix, 1, false)
draw_surface(tileSurf, _x, _y)
shader_reset()
draw_set_alpha(1)