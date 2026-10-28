if (room != hotel_soundtest)
{
	if muisFmod
	{
		fmod_studio_event_instance_stop(mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
		fmod_studio_event_instance_release(mu);
	}
	else
		audio_stop_sound(mu)
}