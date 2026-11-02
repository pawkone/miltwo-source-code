global.plrsnds_gmsnd = ds_map_create()
global.plrsnds_gmsndact = ds_map_create()

function scr_playerSounds_load()
{
	if !variable_instance_exists(id, "sfx") sfx = {}
	
	scr_playerSounds_release("laugh")
	scr_playerSounds_release("mach")
	scr_playerSounds_release("sjump")
	scr_playerSounds_release("roll")
	scr_playerSounds_release("groundpound")
	scr_playerSounds_release("grab")
	scr_playerSounds_release("hammer")
	scr_playerSounds_release("hammerair")
	scr_playerSounds_release("skateboard")
	scr_playerSounds_release("skateaim")
	
	sfx = {}
	
	scr_playerSounds_data()
	
	scr_playerSounds_loadcheck("taunt", "event:/Sfx/Player/taunt")
	scr_playerSounds_loadcheck("step", "event:/Sfx/Player/step")
	scr_playerSounds_loadcheck("jump", "event:/Sfx/Player/jump")
	scr_playerSounds_loadcheck("machturn", "event:/Sfx/Player/machturn")
	scr_playerSounds_loadcheck("machend", "event:/Sfx/Player/machend")
	scr_playerSounds_loadcheck("sjump_release", "event:/Sfx/Player/superjumprelease")
	scr_playerSounds_loadcheck("rollgetup", "event:/Sfx/Player/rollgetup")
	scr_playerSounds_loadcheck("slam", "event:/Sfx/Player/slam")
	scr_playerSounds_loadcheck("ok", "event:/Sfx/Player/yeag")
	scr_playerSounds_loadcheck("laugh", "event:/Sfx/Player/yay")
	scr_playerSounds_loadcheck("gasp", "event:/Sfx/Player/gasp")
	scr_playerSounds_loadcheck("voice_hurt", -4)
	scr_playerSounds_loadcheck("mach", FMODcreate_event("event:/Sfx/Player/mach"))
	scr_playerSounds_loadcheck("sjump", FMODcreate_event("event:/Sfx/Player/superjump"))
	scr_playerSounds_loadcheck("roll", FMODcreate_event("event:/Sfx/Player/tumble"))
	scr_playerSounds_loadcheck("groundpound", FMODcreate_event("event:/Sfx/Player/groundpound"))
	scr_playerSounds_loadcheck("grab", FMODcreate_event("event:/Sfx/Player/dash"))
	scr_playerSounds_loadcheck("hammer", FMODcreate_event("event:/Sfx/Player/hammerattack"))
	scr_playerSounds_loadcheck("hammerair", FMODcreate_event("event:/Sfx/Player/hammerair"))
	scr_playerSounds_loadcheck("skateboard", FMODcreate_event("event:/Sfx/Player/Transformations/Skateboard/move"))
	scr_playerSounds_loadcheck("skateaim", FMODcreate_event("event:/Sfx/Player/Transformations/Skateboard/aim"))
}
function scr_playerSounds_loadcheck(str, event)
{
	if !struct_exists(sfx, str)
		struct_set(sfx, str, event)
}
function scr_playerSounds_release(str)
{
	if struct_exists(sfx, str)
	{
		var _sfx = struct_get(sfx, str)
		if is_real(_sfx)
			fmod_studio_event_instance_release(_sfx)
	}
}
function plrsnds_play(event, xx, yy)
{
	if is_string(event)
		FMODevent_oneshot(event, xx, yy)
	else
	{
		if is_array(event)
			event = event[irandom(array_length(event)-1)]
		var _pitch = random_range(0.9,1.1)
		var _sfx = scr_soundeffect(event, _pitch, false)
		audio_sound_gain(_sfx, global.SfxVolume * audio_sound_get_gain(event), 0)
	}
}

