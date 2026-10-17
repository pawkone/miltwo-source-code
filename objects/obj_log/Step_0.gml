with obj_player
{
	if place_meeting(x,y+1,other) && grounded && !other.actived
	{
		other.alarm[0] = 30;
		other.alarm[1] = 180;
		other.actived = true
	}
}
if falling
{
	x = xstart
	vsp += 0.5
	y += vsp
}
else if actived
{
	x = xstart + irandom_range(-16,16)
	y = ystart
}

else
{
	x = xstart
	y = ystart
}

if actived && !falling
{
	if sfx < 0
		sfx = scr_soundeffect(sfx_logactivated,,true)
}
else if sfx >= 0
{
	audio_stop_sound(sfx)
	sfx = -4
}