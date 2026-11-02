function scr_player_enterdoor()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
	
	if (place_meeting(x, y, obj_floorgate))
		image_speed = 0.3
    else if (place_meeting(x, y, obj_door))
    {
        var _door = instance_place(x, y, obj_door);
        var _tX = _door.x + (_door.sprite_width / 2);
        x = approach(x, _tX, 6);
    }
    
    if (place_meeting(x, y, obj_keydoor))
    {
        var _door = instance_place(x, y, obj_keydoor);
        var _tX = _door.x + (_door.sprite_width / 2);
        x = approach(x, _tX, 6);
    }
    
    if (place_meeting(x, y, obj_magicianDoor))
    {
        var _door = instance_place(x, y, obj_magicianDoor);
        var _tX = _door.x + (_door.sprite_width / 2);
        x = approach(x, _tX, 6);
    }
	
    if (animation_end())
    {
        image_index = image_number - 1;
        if sprite_index == spr_player_downbox || sprite_index == spr_player_upbox
		{
			if scr_fadeout()
				FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
		}
    }
}