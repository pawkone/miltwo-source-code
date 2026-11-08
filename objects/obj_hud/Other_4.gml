roomthing = room == initObject || room == boss_bacon || room == hotel_soundtest || room == rank_room || room == Levelselect || room == Mainmenu || room == serverMenuShit || room == timesup_room || global.level == "tutorial" || string_starts_with(room_get_name(room), "hotel")

global.escapeMaxTimer = 180
global.Srank = 0
tvbg_backindex = c_white
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
		global.Srank = 17000
		tvbg_backindex = #f8e080
		break
}
global.escapeMaxTimer *= 60
global.Arank = global.Srank / 1.2
global.Brank = global.Arank / 2
global.Crank = global.Brank / 3