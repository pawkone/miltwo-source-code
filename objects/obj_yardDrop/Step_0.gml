y += vsp

if sprite_index == spr_yardDropLand
{
	if animation_end()
		instance_destroy()
	exit
}
if y < 256 exit

if y > room_height+10
	instance_destroy()
else if (!place_meeting(x,y,obj_solid) && place_meeting(x,y+vsp,obj_solid))
|| (!place_meeting(x,y,obj_platform) && place_meeting(x,y+vsp,obj_platform))
|| (!scr_slope(x,y) && scr_slope(x,y+vsp))
{
	var _i = 0
	while (!place_meeting(x,y+_i,obj_solid) && !place_meeting(x,y+_i,obj_platform) && !scr_slope(x,y+_i) && _i < 48)
		_i += 4
	y += _i
	vsp = 0
	gravity = 0
	hspeed = 0
	sprite_index = spr_yardDropLand
	image_speed = 0.175+random(0.35)
}