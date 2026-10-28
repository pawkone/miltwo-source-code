if notset
{
	notset = 0
	if target.sprite_index == spr_preoutman_breakdance
	{
		muisFmod = false
		if (room != hotel_soundtest)
			mu = audio_play_sound(sfx_player_pom_breakdance,10,true)
	}
	else
	{
		muisFmod = true
		if (room != hotel_soundtest)
		{
			mu = FMODcreate_event("event:/Music/breakdance");
		    fmod_studio_event_instance_start(mu);
		    fmod_studio_system_set_parameter_by_name("musicfade", 1, false);
		}
	}
}

scr_collision()

if (room != hotel_soundtest)
{
	if muisFmod
		FMODSet3dPos(mu, x, y);
	else
		audio_sound_gain(mu, 0.15+clamp(1.2-(point_distance(x,y,obj_camera.camera.x,obj_camera.camera.y)/960), 0, 1))
    fmod_studio_system_set_parameter_by_name("musicfade", 1, false);
}

if ((target.object_index == obj_onlinePlayer && !target.breakdance) || (target.object_index == obj_player && target.sprite_index != target.sprites.breakdance))
{
    create_particleStatic(spr_genericpoofeffect, x, y, 1, -10);
    instance_destroy();
	if (room != hotel_soundtest)
	{
		if muisFmod
		{
		    fmod_studio_event_instance_stop(mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
		    fmod_studio_event_instance_release(mu);
		}
		else
			audio_stop_sound(mu)
		fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
	}
    exit;
}
