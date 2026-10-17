var _rm = targetRoom;
var _dr = "A";
var _gate = id
var _plr = other.id

if (pky_up && _plr.state == states.normal)
{
    with (_plr)
    {
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        sprite_index = sprites.entergate;
        image_index = 0;
    }
    
    with (obj_music)
        stop_music();
}

with (_plr)
{
	if sprite_index == sprites.entergate
	{
		obj_camera.xOffset = approach(obj_camera.xOffset, 0, 0.3)
		x = approach(x, _gate.x, 1.75)
	    if (image_index == (image_number - 1) && !instance_exists(obj_fadeout) && !instance_exists(obj_titlecard))
	    {
	        state = states.enterdoor;
	        sprite_index = sprites.entergate;
	        image_index = image_number - 1;
	        generalReset();
	        targetRoom = _rm;
	        door = _dr;
	        backtohubRoom = room;
	        backtohubX = x;
	        backtohubY = y;
			with obj_onlineHandler
			{
				if global.level == -4
					create_notifAsync(string(global.username) + " went to " + string_lower(_gate.levelname));
			}
	        global.level = _gate.level;
	        global.resetRoom = _rm;
	        if (global.level == "tutorial")
				scr_fadeout()
	        else if (!instance_exists(obj_titlecard))
	        {
	            with instance_create(0, 0, obj_titlecard)
					titlecardinfo = _gate.titlecard
	        }
	    }
	}
}
