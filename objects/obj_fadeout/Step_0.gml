if fadein
{
    image_alpha += accel
    if image_alpha >= 1
    {
        room_goto(targetRoom)
        fadein = false
    }
}
else
{
    image_alpha -= accel
    if image_alpha <= 0
        instance_destroy()
}
