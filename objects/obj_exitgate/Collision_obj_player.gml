if (other.grounded && pky_up && other.state != -4 && other.state != states.enterdoor && other.state != states.walkfront && openn)
{
    with (other)
    {
		with obj_onlineHandler
		{
			var _rankString = "d";
			if (global.collect >= global.Crank)
				_rankString = "c";
			if (global.collect >= global.Brank)
				_rankString = "b";
			if (global.collect >= global.Arank)
				_rankString = "a";
			if (global.collect >= global.Srank)
				_rankString = "s";
			if (scr_Prank())
				_rankString = "p";
			create_notifAsync(string(global.username) + " beated " + string_lower(levelgetname(global.level)) + " : " + _rankString + " rank : " + (global.escapeLap > 0 ? string("lap {0}", global.escapeLap) : "no laps") + ")");
		}
        vsp = 0;
        state = -4;
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
