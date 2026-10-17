global.language = "english";
global.langMapWord = ds_map_create();
global.langMapArt = ds_map_create();

function lang_init()
{
	var _files = ["languageLookup/" + global.language + ".json",
	"languageLookup/" + global.language + "_mod.json"]
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
    _textFile = string("languageLookup/{0}_assets.json", global.language);
	if file_exists(_textFile)
	{
		try {
			return json_parse(loadString(_textFile));
		} catch(e) {return {}}
	}
	else
		return {}
}

function lang_get_phrase(arg0)
{
    if ds_map_exists(global.langMapWord, arg0)
        return ds_map_find_value(global.langMapWord, arg0);
    else
        return arg0;
}

function lang_get_asset(arg0)
{
    if ds_map_exists(global.langMapArt, arg0)
        return ds_map_find_value(global.langMapArt, arg0)
	
	var _spr = asset_get_index(arg0)
	if sprite_exists(_spr)
		return _spr
	
    return -1
}
