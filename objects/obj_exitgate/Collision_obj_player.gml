if (other.grounded && pky_up && other.state != -4 && other.state != scr_player_enterdoor && other.state != scr_player_walkfront && openn)
{
    with (other)
    {
	    var _rankString = "D";
		if scr_Prank() _rankString = "P";
		else if (global.collect >= global.Srank) _rankString = "S";
		else if (global.collect >= global.Arank) _rankString = "A";
		else if (global.collect >= global.Brank) _rankString = "B";
	    else if (global.collect >= global.Crank) _rankString = "C";
		with obj_onlineHandler
		{
			lastestMessageNum = wrap(lastestMessageNum+1, 123, 233)
			lastestMessage = " beat " + string_lower(levelgetname(global.level)) + " (" + _rankString + " Rank - " + (global.escapeLap > 0 ? string("Lap {0}", global.escapeLap) : "No Laps") + ")"
		}
		
		door = "NONE"
        vsp = 0;
        state = -10;
        sprite_index = sprites.lookdoor;
        image_index = 0;
        FMODstopAll();
        global.combo.savecombo = global.combo.amt;
        
        if (global.combo.savecombo > global.combo.highest)
            global.combo.highest = global.combo.savecombo;
        
        if (global.combo.amt > 0 && global.combo.timer > 0)
            global.collect += (10 * global.combo.savecombo);
        
        instance_create(0, 0, obj_rank);
		
	    xdata_open(global.saveFile);
	    if (xdata_read(global.level, "Highscore", 0) < global.collect)
	    {
	        xdata_write(global.level, "Highscore", global.collect);
	        xdata_write(global.level, "Rank", _rankString);
	        xdata_write(global.level, "Toppin1", global.toppins[0]);
	        xdata_write(global.level, "Toppin2", global.toppins[1]);
	        xdata_write(global.level, "Toppin3", global.toppins[2]);
	        xdata_write(global.level, "Toppin4", global.toppins[3]);
	        xdata_write(global.level, "Toppin5", global.toppins[4]);
	        xdata_write(global.level, "Treasure", global.treasure);
	        xdata_write(global.level, "Secrets", global.secretCount);
	    }
    
	    obj_savesystem.saveiconTimer = 60;
	    xdata_close();
    }
}
