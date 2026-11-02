with instance_place(x,y,obj_player)
{
	var _states = [scr_player_water, scr_player_noclip]
	if !array_contains(_states, state) && !is_transfo_all()
	{
		movespeed = hsp
		state = scr_player_water
	}
}