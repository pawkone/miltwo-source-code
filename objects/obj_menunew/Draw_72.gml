draw_sprite(spr_menunew, 1, 0, 0)

if !surface_exists(surf)
	surf = surface_create(960,540)
surface_set_target(surf)
draw_clear(c_black)