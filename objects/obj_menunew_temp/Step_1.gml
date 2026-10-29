if pky_jump2
{
	var _rm = hotel_start;
	var _dr = "A";
	with (obj_player)
	{
		global.saveFile = wsbMOmInfo.dir + "sandbox1.xda"
		xdata_open(global.saveFile)
		character = xdata_read("Modded", "c_char", chars.mildred)
		palIndex = xdata_read("Modded", "c_pal", 1)
		xdata_close()
		event_user(0)
		generalReset();
	    targetRoom = _rm;
	    door = _dr;
	    movespeed = 0;
	    vsp = 0;
	    hsp = 0;
	    state = states.enterdoor;
	}
	global.level = -4;
	global.resetRoom = _rm;
	room_goto(_rm)
	instance_destroy(obj_fadeout)
	with instance_create(0, 0, obj_fadeout)
	{
		image_alpha = 1
		fadein = 0
	}
}