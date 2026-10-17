if (place_meeting(x, y, obj_player))
{
    with (obj_player)
    {
        if (pky_up2)
        {
            with (obj_soundtestPlayer)
            {
                fmod_studio_event_instance_stop(songInst, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
                fmod_studio_event_instance_release(songInst);
                songInst = -4;
                currentSong++;
                currentSong = wrap(currentSong, 0, array_length(songs) - 1);
				if (songInst == -4)
                {
                    var _song = songs[currentSong];
                    songInst = FMODcreate_event(_song.event);
                    fmod_studio_event_instance_start(songInst);
                }
            }
            
            with (other)
            {
                image_index = 1;
                alarm[0] = 10;
            }
        }
    }
}
