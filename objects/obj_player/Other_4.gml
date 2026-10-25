uparrow = 0
uparrowadd = 0

var _secreterror = door == "DOODLE" && !instance_exists(obj_secret) && !instance_exists(obj_secretStart)
if _secreterror
{
	var _list = ["A", "B", "C", "D", "E", "F", "G", "H", "S"]
	for (var i = 0; i < array_length(_list); i++)
	{
		if instance_exists(asset_get_index(string("obj_door{0}", _list[i])))
		{
			door = _list[i]
			break
		}
	}
}


if state == states.enterdoor
	visible = true

var doorOBJ = asset_get_index(string("obj_door{0}", door)), _hallway = -4;

if (instance_exists(doorOBJ))
{
    if (hallway == 2)
    {
        with doorOBJ _hallway = instance_place(x, y, obj_hallway_vertical)
        if _hallway == -4 exit
        x = _hallway.x + savedpos * _hallway.sprite_width
        y = doorOBJ.y + hallwayDirection * 100
		while scr_solid(x,y)
			x = approach(x, _hallway.x + _hallway.sprite_width/2, 1)
        vsp = savedspd;
    }
    else
    {
        if (hallway)
            x = doorOBJ.x + 16 + (192 * hallwayDirection);
        else
            x = doorOBJ.x + 16;
        y = doorOBJ.y - 14;
    }
}

if (place_meeting(x, y + 4, obj_ballofbeer) || place_meeting(x, y - 16, obj_ballofbeer))
{
    hallway = false;
    state = states.crouch;
}

if door == "BACKTOHUB"
{
	x = backtohubX
	y = backtohubY
    state = states.walkfront;
    image_index = 0;
    sprite_index = sprites.walkfront;
}

if (place_meeting(x, y, obj_door) || place_meeting(x, y, obj_exitgate) || place_meeting(x, y, obj_magicianDoor) || place_meeting(x, y, obj_levelgate) || (place_meeting(x, y, obj_keydoor) && state == states.enterdoor && !instance_exists(obj_backtohub)))
{
    state = states.walkfront;
    image_index = 0;
    sprite_index = sprites.walkfront;
}

with (obj_followplayer)
{
    ds_queue_clear(followqueue);
    gx = other.x;
    gy = other.y;
    x = gx;
    y = gy;
}

with (obj_hipnatuese)
{
    if (room == rank_room)
    {
        instance_destroy();
        instance_create(900, 900, obj_hipnatueseDead);
        exit;
    }
    
    image_alpha = 0;
    hsp = 0;
    vsp = 0;
    x = obj_player.x;
    y = obj_player.y;
}

roomstartX = x;
roomstartY = y;

if _secreterror
{
	state = -4
	sprite_index = sprites.groundpound;
	with instance_create(x, y, obj_secretStart)
	{
		cutscene = true;
	    sprite_index = spr_dudle_open;
	    image_index = 0;
	    FMODevent_oneshot("event:/Sfx/General/Level/Progression/exitpage", x, y);
	}
}