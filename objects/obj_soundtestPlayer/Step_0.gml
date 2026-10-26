if (place_meeting(x, y, obj_player))
{
    if (pky_up2)
    {
        with (other)
        {
            if (songInst == -4)
            {
                var _song = songs[currentSong];
                songInst = FMODcreate_event(_song.event);
                fmod_studio_event_instance_start(songInst);
            }
                
            playing = !playing;
            image_index = 1;
            alarm[0] = 10;
        }
    }
}

alpha = lerp(alpha, distance_to_object(obj_player) < 250, 0.05)

if (songInst != -4)
    fmod_studio_event_instance_set_paused(songInst, !playing);
