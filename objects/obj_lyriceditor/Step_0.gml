if keyboard_check_pressed(vk_f5)
{
	var _fn = game_save_id + $"lyricssaves/{real(date_current_datetime())}.json"
	var _json = json_stringify({"text": captions.str, "time": captions.timing}, true)
	var _file = file_text_open_write(_fn)
	file_text_write_string(_file, _json)
	file_text_close(_file)
	show_message($"saved lyrics at\n{_fn}")
}
if keyboard_check_pressed(vk_f6)
{
	var _file = get_string("enter lyric file name", "")
	var _path = "gameData/languageLookup/" + global.language + "/songs/" + _file + ".json"
	try
	{
		var _str = loadString(_path)
		if _str == ""
			throw {message: "File is empty/doesn't exist"}
		_str = json_parse(_str)
		captions.str = _str.text
		captions.timing = _str.time
		show_message($"loaded successfully!")
	}
	catch(e)
	{
		show_message($"error loading - " + e.message)
	}
}
if keyboard_check_pressed(vk_enter)
	pause = !pause
if is_string(event)
{
	fmod_studio_event_instance_set_parameter_by_name(inst, "state", state)
	curtime = fmod_studio_event_instance_get_timeline_position(inst)
}
else
	curtime = audio_sound_get_track_position(inst)*1000
var _move = (keyboard_check(vk_right) - keyboard_check(vk_left))*50*(keyboard_check(vk_shift)*19+1)
curtime += _move
if is_string(event)
{
	if _move != 0
		fmod_studio_event_instance_set_timeline_position(inst, curtime)
	fmod_studio_event_instance_set_paused(inst, pause || _move != 0)
}
else
{
	if _move != 0
		audio_sound_set_track_position(inst, curtime/1000)
	if pause || _move != 0
		audio_pause_sound(inst)
	else
		audio_resume_sound(inst)
}

if mouse_check_button_pressed(mb_left)
{
	var _done = false
	for (var i = 0; i < array_length(captions.timing); i++)
	{
		if captions.timing[i] > curtime/1000
		{
			array_insert(captions.str, i, get_string("enter lyric", ""))
			array_insert(captions.timing, i, curtime/1000)
			_done = true
			break
		}
	}
	if !_done
	{
		array_push(captions.str, get_string("enter lyric", ""))
		array_push(captions.timing, curtime/1000)
	}
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