var _rm = room_get_name(room)
if is_callable(roomname_scr_roomstart)
{
	roomname_text = ""
	var _s1 = $"roomname_{_rm}"
	var _s2 = lang_get_phrase(_s1)
	roomname_text = _s2 != _s1 ? _s2 : ""
	roomname_scr_roomstart()
}
roomthing = global.level == "tutorial" || global.level == -4 || room == rank_room || room == timesup_room || string_starts_with(_rm, "hotel")
tvbg_backindex = c_white
global.escapeMaxTimer = 180
global.Srank = 0
switch global.level
{
	case "yard":
		global.escapeMaxTimer = 210
		global.Srank = 22000
		tvbg_backindex = #AE5552
		break;
	case "shell":
		global.escapeMaxTimer = 210
		global.Srank = 30000
		tvbg_backindex = #A56B7A
		break;
	case "beach":
		global.Srank = 0
		tvbg_backindex = #E3AF88
		break
	case "rockbottom":	
		global.escapeMaxTimer = 210
		global.Srank = 17000
		tvbg_backindex = #0068ab
		break
	case "crashout":
		global.Srank = 12000
		tvbg_backindex = #f8e080
		break
	case "beaker":
		global.Srank = 17000
		tvbg_backindex = #b26959
		break
}
global.escapeMaxTimer *= 60
global.Arank = global.Srank / 1.2
global.Brank = global.Arank / 2
global.Crank = global.Brank / 3