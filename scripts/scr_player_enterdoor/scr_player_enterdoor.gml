function scr_player_enterdoor()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
	var _door
	if (place_meeting(x, y, obj_floorgate))
		image_speed = 0.3
    else if (place_meeting(x, y, obj_door))
    {
        _door = instance_place(x, y, obj_door)
        x = approach(x, _door.x + (_door.sprite_width / 2), 6)
    }
    else if (place_meeting(x, y, obj_keydoor))
    {
        _door = instance_place(x, y, obj_keydoor)
        x = approach(x, _door.x + (_door.sprite_width / 2), 6)
    }
    else if place_meeting(x, y, obj_magicianDoor)
    {
        _door = instance_place(x, y, obj_magicianDoor)
        x = approach(x, _door.x + (_door.sprite_width / 2), 6)
    }
	
    if animation_end()
    {
        image_index = image_number - 1;
        if sprite_index == spr_player_downbox || sprite_index == spr_player_upbox
		{
			if scr_fadeout()
				FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
		}
    }
}