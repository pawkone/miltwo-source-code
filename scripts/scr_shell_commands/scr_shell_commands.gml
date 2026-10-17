global.rooms = [];

for (var i = 0; room_exists(i); i++)
    global.rooms[i] = room_get_name(i);

function meta_noclip()
{
    return 
    {
        description: "ENABLES noclip"
    };
}

function sh_noclip(arg0)
{
    with (obj_player)
        state = states.noclip;
}

function meta_test_lap3()
{
    return 
    {
        description: "ENABLES noclip"
    };
}

function sh_test_lap3(arg0)
{
    global.escapeActive = 1
	global.escapeTimer = 36
	global.escapeLap = 3
	with obj_player
	{
        sprite_index = spr_player_spinout;
        image_speed = 0.35;
		image_index = 0
		door = "S"
		state = -4
		vsp = 0;
        hsp = 0;
        xscaleMulti = approach(xscaleMulti, 0, 0.05);
        yscaleMulti = approach(yscaleMulti, 0, 0.05);
        movespeed = 0;
	}
	room_goto(yard_11)
}

function meta_toggle_flipped()
{
    return 
    {
        description: "ENABLES the flipped modifier",
		arguments: ["bool"],
        suggestions: [["true", "false"]],
    };
}

function sh_toggle_flipped(arg0)
{
	if arg0[1] == "true" || arg0[1] == "1"
		global.modifiers.flipped = true
	else if arg0[1] == "false" || arg0[1] == "0"
		global.modifiers.flipped = false
	else if !is_bool(arg0[1])
		global.modifiers.flipped = !global.modifiers.flipped
	return string("flipped is now {0}", global.modifiers.flipped)
}

function meta_ranktest()
{
    return 
    {
        description: "tests a rank of your choice",
        arguments: ["rank"],
        suggestions: [["D", "C", "B", "A", "S", "P"]]
    };
}

function sh_ranktest(arg0)
{
    switch (arg0[1])
    {
        case "D":
        default:
            global.collect = 0;
            break;
        
        case "C":
            global.collect = global.Crank;
            break;
        
        case "B":
            global.collect = global.Brank;
            break;
        
        case "A":
            global.collect = global.Arank;
            break;
        
        case "S":
            global.collect = global.Srank;
            break;
        
        case "P":
            global.collect = global.Srank;
            global.escapeLap = 2
            global.combo.dropped = false;
            global.treasure = true;
            global.secretCount = 3;
            break;
    }
}

function meta_escape()
{
    return 
    {
        arguments: ["bool", "minutes", "seconds"],
        suggestions: [["true", "false"]],
        description: "enables escape sequence"
    };
}

function sh_escape(arg0)
{
    arg0[2] = real(arg0[2]);
    arg0[3] = real(arg0[3]);
    
    if (arg0[1] == "true")
        global.escapeActive = true;
    else if (arg0[1] == "false")
        global.escapeActive = false;
    else if (!is_bool(arg0[1]))
        global.escapeActive = !global.escapeActive;
    global.escapeTimer = (arg0[2] * 60 * 60) + (arg0[3] * 60);
    if (global.escapeActive)
    {
        instance_create(x, y, obj_goodmourning);
        instance_create(x, y, obj_whiteflash);
    }
}

function meta_goto_room()
{
    return 
    {
        arguments: ["room", "door"],
        suggestions: [global.rooms, ["A", "B", "C", "D", "E", "S"]],
        description: "teleports player into specified room."
    };
}

function sh_goto_room(arg0)
{
    with (obj_player)
    {
        targetRoom = asset_get_index(arg0[1]);
        door = arg0[2];
        hallway = false;
        if scr_fadeout()
		{
	        with (instance_nearest(0, 0, obj_fadeout))
	            targetRoom = other.targetRoom;
		}
    }
}

function meta_toggle_collisions()
{
    return 
    {
        arguments: ["bool"],
        suggestions: [["true", "false"]],
        description: "toggles collisions"
    };
}

function sh_toggle_collisions(arg0)
{
    if (arg0[1] == "true")
        global.showcollisions = true;
    else if (arg0[1] == "false")
        global.showcollisions = false;
    else if (!is_bool(arg0[1]))
        global.showcollisions = !global.showcollisions;
}

function meta_toggle_debug()
{
    return 
    {
        arguments: ["bool"],
        suggestions: [["true", "false"]],
        description: "toggles debugging mode"
    };
}

function sh_toggle_debug(arg0)
{
    if (arg0[1] == "true")
        global.debug = true;
    else if (arg0[1] == "false")
        global.debug = false;
    else if (!is_bool(arg0[1]))
        global.debug = !global.debug;
}


function meta_char()
{
	var _arr = []
	for (var i = 0; i < array_length(global.PlayerCharacters); i++)
		array_push(_arr, global.PlayerCharacters[i].name)
    return 
    {
        arguments: ["string"],
        suggestions: [_arr],
        description: "changes your character"
    };
}

function sh_char(arg0)
{
	with obj_player
	{
		var _arr = []
		for (var i = 0; i < array_length(global.PlayerCharacters); i++)
		{
			if arg0[1] == global.PlayerCharacters[i].name || arg0[1] == i
			{
				character = i
				break
			}
		}
	}
}