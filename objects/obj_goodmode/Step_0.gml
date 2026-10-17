instance_destroy(obj_transition_hotel2)
instance_destroy(obj_characterswitch)
obj_player.character = chars.preoutman
obj_player.sfx.jump = sfx_player_bt_ballbounce
obj_player.sfx.step = sfx_player_bc_grab
global.showcollisions = true
global.debug = false
obj_player.hsp *= random_range(0.9, 1.1)
obj_player.movespeed *= random_range(0.9, 1.1)
obj_player.grav = random(1.5)
if obj_player.state == states.uppercut || obj_player.state == states.groundpound || obj_player.state == states.groundpoundstart
{
	if obj_player.state == states.groundpoundstart
		obj_player.state = states.groundpound
	obj_player.vsp += 4
	with obj_player
	{
		with instance_place(x,y+1,obj_destructibles)
			instance_destroy()
	}
}
repeat 50
	instance_create(0,0,obj_yardDrop)
with obj_yardDrop
{
	image_alpha = random(1)
	hspeed *= random_range(0.9, 1.1)
	vspeed *= random_range(0.9, 1.1)
	image_xscale *= random_range(0.9, 1.1)
	image_yscale *= random_range(0.9, 1.1)
}
obj_player.xscaleMulti = 1-(abs(sin(current_time/150))*0.5)
obj_player.yscaleMulti = 2-obj_player.xscaleMulti
obj_player.mask_index = spr_baddie
with obj_baddie
{
	if irandom(70+instance_number(object_index)*3) == 65
		instance_destroy()
	else if irandom(70+instance_number(object_index)*3) == 65
		instance_create(irandom(room_width),irandom(room_height),object_index)
}
with obj_solid
{
	if object_index == obj_solid
	{
		if place_meeting(x-obj_player.hsp-obj_player.xscale,y-obj_player.vsp,obj_player)
		{
			for (var i = 0; i < image_xscale; i++)
			{
				for (var j = 0; j < image_yscale; j++)
					instance_create(x+i*32,y+j*32,obj_destroyable_secret2)
			}
			instance_destroy()
		}
		if random(100) > 97
		{
			if distance_to_object(obj_player) > 300 && distance_to_object(obj_hallway) > 500
			{
				x += random_range(-8,8)
				y += random_range(-8,8)
			}
		}
	}
}
with obj_slope
{
	if random(100) > 97
	{
		if distance_to_object(obj_player) > 300 && distance_to_object(obj_hallway) > 500
		{
			x += random_range(-8,8)
			y += random_range(-8,8)
		}
	}
}