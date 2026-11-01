speed -= 0.5
if speed < 0
{
	anglespd += 2
	if place_meeting(x,y,obj_beant)
	{
		instance_destroy()
		exit
	}
}
else
	anglespd = lerp(anglespd, 6, 0.2)
image_angle += anglespd