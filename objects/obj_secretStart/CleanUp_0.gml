if cutscene
{
	with (obj_player)
	{
		jumpstop = true;
		vsp = 10;
		state = states.groundpound;
		sprite_index = sprites.groundpound;
		xscaleMulti = 1;
		yscaleMulti = 1;
		roomstartX = x;
		roomstartY = y;
	}
}