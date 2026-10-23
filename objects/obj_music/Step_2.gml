if (func != -4)
    func();

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
			if instance_exists(obj_player) && obj_player.character == chars.milton
			{
				if (FMODevent_isplaying(escapeInst))
				{
					stop_music(false)
					fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
				}
		        if !audio_is_playing(mu_miltonlap2)
					scr_music(mu_miltonlap2, true)
			}
			else if obj_player.character == chars.pepperni
			{
				if (FMODevent_isplaying(escapeInst))
				{
					stop_music(false)
					fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
				}
			    if !audio_is_playing(mu_peppernilap2)
					scr_music(mu_peppernilap2, true)
			}
			else
			{
		        fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 2);
		        fmod_studio_event_instance_set_callback(escapeInst, FMOD_STUDIO_EVENT_CALLBACK.TIMELINE_BEAT);
			}
	    }
		else
		{
			if obj_player.character = chars.pepperni
			{
				if (FMODevent_isplaying(escapeInst))
				{
					stop_music(false)
					fmod_studio_event_instance_stop(escapeInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
				}
				if !audio_is_playing(mu_pepperniescape)
					scr_music(mu_pepperniescape, true)
			}
			else
				fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 0);
		}
	}
}

if (instance_exists(obj_monolith))
{
    if (!FMODevent_isplaying(monolith) && !FMODevent_isstarting(monolith))
        fmod_studio_event_instance_start(monolith);
    
    fmod_studio_event_instance_set_paused(monolith, false);
    var _cam;
    
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
		audio_pause_sound(global.music)
		audio_pause_sound(global.music_old)
        var _timelineMusic = fmod_studio_event_instance_get_timeline_position(musicInst);
        var _length = _timelineMusic / FMODget_eventLength(music.regular);
        var _pos = _length * FMODget_eventLength(music.secret);
        fmod_studio_event_instance_set_timeline_position(secretInst, _pos);
    }
	else
	{
		audio_resume_sound(global.music)
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

if (ambienceInst >= 0)
    fmod_studio_event_instance_set_paused(ambienceInst, isSecret || FMODevent_isplaying(escapeInst) || pauseMusic);

if (secretInst >= 0)
    fmod_studio_event_instance_set_paused(secretInst, !isSecret || pauseMusic);