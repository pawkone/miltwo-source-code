function scr_hudNGAB2_init()
{
	hud_alpha = 0
	kettle = {};
	kettle.x = 124;
	kettle.y = 54;
	kettle.kx = kettle.x;
	kettle.ky = kettle.y;
	kettle.rankScale = 0;
	kettle.previousRank = 0;
	kettle.cloudIndex = 0;
	kettle.offset = 0;
	kettle.shake = 0;
	tv = {};
	tv.state = scr_player_normal;
	tv.sprite_index = spr_tv_off;
	tv.image_index = 0;
	tv.image_speed = 0.35;
	tv.x = 960 - 132;
	tv.y = 73;
	tv.expressionSprite = spr_tv_idle;
	tv.expressionTimer = 0;
	tv.switchindex = 0;
	tv.offset = 0;
	combometer = {};
	combometer.x = 811;
	combometer.y = 237;
	combometer.arrowx = combometer.x;
	combometer.vsp = 0;
	combometer.state = -1;
	combometer.lights = [];

	repeat (4)
	{
	    array_push(combometer.lights, 
	    {
	        on: true,
	        sprite: spr_comboLights,
	        x: 0,
	        y: 0,
	        index: 0
	    });
	}

	bar = {};
	bar.x = 960 / 2;
	bar.y = 540 - 100;
	bar.sparkIndex = 0;
	bar.spacePos = 0;
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
	delete tv
	tv = -4
	delete kettle
	kettle = -4
	for (var i = 0; i < array_length(combometer.lights); i++)
	{
		delete combometer.lights[i]
		combometer.lights[i] = -4
	}
	delete combometer
	combometer = -4
	delete bar
	bar = -4
}