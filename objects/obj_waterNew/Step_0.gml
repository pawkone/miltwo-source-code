with instance_place(x,y,obj_player)
{
	var _states = [states.water, states.noclip]
	if !array_contains(_states, state) && !is_transfo_all()
	{
		movespeed = hsp
		state = states.water
	}
}