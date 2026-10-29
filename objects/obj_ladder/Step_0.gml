with (instance_place(x, y - 1, obj_player))
{
	if (pky_up && pky_down) exit
    if ((pky_up && place_meeting(x, y, obj_ladder)) || ((pky_down && grounded && place_meeting(x, y + 1, obj_ladder) && !place_meeting(x, y + 1, obj_solid)) && (state == states.normal || state == states.jump || state == states.freefallland || state == states.crouch || state == states.tumble)))
    {
        state = states.ladder;
        hsp = 0;
        movespeed = 0;
        
        if (pky_down && grounded && !pky_up)
		{
			repeat 32
			{
				if !place_meeting(x, y, obj_ladder)
					 y++
			}
		}
    }
}
