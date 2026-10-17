var h1 = sprite_get_height(sprite_index)
draw_set_alpha(1)
draw_rectangle_colour(bbox_left,bbox_top,bbox_right,bbox_bottom,c_white,c_white,c_white,c_white,false)
if !premode
{
	if (bgalpha > 0)
	{
		var cx = camera_get_view_x(view_camera[0]), cy = camera_get_view_y(view_camera[0])
		if !surface_exists(surf)
			surf = surface_create(bbox_right-bbox_left, bbox_bottom-bbox_top)
	    surface_set_target(surf)
		draw_clear(c_white)
	    for (var i = 0; i < array_length(gateinfo); i++)
	    {
	        var q = gateinfo[i]
	        if !q[6]
	        {
				q[2] += q[4]
	            q[3] += q[5]
	        }
	        else
	        {
	            q[2] = (960 - (cx * 0.05)) + (960 / 5)
	            q[3] = (540 - (cy * 0.05) - (540 / 2)) + 8
	        }
	        draw_sprite_tiled(q[0], q[1], q[2], q[3])
	    }
	    surface_reset_target()
	    draw_surface_ext(surf, bbox_left, bbox_top,1,1,0,c_white,bgalpha)
	}
}
draw_self();
