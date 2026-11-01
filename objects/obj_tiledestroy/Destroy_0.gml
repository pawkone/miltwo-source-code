if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
	with obj_tiledestroy
	{
		if id != other.id && place_meeting(x,y,other)
			instance_destroy()
	}
}

for (var _y = 0; _y < abs(sprite_height / 32); _y++)
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
        tile_delete(x + (_x * 32), y + (_y * 32));
}