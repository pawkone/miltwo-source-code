if (ds_list_find_index(global.saveroom, id) != -1) || (ifDoodleAlwaysExit && obj_player.door == "DOODLE")
{
	if (obj_player.door == "DOODLE")
	{
		obj_player.x = x;
		obj_player.y = y;
		obj_player.state = -4
		with instance_create(x, y, obj_secretStart)
		{
			regenerate = other.regenerate
			targetRoom = other.targetRoom
			image_xscale = other.image_xscale
		}
	}
    instance_destroy();
}