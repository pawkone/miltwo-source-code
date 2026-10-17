if (obj_player.character == chars.milton)
    titlecardMiltonIndex = approach(titlecardMiltonIndex, sprite_get_number(titlecardMilton) - 1, 0.4);

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
}

if (scene == 0 || scene == 1)
{
    if fadeIn
    {
		obj_camera.camera.zoom = 1+fadeAlpha*fadeAlpha*0.75
        fadeAlpha = approach(fadeAlpha, 1, 0.05);
        
        if (fadeAlpha == 1)
        {
            if (!FMODevent_isplaying(snd))
                fmod_studio_event_instance_start(snd);
            
            fadeIn = false;
            scene = 1;
            alarm[0] = 120;
            alarm[1] = 210;
        }
    }
    else
        fadeAlpha = approach(fadeAlpha, 0, 0.1);
    
    if (titlecardName.fadeIn == true)
    {
        titlecardName.alpha = approach(titlecardName.alpha, 0, 0.05);
        
        if (titlecardName.alpha == 0)
        {
            titlecardName.fadeIn = false;
            titlecardName.sprite = titlecardinfo[2];
        }
    }
	else
        titlecardName.alpha = approach(titlecardName.alpha, 1, 0.1);
}

if (scene == 2)
{
    circleSize = approach(circleSize, 0, circleSizeSpeed);
    circleSizeSpeed += 1;
    
    if (circleSize == 0)
    {
        scene = 3;
        alarm[2] = skip ? 1 : 45;
    }
}

if (scene == 4)
{
    circleSize = approach(circleSize, 960, circleSizeSpeed);
    circleSizeSpeed += 1;
    
    if (circleSize == 960)
    {
        scene = 5;
        alarm[3] = 25;
    }
}

if (scene == 6)
{
    ratingAlpha = approach(ratingAlpha, 1, 0.1);
    
    if (ratingAlpha == 1 && alarm[3] <= 0)
        alarm[3] = 180;
}

if (scene == 7)
{
    ratingAlpha = approach(ratingAlpha, 0, 0.01);
    
    if (ratingAlpha == 0)
        instance_destroy();
}
