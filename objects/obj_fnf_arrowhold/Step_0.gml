y = ((note_time - obj_fnf.curTime)*(scrollspeed/2)) + 64
if note_time - 50 <= obj_fnf.curTime && dir <= 3
{
	if audio_exists(obj_fnf.vocals)
		audio_sound_gain(obj_fnf.vocals, 1, 0)
	obj_fnf.epichitnoteee(dir, true, abs(y - 64), endpart)
	if obj_fnf.sturmtimer[dir] < 0.5
	{
		with obj_fnf_chardad
		{
			singtime = 0.9
			image_index = 0
			switch other.dir
	        {
	            case 0: sprite_index = spr_left break
				case 1: sprite_index = spr_down break
				case 2: sprite_index = spr_up break
				case 3: sprite_index = spr_right break
			}
		}
		obj_fnf.sturmtimer[dir] = 1
	}
    instance_destroy()
}
if dir >= 4 && y <= -100 + 32
{
	if audio_exists(obj_fnf.vocals)
		audio_sound_gain(obj_fnf.vocals, 0, 0)
	obj_fnf.hp -= (0.04/20)
	obj_fnf.collect -= 4
	with obj_fnf_charbf
	{
	    singtime = 2
		image_index = 0
		switch other.dir
        {
            case 0: sprite_index = spr_left break
			case 1: sprite_index = spr_down break
			case 2: sprite_index = spr_up break
			case 3: sprite_index = spr_right break
		}
	}
	instance_destroy()
}