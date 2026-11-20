depth = obj_handlerPause.depth - 2
timeUniform = shader_get_uniform(shd_wave, "time")
frequencyUniform = shader_get_uniform(shd_wave, "frequency")
amplitudeUniform = shader_get_uniform(shd_wave, "amplitude")
txt = ""
select = -1
selectold = select
sizet = 1
stop = false
lang = []
inis = []
sprs = []
var _p = "gameData/lang/"
var _fn = file_find_first(_p + "/*", fa_directory)
while _fn != ""
{
	if file_exists(_p + _fn + "/info.ini")
	{
		array_push(lang, _fn)
		ini_open(_p + _fn + "/info.ini")
		array_push(inis, [
			ini_read_string("info", "name", "Name"),
			ini_read_string("info", "desc", "Description"),
			ini_read_string("info", "auth", "Unknown"),
		])
		ini_close()
		var _spr = [sprite_add(_p + _fn + "/flag.png",1,0,0,0,0), sprite_add(_p + _fn + "/gag.png",1,0,0,0,0)]
	    if _spr[0] < 0 _spr[0] = -4
		if _spr[1] < 0 _spr[1] = -4
		array_push(sprs, _spr)
		if _fn == global.language
			select = array_length(sprs)-1
	}
    _fn = file_find_next()
}
file_find_close()