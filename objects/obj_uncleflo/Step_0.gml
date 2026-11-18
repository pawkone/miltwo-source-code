if (global.escapeActive)
{
    text = "[wave]BRO YOU GOTTA LEAVE BRO!";
    if (place_meeting(x, y, obj_player))
    {
        instance_destroy();
        with (instance_create(x, y, obj_baddiedead))
        {
            image_speed = 0;
            sprite_index = spr_flodead;
        }
    }
}

if (distance_to_object(obj_player) < 16)
{
    if (sprite_index != spr_talk)
    {
        sprite_index = spr_talk;
        image_index = 0;
        
		if is_string(snd_voicestr)
		{
			if snd_voice < 0
				snd_voice = FMODcreate_event(snd_voicestr)
		    if !FMODevent_isplaying(snd_voice)
		        fmod_studio_event_instance_start(snd_voice)
		    FMODSet3dPos(snd_voice, x, y)
		}
		else if audio_exists(snd_voicestr) && !(audio_exists(snd_voice) && audio_is_playing(snd_voice))
			snd_voice = scr_soundeffect(snd_voicestr, random_range(0.95,1.05))
    }
    
    switch (borderpart)
    {
        case 0:
            borderY = approach(borderY, 43, borderVsp);
            borderVsp += 0.5;
            
            if (borderY >= 43)
                borderpart++;
            
            break;
        
        case 1:
            borderY = lerp(borderY, 37-abs(sin((current_time/1000)*pi))*5, 0.15);
            break;
    }
}
else
{
    borderpart = 0;
    borderVsp = 0;
    borderY = approach(borderY, -160, 5);
    sprite_index = spr_idle;
}
if borderY > -140.16 * borderscaleYmult
{
	var _t = current_time/2000
	if _t mod 2 < 1
		borderX = 32 + abs(sin(_t*2*pi))*7
	else
		borderX = 32 - abs(sin(_t*2*pi))*7
}
