roomthing = room == initObject || room == hotel_soundtest || room == rank_room || room == Levelselect || room == Mainmenu || room == serverMenuShit || room == timesup_room || global.level == "tutorial" || string_starts_with(room_get_name(room), "hotel")

global.escapeMaxTimer = 10800
global.Srank = 0
tv.backindex = c_white
switch (global.level)
{
    case "yard":
		global.escapeMaxTimer = 12600
        global.Srank = 22000
        tv.backindex = #AE5552
        break;
    
    case "shell":
        global.Srank = 30000
        tv.backindex = #A56B7A
        break;
	
	case "rockbottom":	
		global.escapeMaxTimer = 12600
		global.Srank = 17000
		tv.backindex = #0068ab
		break
		
	case "crashout":	
		global.Srank = 17000
		tv.backindex = #f8e080
		break
}
global.Arank = global.Srank / 1.2;
global.Brank = global.Arank / 2;
global.Crank = global.Brank / 3;