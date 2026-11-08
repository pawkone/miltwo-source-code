function scr_hudNGAB2_init()
{
}
function scr_hudNGAB2_step()
{
	

	if (!ds_list_empty(collectVis))
	{
	    for (var i = 0; i < ds_list_size(collectVis); i++)
	    {
	        var q = ds_list_find_value(collectVis, i);
        
	        with (q)
	        {
	            var targetxx = other.kettle.x;
	            var targetyy = other.kettle.y;
	            var point = point_direction(x, y, targetxx, targetyy);
	            hsp = lengthdir_x(24, point);
	            vsp = lengthdir_y(24, point);
	            x += hsp;
	            y += vsp;
            
	            if (point_distance(x, y, targetxx, targetyy) <= 25)
	            {
	                with (other)
	                {
	                    kettle.shake = 5;
	                    q = undefined;
	                    ds_list_delete(collectVis, i);
	                    i--;
	                }
	            }
	        }
	    }
	}
}
function scr_hudNGAB2_draw()
{
}
function scr_hudNGAB2_clean()
{
}