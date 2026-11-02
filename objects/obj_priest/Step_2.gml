with instance_place(x,y,obj_player)
{
	if !is_transfo_all()
	    break;

	flash = true
	if (pky_run)
	{
		state = scr_player_mach2;
		sprite_index = sprites.mach2;
	}
	else
	{
		state = scr_player_normal;
		sprite_index = sprites.idle;
	}

	with other
	{
		sprite_index = spr_priest_pray;
		alarm[0] = 250;
	}
}