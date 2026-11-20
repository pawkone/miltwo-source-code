if instance_exists(obj_technicaldifficulty)
	exit

if mousemoved
{
	if pky_right || -pky_left || pky_up || pky_down || pky_jump || pky_grab
		mousemoved = false
}

hand_y = approach(hand_y, 540, 16)
if tv_static < 0
{
	if file_txt == ""
		file_txt = string(lang_get_phrase("menunew_select"), file+1, file_select, 2, lang_get_phrase($"menunew_select_hotel{file_select}"))
	file_selectnew += pky_left2 + pky_right2
	file_selectnew = wrap(file_selectnew, 0, 2)
	if file_select != file_selectnew
	{
		FMODevent_oneshot("event:/Sfx/UI/Oops!/transition")
		tv_static = 0
	}
	else if pky_jump2
	{
		global.saveFile = wsbMOmInfo.dir + $"sandbox{file+1}.xda"
		obj_player.targetRoom = hotel_start
		if file_select == 1
			obj_player.targetRoom = hotel_halloween_start
		else if file_select == 2
			obj_player.targetRoom = hotel_2763
		with obj_player
		{
			global.resetRoom = targetRoom;
			xdata_open(global.saveFile)
			character = xdata_read("Modded", "c_char", chars.mildred)
			palIndex = xdata_read("Modded", "c_pal", 1)
			xdata_close()
			event_user(0)
			generalReset();
			door = "A";
			movespeed = 0;
			vsp = 0;
			hsp = 0;
			state = -4;
		}
		FMODevent_oneshot("event:/Sfx/General/Collects/bigcollect", 960 / 2, 540 / 2)
		FMODevent_oneshot("event:/Sfx/UI/Mainmenu/selectmovie")
		with instance_create(0,0,obj_technicaldifficulty)
		{
			func = function()
			{
				with obj_player
					room_goto(targetRoom)
			}
		}
	}
}
else
{
	tv_static += 0.35
	if tv_static > 8
	{
		file_txt = ""
		file_select = file_selectnew
		tv_static = -1
	}
}
if pky_start2
{
	fadestage = 0
	fadestate = "files"
}