function scr_player_burned()
{
	image_speed = 0.35;
	sprite_index = spr_player3_burn;
	move = pky_right + pky_left;
	hsp = movespeed;
	movespeed = approach(movespeed,move*9,0.5);
	
	with instance_place(x+hsp,y+vsp,obj_stupidcabbit)
		instance_destroy()
	
	if (grounded && vsp > 0 && (!place_meeting(x,y+1,obj_stupidcabbit)))
	{
		movespeed = 0;
		state = states.normal;
		image_index = 0;
	}
}
