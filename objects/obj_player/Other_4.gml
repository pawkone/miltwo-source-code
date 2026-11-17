if door == "A" && room == beaker_1
{
	x = 500
	y = -752
	sprite_index = spr_player3_slipbanan1
	image_index = image_number - 1
	image_speed = 0
	door = "NONE"
	xscale = 1
	state = scr_player_beakerintro
	grounded = false
	hsp = 0
	vsp = -2
	if instance_exists(obj_titlecard)
		instance_destroy(obj_titlecard)
	if instance_exists(obj_fadeout)
		instance_destroy(obj_fadeout)
	with instance_create(0, 0, obj_fadeout)
	{
		image_alpha = 1
		accel = 0.05
		fadein = 0
	}
}

uparrow = 0
uparrowadd = 0

var doorOBJ = asset_get_index($"obj_door{door}"), _hallway = -1
if doorOBJ && instance_exists(doorOBJ)
{
	if hallway == 2
	{
		with doorOBJ
			_hallway = instance_place(x, y, obj_hallway_vertical)
		if _hallway
		{
			x = _hallway.x + savedpos * _hallway.sprite_width
			y = doorOBJ.y + hallwayDirection * 100
			while scr_solid(x,y)
				x = approach(x, _hallway.x + _hallway.sprite_width/2, 1)
			vsp = savedspd
		}
	}
	else
	{
		x = doorOBJ.x + 16 + (hallway ? (192 * hallwayDirection) : 0)
		y = doorOBJ.y - 14
	}
}
else if door == "BACKTOHUB"
{
	x = backtohubX
	y = backtohubY
    state = scr_player_walkfront;
    image_index = 0;
    sprite_index = sprites.walkfront;
}
if sprite_index == spr_player_downbox || sprite_index == spr_player_upbox
	state = scr_player_normal
else if (place_meeting(x, y, obj_door) || place_meeting(x, y, obj_exitgate) || place_meeting(x, y, obj_magicianDoor) || place_meeting(x, y, obj_levelgate) || (place_meeting(x, y, obj_keydoor) && state == scr_player_enterdoor && !instance_exists(obj_backtohub)))
{
    state = scr_player_walkfront
	visible = true
    image_index = 0
    sprite_index = sprites.walkfront
	if place_meeting(x, y, obj_exitgate)
	{
		obj_handlerCamera.hud_alpha = 0
		with instance_create(0,0,obj_titlecardFadeout)
		{
			circleSize = 0
			scene = 4
			fadeAlpha = 1
		}
	}
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

event_user(1)