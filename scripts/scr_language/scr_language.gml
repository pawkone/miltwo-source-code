global.language = "english";
global.langMapWord = ds_map_create();
global.langMapArt = ds_map_create();

function lang_init()
{
	var _files = [
		"gameData/languageLookup/" + global.language + ".json",
		"gameData/languageLookup/" + global.language + "_mod.json"
	]
	var _textFile = ""
	for (var i = 0; i < array_length(_files); i++)
	{
	    _textFile = _files[i];
		if file_exists(_files[i])
		{
			try {
				var _json = json_parse(loadString(_textFile));
			    var _jsonNames = variable_struct_get_names(_json);
			    for (var j = 0; j < array_length(_jsonNames); j++)
			        ds_map_add(global.langMapWord, _jsonNames[j], variable_struct_get(_json, _jsonNames[j]));
			} catch(e)
			{
			    show_debug_message("JSON FAILED: " + _textFile);
			    show_debug_message(string(e));
			}
		}
	}
}

function lang_get_phrase(arg0)
{
    if ds_map_exists(global.langMapWord, arg0)
        return ds_map_find_value(global.langMapWord, arg0);
    else
        return arg0;
}