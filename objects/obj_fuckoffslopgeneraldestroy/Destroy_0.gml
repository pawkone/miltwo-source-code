if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
	with create_particleDebri(spr_fuckoffslopgeneraldestroy, 0, x, y, image_xscale, -1)
	{
		image_angle = 0
		hsp = sign((bbox_left+bbox_right)/2-obj_player.x)*random_range(10,17)
		vsp = -random_range(7,12)
	}
}