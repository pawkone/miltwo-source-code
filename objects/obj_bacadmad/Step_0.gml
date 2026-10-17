if !instance_exists(obj_player)
{
	audio_sound_pitch(global.music, random_range(1,2))
	audio_sound_gain(global.music, 0.5)
	exit
}
FMODSet3dPos(moveSnd, x, y);

if (image_alpha == 1)
{
	if (obj_player.x < x)
	    hsp -= 0.5;
	else
	    hsp += 0.5;
    
	if (obj_player.y < y)
	    vsp -= 0.5;
	else
	    vsp += 0.5;
	vsp = clamp(vsp, -12, 12);
	hsp = clamp(hsp, -12, 12);
   
	if (place_meeting(x, y, obj_player))
	{
		image_alpha = 0
		var tacosucksdick = game_get_speed(gamespeed_fps)-5
		if tacosucksdick <= 0
		{
			FMODstopAll()
			fmod_studio_system_release()
			audio_stop_all()
			for (var i = 0; i < 1000; i++)
			{
				if audio_is_playing(i) audio_stop_sound(i)
			}
			scr_soundeffect(sfx_pop,0.1,true)
			game_set_speed(5,gamespeed_fps)
			alarm[0] = 1
			alarm[1] = 15
			with all
			{
				if id != other.id
					instance_destroy(id,false)
			}
			exit
		}
		game_set_speed(tacosucksdick,gamespeed_fps)
		
		with all
		{
			if 0.05 > random(1)
				instance_create(x,y,other.object_index)
			scr_soundeffect(sfx_bacad, random_range(0.001,100))
		}
	}
}
else
{
    image_alpha = approach(image_alpha, 1, 0.05);
    hsp = 0;
    vsp = 0;
}

if (obj_player.state == states.enterdoor || obj_player.state == states.walkfront || instance_exists(obj_fadeout) || obj_player.state == -4)
    image_alpha = 0;
x += hsp;
y += vsp;
locatorIndex += 0.1;
