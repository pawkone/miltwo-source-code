var _rm = targetRoom;
var _dr = "A";
var _gate = id
var _plr = other.id

if (pky_up && _plr.state == scr_player_normal)
{
    with (_plr)
    {
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = scr_player_enterdoor;
        sprite_index = sprites.entergate;
        image_index = 0;
    }
    
    with (obj_handlerMusic)
        stop_music();
}

with (_plr)
{
	if sprite_index == sprites.entergate
	{
		obj_handlerCamera.xOffset = approach(obj_handlerCamera.xOffset, 0, 0.3)
		x = approach(x, _gate.x, 1.75)
	    if (image_index >= (image_number - 12) && !instance_exists(obj_fadeout) && !instance_exists(obj_titlecard))
	    {
	        state = scr_player_enterdoor;
	        sprite_index = sprites.entergate;
			if animation_end()
				image_index = image_number - 1;
	        generalReset();
	        targetRoom = _rm;
	        door = _dr;
	        backtohubRoom = room;
	        backtohubX = x;
	        backtohubY = y;
	        global.level = _gate.level;
	        global.resetRoom = _rm;
			with obj_onlineHandler
			{
				lastestMessageNum = wrap(lastestMessageNum+1, 123, 233)
				lastestMessage = string(lang_get_phrase("online_level_enter"),lang_get_phrase($"level_{global.level}"))
			}
	        if (global.level == "tutorial")
				scr_fadeout()
	        else if (!instance_exists(obj_titlecard))
	        {
	            with instance_create(0, 0, obj_titlecard)
				{
					titlecardinfo = _gate.titlecard
					titlecardinfo[3] = titlecardinfo[1]
					titlecardinfo[1] = lang_get_sprite(sprite_get_name(titlecardinfo[0])+"Title1")
					titlecardinfo[2] = lang_get_sprite(sprite_get_name(titlecardinfo[0])+"Title2")
				}
	        }
	    }
	}
}
