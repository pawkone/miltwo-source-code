function scr_player_uppercut()
{
	if character == chars.valentia
	{
		scr_playerV_uppercut()
		exit
	}
	
    var move = pky_right + pky_left;
    hsp = approach(hsp, movespeed * move, 0.8);
    
    if (move != 0)
        movespeed = 6;
    
    image_speed = 0.4;
    
    if (vsp < 0)
    {
        buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
        
        if (buffers.afterimageMach == 0)
        {
            buffers.afterimageMach = 4;
            create_machEffect(sprite_index, image_index, x, y, xscale, 1);
        }
    }
    
    if (animation_end())
        image_index = image_number - 1;
    
	if character == chars.fries4 && scr_solid(x+hsp,y+vsp)
	{
		var _targetdir = ""
		if -pky_left _targetdir = point_direction(0,0,-1,0)
		if pky_right _targetdir = point_direction(0,0,1,0)
		if pky_up _targetdir = point_direction(0,0,0,-1)
		if pky_down _targetdir = point_direction(0,0,0,1)
		if -pky_left&&pky_up _targetdir = point_direction(0,0,-1,-1)
		if pky_right&&pky_up _targetdir = point_direction(0,0,1,-1)
		if -pky_left&&pky_down _targetdir = point_direction(0,0,-1,1)
		if pky_right&&pky_down _targetdir = point_direction(0,0,1,1)
		if _targetdir != ""
			direction = _targetdir
		else
			direction = 90
		state = states.fries4wall
		exit
	}
	
    if (grounded && vsp > 0)
    {
        create_particleStatic(spr_landeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = (move != 0) ? sprites.land2 : sprites.land;
        state = states.normal;
        plrsnds_play(sfx.step, x, y);
        movespeed = abs(hsp);
        
        if (move != 0)
            xscale = move;
        
        hsp = movespeed * xscale;
    }
}
