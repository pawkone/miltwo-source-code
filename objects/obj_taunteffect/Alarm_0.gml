visible = true
image_speed = 0.35;
if (scr_getera() == "TTWOB" || global.modded_phototaunt) && sprite_index == spr_taunteffect
{
	photoOn = true
	photoIndex = irandom_range(0, sprite_get_number(spr_tauntEffectBackground) - 1)
	photoMask = sprite_getera(spr_taunteffectMask)
	sprite_index = sprite_getera(spr_taunteffect_old)
	image_angle = irandom_range(-5, 15)
}