if (mky_jump2 && !skip)
{
    skip = true;
	scr_soundeffect(sfx_skiptitlecard, 0.95, false)
	if is_string(titlecardinfo[3])
		fmod_studio_event_instance_stop(snd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	else
		audio_stop_sound(snd)
	scene = 2;
	circleSize = 960;
	circleSizeSpeed = -20;
	fadeAlpha = 1;
	alarm[1] = -1;
    alarm[3] = -1;
	alarm[5] = -1;
}

if (scene == 0 || scene == 1)
{
    if fadeIn
    {
		fadeAlpha = 1
		circleSizeSpeed = max(circleSizeSpeed + 0.25,16)
		circleSize -= circleSizeSpeed
		
		var _t = (960-circleSize)/960
		obj_camera.camera.zoom -= _t*_t/5
        if circleSize <= 0
        {
			if is_string(titlecardinfo[3])
				snd = FMODcreate_event(titlecardinfo[3]);
			else
			{
				snd = scr_music(titlecardinfo[3]);
				audio_sound_loop(snd, false)
			}
			circleSizeSpeed = 0
            fadeIn = false;
			fadeAlpha = 0
            scene = 1;
            alarm[0] = 120;
            alarm[1] = 210;
        }
    }
}
else if (scene == 2)
{
    circleSize = approach(circleSize, 0, circleSizeSpeed);
    circleSizeSpeed = max(circleSizeSpeed, 32)
    
    if (circleSize == 0)
    {
        scene = 3;
        alarm[2] = skip ? 1 : 45;
    }
}
else if (scene == 4)
{
    circleSize = approach(circleSize, 960, circleSizeSpeed);
    circleSizeSpeed += 1;
    if (circleSize == 960)
        instance_destroy()
}

if scene > 0
{
	y = lerp(y, title2 ? 540 : 0, 0.1)
	y = approach(y, title2 ? 540 : 0, 0.05)
}