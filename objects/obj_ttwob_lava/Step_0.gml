with obj_player
{
	if place_meeting(x,y,other) && !scr_solid(x,y)
	{
		state = scr_player_burned
		vsp = -20;
		sprite_index = spr_player3_burn;
        image_index = 0;
		movespeed = hsp;
		
		if !audio_is_playing(sfx.voice_scream)
			scr_soundeffect(sfx.voice_scream,random_range(0.85,1.15));	
			
		scr_soundeffect(sfx_ttwob_fireass,random_range(0.85,1.15))
	}	
}