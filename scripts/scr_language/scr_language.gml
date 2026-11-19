global.language = "eng"
global.langMapWord = ds_map_create()
global.langMapArt = ds_map_create()

function lang_change()
{
	ds_map_clear(global.langMapWord)
	
	var _p = $"gameData/lang/{global.language}", _files = []
	var _fn = file_find_first($"{_p}/dict/*.json", fa_none)
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
function lang_get_phrase(arg0)
{
	return ds_map_exists(global.langMapWord, arg0) ? ds_map_find_value(global.langMapWord, arg0) : arg0
}