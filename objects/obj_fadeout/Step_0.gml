if fadein
{
    image_alpha += accel
    if image_alpha >= 1
    {
		if room_exists(targetRoom)
			room_goto(targetRoom)
		else
			instance_destroy()
        fadein = false
    }
}
else
{
    image_alpha -= accel
    if image_alpha <= 0
        instance_destroy()
}