function plrsnds_gmsnd_preload(event, has_states)
{
	if !ds_map_exists(global.plrsnds_gmsnd, event)
	{
		if has_states
		{
			global.plrsnds_gmsnd[? event] = []
			global.plrsnds_gmsndact[? event] = []
			var _sfxid = asset_get_index(event + "1"), i = 0
			while _sfxid >= 0
			{
				if _sfxid >= 0
				{
					array_push(global.plrsnds_gmsnd[? event], _sfxid)
					array_push(global.plrsnds_gmsndact[? event], -4)
				}
				i++
				_sfxid = asset_get_index(event + string(i+1))
			}
		}
		else
		{
			global.plrsnds_gmsnd[? event] = asset_get_index(event)
			global.plrsnds_gmsndact[? event] = -4
		}
	}
}
function plrsnds_event(condition, event, state = -1)
{
	if is_real(event)
	{
	    if condition
	    {
	        fmod_studio_event_instance_set_paused(event, false);
        
	        if (!FMODevent_isplaying(event))
	            fmod_studio_event_instance_start(event);
        
	        FMODSet3dPos(event, x, y);
		
			if state > 0
			{
		        if (fmod_studio_event_instance_get_parameter_by_name(event, "state") != state)
		            fmod_studio_event_instance_set_parameter_by_name(event, "state", state);
			}
	    }
	    else
	        fmod_studio_event_instance_stop(event, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	}
	else
	{
		if state >= 0
		{
			plrsnds_gmsnd_preload(event, 1)
			var _snd = global.plrsnds_gmsnd[? event]
		    if condition
		    {
				for (var j = 0; j < array_length(_snd); j++)
				{
					if j != state
						audio_stop_sound(_snd[j])
					else if !audio_is_playing(global.plrsnds_gmsndact[? event][j])
						global.plrsnds_gmsndact[? event][j] = scr_soundeffect(_snd[j])
					audio_sound_gain(global.plrsnds_gmsndact[? event][j], global.SfxVolume * 1.5 * audio_sound_get_gain(_snd[state]), 0)
				}
		        //FMODSet3dPos(event, x, y);
		    }
		    else
			{
				for (var j = 0; j < array_length(global.plrsnds_gmsndact[? event]); j++)
					audio_stop_sound(global.plrsnds_gmsndact[? event][j])
			}
		}
		else
		{
			plrsnds_gmsnd_preload(event, 0)
			var _snd = global.plrsnds_gmsnd[? event]
		    if condition
		    {
				if !audio_is_playing(global.plrsnds_gmsndact[? event])
					global.plrsnds_gmsndact[? event] = scr_soundeffect(_snd)
				audio_sound_gain(global.plrsnds_gmsndact[? event], global.SfxVolume * 3 * audio_sound_get_gain(_snd), 0)
		    }
		    else if audio_is_playing(global.plrsnds_gmsndact[? event])
				audio_stop_sound(global.plrsnds_gmsndact[? event])
		}
	}
}

function playerSounds()
{
	var s = 0
	plrsnds_event(state == scr_player_tumble, sfx.roll)
    
	s = 0    
	if (abs(movespeed) > 0) s = abs(movespeed) / 12;
	plrsnds_event(state == scr_player_hammerattack, sfx.hammer, s)
    
	plrsnds_event(state == scr_player_groundpoundstart || state == scr_player_groundpound, sfx.groundpound)
	plrsnds_event(sprite_index == spr_milton_dive, sfx.hammerair)
	plrsnds_event(state == scr_player_superjumpprep, sfx.sjump)
	plrsnds_event(state == scr_player_skateboardmove, sfx.skateboard)
	plrsnds_event(state == scr_player_skateboardAim, sfx.skateaim)
	
	plrsnds_event(state == scr_player_grab, sfx.grab)
	
	plrsnds_event((state == scr_player_retwistedBuzzsaw || sprite_index == spr_player3_spinnygroundpound) && character == chars.bacon_twist, "sfx_player_bt_ballspin")
	
	s = 0
	if (state == scr_player_mach2 && sprite_index != sprites.mach1) s = 1
	else if (state == scr_player_mach3 && sprite_index != sprites.crazyrun) s = 2
	else if (state == scr_player_mach3 && sprite_index == sprites.crazyrun) s = 3
	plrsnds_event(state == scr_player_mach2 || state == scr_player_mach3 || state == scr_player_climbwall, sfx.mach, s)
}
