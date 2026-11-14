isSecretStart = string_pos("secret", string_letters(room_get_name(room))) > 0 || room == hotel_soundtest || room = hotel_soundtestentrance;

var _char = instance_exists(obj_player) ? obj_player.character : -4
var _arr = [
	[mu_hubextra, room == hotel_extra],
	
	[mu_crashoutcity, room == crashout_1],
	[mu_rockbottom, room == rockbottom_1],
	[mu_beaker, room == beaker_1],
	
	[mu_frontyard, room == frontyard_1],
	
	[mu_yardMilton, _char == chars.milton && room == yard_1],
	[mu_crashoutcity, _char == chars.bacon_crash && room == yard_1],
	[mu_rockbottom, _char == chars.bacon_dream && room == yard_1],
	[mu_beaker, _char == chars.bacon_twist && room == yard_1],
	[mu_yard, room == yard_1],
	
	[mu_shellcityA, room == shell_1],
	
	[mu_bossbacon, room == boss_bacon],

]

if !global.escapeActive
{
	for (var i = 0; i < array_length(_arr); i++)
	{
		var _q = _arr[i]
		if _q[1]
		{
			if !audio_is_playing(_q[0])
			{
				stop_music(false)
				scr_music(_q[0], true)
			}
			break
		}
	}
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

if (secretInst != -4)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret);
