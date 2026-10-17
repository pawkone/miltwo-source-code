layer_set_visible("Tiles_3", true)
layer_set_visible("Tiles_4", true)
layer_set_visible("Tiles_5", false)
with instance_create(4195,547,obj_solid)
{
	image_xscale = 12
	image_yscale = 22
}
with instance_create(4579,-93,obj_solid)
{
	image_xscale = 28
	image_yscale = 22
}
with instance_create(5379,451,obj_solid)
{
	image_xscale = 12
	image_yscale = 36
}
with instance_create(3584,1600,obj_solid)
{
	image_xscale = 63
	image_yscale = 4
}
with instance_create(3360,1184,obj_solid)
{
	image_xscale = 38
	image_yscale = 11
}
with instance_create(4576,1312,obj_solid)
{
	image_xscale = 13
	image_yscale = 4
}
with instance_create(4832,1248,obj_solid)
{
	image_xscale = 5
	image_yscale = 2
}
with instance_create(4736,1248,obj_slope)
{
	image_xscale = 3
	image_yscale = 2
}
with instance_create(5056,928,obj_solid)
{
	image_xscale = 10
	image_yscale = 4
}
with instance_create(4832,928,obj_platform)
	image_xscale = 7
with instance_create(4896,928,obj_ladder)
	image_yscale = 8
with instance_create(4896,928,obj_jellyfish)
{
	image_yscale = 8
	sprite_index = spr_ladder
	depth = layer_get_depth("Tiles_2")-1
}
with instance_create(5105,672,obj_floorgate)
{
	slow = true
	palette = 1
	enterfunc = function()
	{
		entering = false
		timer = 0
		openned = true
		with obj_player
		{
			instance_create(0,0,obj_goodmode)
			visible = true
			image_speed = 0.35
			state = states.slip
			xscale = choose(-1,1)
			movespeed = 100
			vsp = -66
			sprite_index = spr_player_slipsyrup
			image_index = 0
			FMODevent_oneshot("event:/Sfx/Player/slip", x, y)
		}
	}
	targetDoor = "E"
	depth = 650
	event_perform(ev_other, ev_room_start)
	exiting = false
}
instance_create(3424,1536,obj_destroyable_secret1)
instance_create(3424,1536,obj_destroyable_secret1)
instance_create(3648,1568,obj_destroyable_secret2)
instance_create(3616,1536,obj_destroyable_secret2)
instance_create(3616,1568,obj_destroyable_secret2)
instance_create(3648,1536,obj_destroyable_secret2)
instance_create(3680,1536,obj_destroyable_secret1)
instance_create(3520,1568,obj_destroyable_secret2)
instance_create(3488,1536,obj_destroyable_secret2)
instance_create(3488,1568,obj_destroyable_secret2)
instance_create(3520,1536,obj_destroyable_secret2)
instance_create(3552,1536,obj_destroyable_secret1)
instance_create(3904,1568,obj_destroyable_secret2)
instance_create(3872,1536,obj_destroyable_secret2)
instance_create(3872,1568,obj_destroyable_secret2)
instance_create(3904,1536,obj_destroyable_secret2)
instance_create(3936,1536,obj_destroyable_secret1)
instance_create(3776,1568,obj_destroyable_secret2)
instance_create(3744,1536,obj_destroyable_secret2)
instance_create(3744,1568,obj_destroyable_secret2)
instance_create(3776,1536,obj_destroyable_secret2)
instance_create(3808,1536,obj_destroyable_secret1)
instance_create(4160,1568,obj_destroyable_secret2)
instance_create(4128,1536,obj_destroyable_secret2)
instance_create(4128,1568,obj_destroyable_secret2)
instance_create(4160,1536,obj_destroyable_secret2)
instance_create(4192,1536,obj_destroyable_secret1)
instance_create(4032,1568,obj_destroyable_secret2)
instance_create(4000,1536,obj_destroyable_secret2)
instance_create(4000,1568,obj_destroyable_secret2)
instance_create(4032,1536,obj_destroyable_secret2)
instance_create(4064,1536,obj_destroyable_secret1)
instance_create(4416,1568,obj_destroyable_secret2)
instance_create(4384,1536,obj_destroyable_secret2)
instance_create(4384,1568,obj_destroyable_secret2)
instance_create(4416,1536,obj_destroyable_secret2)
instance_create(4448,1536,obj_destroyable_secret1)
instance_create(4288,1568,obj_destroyable_secret2)
instance_create(4256,1536,obj_destroyable_secret2)
instance_create(4256,1568,obj_destroyable_secret2)
instance_create(4288,1536,obj_destroyable_secret2)
instance_create(4320,1536,obj_destroyable_secret1)
with obj_solid
{
	if x == 3360 && y == 1248
	{
		instance_destroy()
		break
	}
}