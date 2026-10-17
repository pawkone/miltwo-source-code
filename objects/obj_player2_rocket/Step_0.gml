timer++
if timer > 7
{
	timer = 0
	create_machEffect(sprite_index, image_index, x, y, image_xscale)
}
vspeed -= 0.35