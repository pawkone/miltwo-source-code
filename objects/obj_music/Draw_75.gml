var _file = ""
captions.curtime = 0
if global.escapeActive && global.escapeLap && fmod_studio_event_instance_get_parameter_by_name(escapeInst, "state").value
{
	_file = "escapeInst_2"
	captions.curtime = fmod_studio_event_instance_get_timeline_position(escapeInst)/1000
}
else if audio_exists(global.music) && audio_sound_get_asset(global.music) == mu_sodalap1
{
	_file = "mu_sodalap1"
	captions.curtime = audio_sound_get_track_position(global.music)
}

if captions.file != _file
{
	if _file == ""
	{
		show_debug_message($"obj_music.captions - lyrics unloaded - {captions.file}")
		captions.file = ""
		captions.str = []
		captions.timing = []
	}
	else
	{
		var _path = "gameData/languageLookup/" + global.language + "/songs/" + _file + ".json"
		show_debug_message($"obj_music.captions - loading {_path}")
		try
		{
			var _str = loadString(_path)
			if _str == ""
				throw {message: "File is empty/doesn't exist"}
			_str = json_parse(_str)
			captions.str = _str.text
			captions.timing = _str.time
			show_debug_message($"obj_music.captions - loaded successfully!")
		}
		catch(e)
		{
			show_debug_message($"obj_music.captions - error loading - " + e.message)
		}
		captions.file = _file
	}
}

if captions.file != ""
	exit

draw_set_font(-1)
draw_set_halign(0)
draw_set_valign(0)
draw_set_alpha(1)
draw_set_colour(c_white)

captions.vsp += 0.06
captions.y2 += captions.vsp
if captions.y2 > 0
{
	captions.y2 = 0
	captions.vsp *= -0.75
}
captions.yy = lerp(captions.yy, (captions.toggle*captions.y2)*0.65 - 35, 0.35)

for (var i = array_length(captions.timing)-1; i >= 0; i--)
{
	if captions.timing[i] < captions.curtime
	{
		if captions.old != i
		{
			captions.toggle = ((i mod 2)*-2)+1
			captions.vsp = -1.125
			captions.y2 = 0
			captions.old = i
		}
		if captions.str[i] != ""
		{
			draw_set_alpha(0.5)
			draw_set_colour(c_black)
			draw_set_font(-1)
			var _strw = string_width(captions.str[i])
			var _strh = string_height(captions.str[i])
			draw_roundrect_ext(960/2-_strw/2-16, 540-48+captions.yy-_strh/2-16, 960/2+_strw/2+16, 540-48+captions.yy+_strh/2+16, 20, 20, false)
			draw_set_colour(c_white)
			draw_set_alpha(1)
			draw_set_halign(1)
			draw_set_valign(1)
			draw_text(960/2, 540-48+captions.yy,captions.str[i])
			draw_set_alpha(1)
			draw_set_halign(0)
			draw_set_valign(0)
		}
		break
	}
}