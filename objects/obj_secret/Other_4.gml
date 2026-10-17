if (ds_list_find_index(global.saveroom, id) != -1)
{
	if (obj_player.door == "DOODLE")
	{
		global.secretOriginRoom = -4
		obj_player.x = x;
		obj_player.y = y;
		obj_player.state = -4
		instance_create(x, y, obj_secretStart).image_xscale = image_xscale;
	}
    instance_destroy();
}