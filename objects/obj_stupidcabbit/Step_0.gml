if !FMODevent_isplaying(idlesnd)
    fmod_studio_event_instance_start(idlesnd)
with (obj_player)
{
    if place_meeting(x + hsp, y + vsp, other) && is_transfo_kill()
	{
		instance_destroy(other)
		exit
	}
}
with (obj_crab)
{
    if place_meeting(x + hsp, y + vsp, other) && state == states.taunt
	{
		instance_destroy(other)
		exit
	}
}