if !instance_exists(obj_secretManager)
{
	var _trans = is_transfo_all(obj_player.state)
	if _trans && audio_is_playing(mu_shellcityA)
		scr_music(mu_shellcityB, true, true)
	else if !_trans && audio_is_playing(mu_shellcityB)
		scr_music(mu_shellcityA, true, true)
				
	var _pitch = 1
	if room == shell_5 || room == shell_6 || room == shell_7 || room == shell_10
		_pitch = 0.97
	if room == shell_11 || room == shell_12 || room == shell_13
		_pitch = 1.03
			
	pitchLrp = lerp(pitchLrp, _pitch, 0.05)
			
	if audio_exists(global.music)
		audio_sound_pitch(global.music, pitchLrp)
	if audio_exists(global.music_old)
		audio_sound_pitch(global.music_old, pitchLrp)
}



if !(global.escapeActive && global.escapeLap == 2)
	global.escapePartyOver = false
if !global.escapeActive
{
    panicStart = true;
    if audio_is_playing(mu_lap3)
		audio_stop_sound(mu_lap3)
    if (FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
}
else if (panicStart == true)
{
    panicStart = false;
	audio_stop_all()
    if (!FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_start(escapeInst);
}
else
{
    if !fmod_studio_event_instance_get_paused(musicInst)
        fmod_studio_event_instance_set_paused(musicInst, true);
    
	if (global.escapePartyOver)
	{
		if (FMODevent_isplaying(escapeInst))
		{
			stop_music(false)
			fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
		}
        if !audio_is_playing(mu_partyover)
			scr_music(mu_partyover, false)
	}
    else if (global.escapeLap == 3)
    {
		if (FMODevent_isplaying(escapeInst))
		{
			stop_music(false)
			fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
		}
        if !audio_is_playing(mu_lap3)
			scr_music(mu_lap3, true)
    }
	else
	{
		if audio_is_playing(mu_lap3)
			audio_stop_sound(mu_lap3)
	    if (global.escapeLap == 2)
	    {
			var _arr = [
				[chars.milton, mu_miltonlap2],
				[chars.pepperni, mu_peppernilap2],
				[chars.soda, mu_sodalap2],
				
				[chars.bacon_crash, mu_baconcrashlap2],
				[chars.bacon_dream, mu_bacondreamlap2],
				[chars.bacon_redem, mu_baconredemlap2],
				[chars.bacon_twist, mu_bacontwistlap2],
			]
			if instance_exists(obj_player)
			{
				for (var i = 0; i < array_length(_arr); i++)
				{
					if obj_player.character == _arr[i][0]
					{
						if FMODevent_isplaying(escapeInst)
						{
							stop_music(false)
							fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
						}
				        if !audio_is_playing(_arr[i][1])
							scr_music(_arr[i][1], false)
					}
				}
			}
		    fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 2);
		    fmod_studio_event_instance_set_callback(escapeInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT);
	    }
		else
		{
			var _arr = [
				[chars.pepperni, mu_peppernilap1],
				[chars.soda, mu_sodalap1],
				
				[chars.bacon_crash, mu_baconcrashlap1],
				[chars.bacon_dream, mu_bacondreamlap1],
				[chars.bacon_redem, mu_baconredemlap1],
				[chars.bacon_twist, mu_bacontwistlap1],
			]
			if instance_exists(obj_player)
			{
				for (var i = 0; i < array_length(_arr); i++)
				{
					if obj_player.character == _arr[i][0]
					{
						if FMODevent_isplaying(escapeInst)
						{
							stop_music(false)
							fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT)
						}
				        if !audio_is_playing(_arr[i][1])
							scr_music(_arr[i][1], false)
					}
				}
			}
			fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 0);
		}
	}
}

if (instance_exists(obj_monolith))
{
    if (!FMODevent_isplaying(monolith) && !FMODevent_isstarting(monolith))
        fmod_studio_event_instance_start(monolith);
    fmod_studio_event_instance_set_paused(monolith, false);
    var _cam = 0;
    with (obj_monolith)
        _cam = in_camera();
    pillar = approach(pillar, _cam, 0.016666666666666666);
}
else
{
    if (FMODevent_isplaying(monolith))
        fmod_studio_event_instance_stop(monolith, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
    
    pillar = 0;
}

fmod_studio_event_instance_set_parameter_by_name(monolith, "flitzani", pillar, true);
fmod_studio_system_set_parameter_by_name("singer", voices, true);
if (isSecret != isSecretStart)
{
    isSecret = isSecretStart;
    
    if (isSecret)
    {
		if audio_exists(global.music)
			audio_pause_sound(global.music)
		if audio_exists(global.music_old)
			audio_pause_sound(global.music_old)
        fmod_studio_event_instance_set_timeline_position(secretInst, (fmod_studio_event_instance_get_timeline_position(musicInst) / FMODget_eventLength(music.regular)) * FMODget_eventLength(music.secret));
    }
	else
	{
		if audio_exists(global.music)
			audio_resume_sound(global.music)
		if audio_exists(global.music_old)
			audio_resume_sound(global.music_old)	
	}
}

var q = 0;

if (musicInst >= 0)
    q = fmod_studio_event_instance_get_timeline_position(musicInst);

if (isSecret && secretInst >= 0)
    q = fmod_studio_event_instance_get_timeline_position(secretInst);

global.songCurInf.pos = q;
var s = -4;

if (musicInst != -4)
    s = FMODget_path(musicInst);

if (isSecret && secretInst >= 0)
    s = FMODget_path(secretInst);

currentMusic = s;
fmod_studio_event_instance_set_paused(escapeInst, isSecret);

if (musicInst >= 0)
    fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic);

if (secretInst >= 0)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret || pauseMusic);