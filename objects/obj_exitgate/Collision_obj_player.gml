if (other.grounded && pky_up && other.state != -4 && other.state != states.enterdoor && other.state != states.walkfront && openn)
{
    with (other)
    {
		with obj_onlineHandler
		{
			var _rankString = "D";
			if (global.collect >= global.Crank)
				_rankString = "C";
			if (global.collect >= global.Brank)
				_rankString = "B";
			if (global.collect >= global.Arank)
				_rankString = "A";
			if (global.collect >= global.Srank)
				_rankString = "S";
			if (scr_Prank())
				_rankString = "P";
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
        scr_savelevel();
    }
}
