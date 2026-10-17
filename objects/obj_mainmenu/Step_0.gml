with obj_player
{
	x = -100
	y = -100
	hsp = 0
	vsp = 0
	state = -4;
}

roomPaletteIndex = approach(roomPaletteIndex, selectedFile + 1, 0.1);
if mky_taunt2
	room_goto(Levelselect)
switch (scene)
{
    case -2:
        if (mky_jump2)
        {
            dark = false;
            FMODevent_oneshot("event:/Sfx/UI/Mainmenu/turnon");
            scene = -1;
            alarm[0] = 60;
            alarm[3] = 5;
            
            if (created == true)
            {
                fmod_studio_event_instance_start(music);
                fmod_studio_event_instance_set_paused(music, false);
            }
        }
		break
    
    case -1:
		if mky_jump2 && !skip1
		{
			scene = 0;
			selectedFile = 0;
			TVsprite = spr_mainmenu_tvStatic;
			if saveFiles[selectedMode][selectedFile].created
			    alarm[5] = 1;
			alarm[0] = -1
			alarm[3] = -1
			dark = false;
			skip1 = true
		}
        break;
    
    case 0:
        if (instance_exists(obj_option))
            exit;
        
        if (pky_start2)
            instance_create(x, y, obj_option);
        
        hudAlpha = approach(hudAlpha, 1, 0.1);
        var q = saveFiles[selectedMode][selectedFile];
        
        if (mky_jump2)
        {
            global.saveFile = q.savePath;
			q.movie.scalevel = 0.15
            alarm[1] = 180;
			fmod_studio_event_instance_start(snd1)
			fmod_studio_event_instance_start(snd2)
            scene = 1;
            fmod_studio_event_instance_stop(music, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
            xdata_open(global.saveFile);
            xdata_write("General", "created", true);
            xdata_close();
            TVsprite = spr_mainmenu_tv;
        }
        
        var move = mky_right2 + mky_left2;
        
        if (move != 0)
        {
            selectedFile += -move;
            FMODevent_oneshot("event:/Sfx/UI/Pause/menumove");
            TVsprite = spr_mainmenu_tvStatic;
            selectedFile = clamp(selectedFile, 0, 3);
            
            if (saveFiles[selectedMode][selectedFile].created == true)
                alarm[5] = 6;
            else
                alarm[5] = -1;
        }
		
		move = -mky_up2 + mky_down2;
        
        if (move != 0)
        {
            selectedFile += -move;
            FMODevent_oneshot("event:/Sfx/UI/Pause/menumove");
            TVsprite = spr_mainmenu_tvStatic;
            selectedFile = clamp(selectedFile, 0, 3);
            
            if (saveFiles[selectedMode][selectedFile].created == true)
                alarm[5] = 6;
            else
                alarm[5] = -1;
        }
        
        if (TVsprite == spr_mainmenu_tv)
            TVindex = selectedFile + 1;
        else
            TVindex += 0.35;
        
        percentageReal = q.completion;
        
        if (TVsprite != spr_mainmenu_tvStatic)
            percentage = lerp(percentage, percentageReal, 0.25);
        
        for (var i = 0; i < array_length(saveFiles[selectedMode]); i++)
        {
            q = saveFiles[selectedMode][i];
            q.faceAlpha = approach(q.faceAlpha, (selectedFile == q.file && q.created) ? 1 : 0, 0.1);
            q.movie.x = lerp(q.movie.x, (selectedFile == q.file) ? (q.movie.saveX + 80) : q.movie.saveX, 0.35);
            q.movie.y = lerp(q.movie.y, (selectedFile == q.file) ? (q.movie.saveY - 5) : q.movie.saveY, 0.25);
        }
        
        /*
		if (mky_taunt2)
        {
            q = saveFiles[selectedFile];
            
            if (file_exists(q.savePath))
                file_delete(q.savePath);
            saveFiles[selectedFile] = new createSave(selectedFile);
            TVsprite = spr_mainmenu_tvStatic;
        }
		*/
        
        break;
    
    case 1:
        hudAlpha = approach(hudAlpha, 0, 0.05);
        
		if mky_jump2 && !skip2
		{
			skip2 = true
			fmod_studio_event_instance_stop(snd1, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
			fmod_studio_event_instance_stop(snd2, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
			alarm[1] = -1;
			event_user(0);
		}
		
        for (var i = 0; i < array_length(saveFiles[selectedMode]); i++)
        {
            var q = saveFiles[selectedMode][i];
            
            if (selectedFile != q.file)
            {
				q.movie.scalevel += 0.08
                q.movie.alpha = approach(q.movie.alpha, 0, 0.0175);
                q.movie.x = q.movie.saveX + irandom_range(-1 - q.movie.scalevel, 1 + q.movie.scalevel);
                q.movie.y = q.movie.saveY + irandom_range(-1 - q.movie.scalevel, 1 + q.movie.scalevel);
            }
            else
            {
				q.movie.scalevel += 0.0025
				var _s = q.movie.scalevel
                q.movie.scale += _s*_s*_s*_s*q.movie.scale;
                if (moviefade > 0)
                    moviefade -= (q.movie.scale/5)+_s*2;
                else
                    moviefade = 0;
                moviefade = clamp(moviefade,0,255)
                moviefadeC = make_color_rgb(moviefade, moviefade, moviefade);
            }
        }
        
        break;
}
