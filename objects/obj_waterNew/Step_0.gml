with instance_place(x,y,obj_player)
{
	if state != states.water && state != states.taunt
	{
		movespeed = hsp
		state = states.water
	}
}