inis = []
sprs = []
var _p = "gameData/lang/"
var _fn = file_find_first(_p + "/*", fa_directory)
while _fn != ""
{
	ini_open(_p + _fn + "/info.ini")
	array_push(inis, [
		ini_read_string("info", "name", "Name"),
		ini_read_string("info", "desc", "Description"),
		ini_read_string("auth", "main", "Unknown"),
		ini_read_string("auth", "flagart", "Unknown"),
		ini_read_string("auth", "gagart", "Unknown"),
	])
	ini_close()
	var _spr = [sprite_add(_p + _fn + "/flag.png",1,0,0,0,0), sprite_add(_p + _fn + "/gag.png",1,0,0,0,0)]
    if _spr[0] < 0 _spr[0] = -4
	if _spr[1] < 0 _spr[1] = -4
	array_push(sprs, _spr)
    _fn = file_find_next()
}

file_find_close();