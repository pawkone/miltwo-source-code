with obj_player
{
	if door != "A"
	{
		instance_destroy(other)
		exit
	}
	door = "NONE"
	state = -4
	xscale = 1
	x = obj_doorA.x;
	y = -755
	sprite_index = spr_player3_slipbanan1;
	image_speed = 0;
	image_index = image_number-1
}
if instance_exists(obj_titlecard) instance_destroy(obj_titlecard)
if instance_exists(obj_fadeout) instance_destroy(obj_fadeout)
with instance_create(0, 0, obj_fadeout)
{
	image_alpha = 1
	accel = 0.05
	fadein = 0
}
fakeVsp = 5;
depth = -600;
