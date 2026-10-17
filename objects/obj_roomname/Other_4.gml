show = true;
alarm[0] = 180;

var _raw = string("roomname_{0}", room_get_name(room))
var _lang = lang_get_phrase(_raw)
if _raw != _lang
	text = _lang
else
	text = ""