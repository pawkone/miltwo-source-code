with (instance_place(x, y - 1, obj_player))
{
	if (pky_up && pky_down) exit
    if ((pky_up && place_meeting(x, y, obj_ladder)) || ((pky_down && grounded && place_meeting(x, y + 1, obj_ladder) && !place_meeting(x, y + 1, obj_solid)) && (state == scr_player_normal || state == scr_player_jump || state == scr_player_freefallland || state == scr_player_crouch || state == scr_player_tumble)))
    {
        state = scr_player_ladder;
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
