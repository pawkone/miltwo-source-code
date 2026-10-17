if (currentRoom == oldcurrentRoom)
{
	xlerp = lerp(xlerp, x, 0.4)
	ylerp = lerp(ylerp, y, 0.4)
}
else
{
	oldcurrentRoom = currentRoom
	xlerp = x
	ylerp = y
}
if (currentRoom == room)
{
	alpha = image_alpha/(paused+1)
	if sprite_exists(sprite_index)
		ylerpname = lerp(ylerpname, sprite_get_bbox_top(sprite_index), 0.05)
	if (breakdance)
	{
	    if (breakdanceID == -4)
	    {
	        with (instance_create(x, y, obj_beatbox))
	        {
	            other.breakdanceID = id;
	            target = other.id;
	        }
	    }
	    if (!instance_exists(breakdanceID))
	        breakdanceID = -4;
	}
}