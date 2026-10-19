hand_y = approach(hand_y, 540, 16)
if tv_static < 0
{
	if pky_grab2
		video_close()
	if pky_jump2
	{
		tv_file = get_open_filename("video file|*.mp4", "");
		if tv_file != ""
		{
			tv_static = 0
			tv_change = false
			FMODevent_oneshot("event:/Sfx/UI/Oops!/transition");
		}
	}
	if tv_index != -1
	{
		var _move = pky_left2 + pky_right2
		if _move != 0
		{
			tv_static = 0
			tv_change = false
			tv_indexnext += pky_left2 + pky_right2
			if tv_indexnext < 1	tv_indexnext = tv_max
			if tv_indexnext > tv_max tv_indexnext = 1
			FMODevent_oneshot("event:/Sfx/UI/Oops!/transition");
		}
	}
}
else
{
	tv_static += 0.35
	if tv_static > 8
	{
		var _stat = video_get_status()
		if !tv_change
		{
			video_close()
			if _stat == video_status_closed
			{
				tv_change = true
				if tv_file != ""
				{
					video_open(tv_file)
					if video_get_status() == video_status_closed
						tv_nsbuffer = 90
					tv_file = ""
					tv_index = -1
				}
				else
				{
					tv_index = tv_indexnext
					video_open($"gameData/videos/tv{tv_index}.mp4")
					if video_get_status() == video_status_closed
						tv_nsbuffer = 90
				}
				video_set_volume(global.SfxVolume * global.SfxVolume * 2)
			}
			tv_static = 8
		}
		else if _stat == video_status_preparing
			tv_static = 8
		else
			tv_static = -1
	}
}
if pky_start2
{
	state = "files"
	video_close()
}