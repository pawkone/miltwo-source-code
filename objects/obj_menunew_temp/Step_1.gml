if pky_jump2 || pky_taunt2
{
	with (obj_player)
	{
		global.saveFile = wsbMOmInfo.dir + "sandbox1.xda"
		xdata_open(global.saveFile)
		character = xdata_read("Modded", "c_char", chars.mildred)
		palIndex = xdata_read("Modded", "c_pal", 1)
		xdata_close()
		event_user(0)
		generalReset();
	    targetRoom = pky_taunt2 ? hotel_2763 : hotel_start;
	    door = "A";
	    movespeed = 0;
	    vsp = 0;
	    hsp = 0;
	    state = scr_player_normal;
		global.resetRoom = targetRoom;
		room_goto(targetRoom)
	}
	global.level = -4;
	instance_destroy(obj_fadeout)
	with instance_create(0, 0, obj_fadeout)
	{
		image_alpha = 1
		fadein = 0
	}
}