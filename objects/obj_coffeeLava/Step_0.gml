with obj_player
{
	if place_meeting(x,y,other)
	{
		state = states.burned
		vsp = -20;
		sprite_index = spr_player3_burn;
        image_index = 0;
		movespeed = hsp;
		
		if !audio_is_playing(sfx_player_bt_scream)
			scr_soundeffect(sfx_player_bt_scream,random_range(0.85,1.15));	
			
		scr_soundeffect(sfx_fireass,random_range(0.85,1.15))
	}	
}