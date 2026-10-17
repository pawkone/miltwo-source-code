if premode exit
if (!ds_list_empty(particles))
{
	var _on = instance_exists(obj_pumpkinController) && obj_pumpkinController.dark
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        depth = q.depth;
		var _mult = 1
		if _on
			_mult = ((obj_pumpkinController.circleSizeLrp+50)-point_distance(obj_player.x, obj_player.y, q.x, q.y))/150
        with (q)
            draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, 1, image_angle, c_white, 1*_mult);
    }
}
