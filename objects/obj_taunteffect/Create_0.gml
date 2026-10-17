image_speed = 0.35;
target = obj_player;
destroy = false;
depth = 18;
photoSurf = -4
photoIndex = irandom_range(0, sprite_get_number(spr_tauntEffectBackground) - 1);

if global.modded_phototaunt
{
	alarm[0] = 2
	image_angle = irandom_range(-5, 15);
	sprite_index = spr_taunteffect_old
	instance_create_online(other.x, other.y, other.depth + 2, obj_onlineTauntEffect, {oldtaunt: global.modded_phototaunt, sprite_index: sprite_index, image_angle: 0, photoIndex: photoIndex});
}
else
	instance_create_online(other.x, other.y, other.depth + 2, obj_onlineTauntEffect);