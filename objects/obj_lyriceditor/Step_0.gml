if keyboard_check_pressed(vk_enter)
	pause = !pause
fmod_studio_event_instance_set_parameter_by_name(escapeInst, "state", 2)
curtime = fmod_studio_event_instance_get_timeline_position(escapeInst)
var _move = (keyboard_check(vk_right) - keyboard_check(vk_left))*50*(keyboard_check(vk_shift)*19+1)
curtime += _move
if _move != 0
	fmod_studio_event_instance_set_timeline_position(escapeInst, curtime)
fmod_studio_event_instance_set_paused(escapeInst, pause || _move != 0)
if mouse_check_button_pressed(mb_left)
{
	array_push(captions.str, get_string("enter lyric", ""))
	array_push(captions.timing, curtime/1000)
}
if mouse_check_button(mb_right)
{
	for (var i = 0; i < array_length(captions.timing); i++)
	{
		if point_in_circle(mouse_x,mouse_y,((curtime/1000)*-200+captions.timing[i]*200) + 65, 300, 10)
		{
			array_delete(captions.timing, i, 1)
			array_delete(captions.str, i, 1)
			break
		}
	}
}