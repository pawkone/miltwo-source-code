x += hsp
y += vsp
vsp += grav

var _mult = 1
if instance_exists(obj_pumpkinController) && obj_pumpkinController.dark
	_mult = ((obj_pumpkinController.circleSizeLrp+50)-point_distance(obj_player.x, obj_player.y, x, y))/150
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha*_mult)