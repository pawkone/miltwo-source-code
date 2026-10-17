window_set_caption(global.gameframe_caption_text)
if instance_exists(obj_fmod)
{
	lap3_mult = lerp(lap3_mult, audio_is_playing(mu_lap3), 0.1)

	if audio_is_playing(mu_lap3)
	{
		beat_time = audio_sound_get_track_position(global.music)-0.025
		beat_current = floor(beat_time / (60 / 296))
		if beat_current != beat_old
		{
			if beat_current mod 2 == 0 hue = beat_current*0.1 //0.33
			beat_old = beat_current
		}
		huevsp = (huevsp + (hue - huelrp)) * 0.075
		huelrp += huevsp
		hueonlrp = lerp(hueonlrp, 1, 0.075)
		hueonlrp = approach(hueonlrp, 1, 0.025)
		hueval = 0
		size = lerp(size, 1, 0.1)
		partysover = false
	}
	else if global.escapeLap == 2 && lap2alt
	{
		if instance_exists(obj_music)
			beat_time = max(0, (fmod_studio_event_instance_get_timeline_position(obj_music.escapeInst)/1000)-316.75)
		if global.escapePartyOver
		{
			if instance_exists(obj_music)
				fmod_studio_event_instance_set_timeline_position(obj_music.escapeInst, 465.75)
		}
		else if partysover
		{
			fmod_studio_system_set_parameter_by_name("MasterVolume", 0, true);
			audio_master_gain(0)
			partysovertime++
			if partysovertime > 18
			{
				fmod_studio_system_set_parameter_by_name("MasterVolume", global.MasterVolume, true);
				audio_master_gain(global.MasterVolume)
				with obj_hud
					visible = false
				global.escapeTimer = 0
				game_set_speed(60,gamespeed_fps)
				FMODsetPauseAll(false)
				partysover = false
				global.escapePartyOver = true
			}
			else
				FMODsetPauseAll(true)
		}
		else if beat_time < 118.2
		{
			beat_current = floor(beat_time / (60 / 195))+(2 * (beat_time > 0))
			if beat_current != beat_old
			{
				if beat_current mod 2 == 0 hue = beat_current*0.07
				beat_old = beat_current
			}
			huevsp = (huevsp + (hue - huelrp)) * 0.075
			huelrp += huevsp
			hueval = 0
			size = lerp(size, 1, 0.1)
			hueonlrp = lerp(hueonlrp, 1, 0.075)
			hueonlrp = approach(hueonlrp, 1, 0.025)
		}
		else
		{
			var _amt_raw = (beat_time-118.2)/(140-118.2)
			var _amt = clamp(_amt_raw,0,1)
			huevsp = lerp(huevsp, lerp(0, 2/17, (_amt*_amt*_amt)*1.125), 0.025)
			hueval = lerp(hueval, lerp(0, -0.4, (_amt*_amt*_amt)*1.125), 0.025)
			fmod_studio_system_set_parameter_by_name("MasterVolume", global.MasterVolume*(1-_amt), true);
			audio_master_gain(global.MasterVolume*(1-_amt))
			size = lerp(size, 1 - _amt_raw/2, 0.03)
			hueonlrp = lerp(hueonlrp, 1, 0.075)
			hueonlrp = approach(hueonlrp, 1, 0.025)
			if _amt_raw > 1
			{
				game_set_speed(5,gamespeed_fps)
				audio_stop_all()
				size = 1
				partysovertime = 0
				partysover = true
				hueonlrp = 1
				huevsp = 1/17
				hueval = -0.5
			}
		}
	}
	else
	{
		partysover = false
		hueval = 0
		beat_time = 0
		beat_old = -1
		hueonlrp = 0
		hue = 0
		huelrp = 0
		size = lerp(size, 1, 0.1)
	}
}