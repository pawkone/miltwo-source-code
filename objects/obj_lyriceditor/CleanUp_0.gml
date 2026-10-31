if is_string(event)
{
	fmod_studio_event_instance_stop(inst, FMOD_STUDIO_STOP_MODE.IMMEDIATE)
	fmod_studio_event_instance_release(inst)
}