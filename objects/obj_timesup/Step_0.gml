if mky_jump2 && global.escapeLap == 3
{
	alarm[1] = -1
	event_user(0)
	exit
}
with (obj_player)
{
    if (sprite_index == sprites.gateslam)
	{
	    state = -4
		xscale = 1
	    x = 960 / 2;
	    y = 540 / 2;
		visible = true
		xscaleMulti = 1
		yscaleMulti = 1
		squashY = 1
		squashX = 1
        hsp = 0;
        vsp = 0;
		
        if (animation_end())
            image_index = image_number - 1;
        
        if (place_meeting(x, y, obj_timesup))
        {
            hsp = 4;
            vsp = -10;
            sprite_index = spr_player_hurt;
        }
    }
}

if (falling)
{
    y = approach(y, 540 / 2, vsp);
    vsp += 1;
}
