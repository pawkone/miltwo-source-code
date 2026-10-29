visible = true
image_speed = 0.35;
if global.modded_phototaunt && sprite_index == spr_taunteffect
{
	photoIndex = irandom_range(0, sprite_get_number(spr_tauntEffectBackground) - 1);
	image_angle = irandom_range(-5, 15);
	sprite_index = spr_taunteffect_old
}