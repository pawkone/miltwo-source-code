event = "event:/Music/General/escape"
state = 2

event = mu_sodalap1
state = 0

if is_string(event)
{
	inst = FMODcreate_event(event)
	fmod_studio_event_instance_start(inst)
}
else
	inst = audio_play_sound(event, 10, true)
pause = 1
time = 0

if is_string(event)
	fmod_studio_event_instance_set_parameter_by_name(inst, "state", state)

window_enable_borderless_fullscreen(true)
window_set_fullscreen(true)
captions = {}
captions.str = []
captions.timing = []
captions.toggle = 1
captions.vsp = 0
captions.y2 = 0
captions.yy = 0
captions.old = -1