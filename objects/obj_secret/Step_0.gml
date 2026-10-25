if buffer > 0
{
	buffer--
	exit
}

if place_meeting(x,y,obj_metalblock) || place_meeting(x,y,obj_destructibles)
	exit

if (cutscene == false)
{
    xscaleMulti = lerp(xscaleMulti, wave(1, 1.3, 3, 4), 0.2);
    yscaleMulti = lerp(yscaleMulti, wave(1, 0.8, 3, 4), 0.2);
}

if (place_meeting(x, y, obj_player) && cutscene == false)
{
    ds_list_add(global.saveroom, id);
    cutscene = true;
    
    with (obj_player)
    {
        FMODevent_oneshot("event:/Sfx/General/Level/Progression/enterpage", x, y);
		if global.level != "dudles"
			global.secretOriginRoom = room
        targetRoom = other.targetRoom;
        door = "DOODLE";
        state = -4;
        sprite_index = spr_player_spinout;
        image_speed = 0.35;
    }
    
    sprite_index = spr_dudle_close;
    image_index = 0;
}

if (cutscene == true)
{
    if (sprite_index != spr_dudle_closed)
    {
        xscaleMulti = lerp(xscaleMulti, 1, 0.2);
        yscaleMulti = lerp(yscaleMulti, 1, 0.2);
    }
    else
    {
        xscaleMulti = approach(xscaleMulti, 0, 0.05);
        yscaleMulti = approach(yscaleMulti, 0, 0.05);
        
        if (xscaleMulti == 0 && yscaleMulti == 0)
			scr_fadeout()
    }
    
    with (obj_player)
    {
		state = -4;
        vsp = 0;
        hsp = 0;
        x = approach(x, other.x, 3);
        y = approach(y, other.y, 3);
        xscaleMulti = approach(xscaleMulti, 0, 0.05);
        yscaleMulti = approach(yscaleMulti, 0, 0.05);
        movespeed = 0;
    }
    
    if (animation_end() && sprite_index == spr_dudle_close)
        sprite_index = spr_dudle_closed
}
