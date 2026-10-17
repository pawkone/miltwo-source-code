isSecretStart = string_pos("secret", string_letters(room_get_name(room))) > 0 || room == hotel_soundtest || room = hotel_soundtestentrance;

if !audio_is_playing(mu_hubextra) && room == hotel_extra && !global.escapeActive
{
	stop_music(false)
	scr_music(mu_hubextra, true)
}
if !audio_is_playing(mu_rockbottom) && room == rockbottom_1 && !global.escapeActive
{
	stop_music(false)
	scr_music(mu_rockbottom, false)
}
if !audio_is_playing(mu_crashoutcity) && room == crashout_1 && !global.escapeActive
{
	stop_music(false)
	scr_music(mu_crashoutcity, false)
}
if !audio_is_playing(mu_frontyard) && room == frontyard_1 && !global.escapeActive
{
	stop_music(false)
	scr_music(mu_frontyard, false)
}
if !audio_is_playing(mu_beaker) && room == beaker_intro && !global.escapeActive
{
	stop_music(false)
	scr_music(mu_beaker, false)
}

if (ds_map_exists(musicDetails, room))
{
    var _map = ds_map_find_value(musicDetails, room);
    
    if (music.regular != _map.music && !global.escapeActive)
    {
		scr_music(-4, true)
        if (musicInst != -4)
        {
            fmod_studio_event_instance_stop(musicInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
            fmod_studio_event_instance_release(musicInst);
            musicInst = -4;
        }
        
        if (_map.music != -4)
        {
            music.regular = _map.music;
            musicInst = FMODcreate_event(_map.music);
            fmod_studio_event_instance_start(musicInst);
        }
    }
    
    if (music.ambience != _map.ambience && !global.escapeActive)
    {
        if (ambienceInst != -4)
        {
            fmod_studio_event_instance_stop(ambienceInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
            fmod_studio_event_instance_release(ambienceInst);
            ambienceInst = -4;
        }
        
        if (_map.ambience != -4)
        {
            music.ambience = _map.ambience;
            ambienceInst = FMODcreate_event(_map.ambience);
            fmod_studio_event_instance_start(ambienceInst);
        }
    }
    
    if (music.secret != _map.secret)
    {
        if (secretInst != -4)
        {
            fmod_studio_event_instance_stop(secretInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
            fmod_studio_event_instance_release(secretInst);
            secretInst = -4;
        }
        
        if (_map.secret != -4)
        {
            music.secret = _map.secret;
            secretInst = FMODcreate_event(_map.secret);
            fmod_studio_event_instance_start(secretInst);
        }
    }
    
    func = _map.func;
}

fmod_studio_event_instance_set_paused(escapeInst, isSecret);

if (musicInst != -4)
    fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst));

if (ambienceInst != -4)
    fmod_studio_event_instance_set_paused(ambienceInst, isSecret || FMODevent_isplaying(ambienceInst));

if (secretInst != -4)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret);
