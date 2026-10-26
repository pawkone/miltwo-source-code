surface_free(fadeSurface)
if is_string(titlecardinfo[3])
{
	fmod_studio_event_instance_stop(snd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
	fmod_studio_event_instance_release(snd);
}