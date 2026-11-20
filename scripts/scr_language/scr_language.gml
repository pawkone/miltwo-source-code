global.language = "eng"
global.langMapWord = ds_map_create()

function lang_change(_lang = -1)
{
	if is_string(_lang)
		global.language = _lang
	var _p = $"gameData/lang/{global.language}"
	lang_load_dict(_p)
	//lang_load_font(_p)
}
function lang_load_dict(_p)
{
	ds_map_clear(global.langMapWord)
	
	var _files = [], _fn = file_find_first($"{_p}/dict/*.json", fa_none)
	while _fn != ""
	{
		array_push(_files, $"{_p}/dict/{_fn}")
	    _fn = file_find_next()
	}
	file_find_close()
	
	for (var i = 0; i < array_length(_files); i++)
	{
		try
		{
			var _j = json_parse(loadString(_files[i]))
			var _n = variable_struct_get_names(_j)
			for (var j = 0; j < array_length(_n); j++)
				ds_map_add(global.langMapWord, _n[j], variable_struct_get(_j, _n[j]))
			delete _j
			_j = -4
		}
		catch(e)
		{
			show_debug_message($"JSON FAILED: {_files[i]}\n{e.longMessage}")
		}
	}
}
// removed cuz its mono spaced instead of proportional
// i will figure out another way later
/*
function lang_load_font(_p)
{
	//hardcoded fonts cuz i dont want exploits blegh
	var _fn = ["big", "credits", "npc", "small"]
	for (var i = 0; i < array_length(_fn); i++)
	{
		var _fni = _fn[i]
		var _vg1 = $"{_fni}font", _vg2 = $"{_fni}fontspr"
		var _vgv1 = variable_global_get(_vg1), _vgv2 = variable_global_get(_vg2)
		if font_exists(_vgv1)
			font_delete(_vgv1)
		if sprite_exists(_vgv2)
			sprite_delete(_vgv2)
		var _pp = $"{_p}/font/{_fni}.png", _pi = $"{_p}/font/{_fni}.ini"
		if file_exists(_pp) && file_exists(_pi)
		{
			ini_open(_pi)
			var _spr = sprite_add(_pp, ini_read_real("font", "amt", 1), 0, 0, 0, 0), _m = ini_read_string("font", "map", "")
			ini_close()
			if _spr < 0
				continue
			variable_global_set(_vg2, _spr)
			variable_global_set(_vg1, font_add_sprite_ext(_spr, _m, 1, 0))
		}
	}
}
*/
function lang_get_phrase(arg0)
{
	return ds_map_exists(global.langMapWord, arg0) ? ds_map_find_value(global.langMapWord, arg0) : arg0
}