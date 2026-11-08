if obj_player.door != "A"
{
	instance_destroy()
	exit
}
if instance_exists(obj_titlecard)
	instance_destroy(obj_titlecard)
instance_destroy(obj_fadeout)
with instance_create(0, 0, obj_fadeout)
{
	image_alpha = 1
	accel = 0.05
	fadein = 0
}
start = 0;
fakeVsp = 28;
depth = -600;
