if (ds_list_find_index(global.saveroom, id) != -1)
    instance_destroy();
else
{
	if obj_player.character == chars.fries4 && object_index == obj_metalblock
	{
		with instance_create_depth(x,y,depth,obj_metalblockfries4)
		{
			image_xscale = other.image_xscale
			image_yscale = other.image_yscale
			idorignal = other.id
		}
		instance_destroy(id, false)
	}
}
