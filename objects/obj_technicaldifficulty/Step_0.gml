if (showTechnical == false)
{
    staticIndex += 0.35;
    if (staticIndex >= (sprite_get_number(spr_tvstatic) - 0.35))
    {
        showTechnical = true;
        showStatic = false;
        staticIndex = 0;
        alarm[0] = tim;
    }
}
else if (showTechnical == true)
{
    if (showStatic)
        staticIndex += 0.35;
    if (staticIndex >= (sprite_get_number(spr_tvstatic) - 0.35))
	{
		if is_callable(func)
			func()
		else
		{
			with (obj_player)
			{
			    state = scr_player_normal;
			    hsp = 0;
			    vsp = 0;
			    movespeed = 0;
			    x = roomstartX;
			    y = roomstartY;
			}
		}
        instance_destroy();
	}
}
