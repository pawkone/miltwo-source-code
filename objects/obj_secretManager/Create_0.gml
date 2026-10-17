tiles = [];
collectables = [];
alarm[0] = 10;
layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++)
{
    var tileId = layer_tilemap_get_id(layers[i]);
    
    if (tileId != -1)
        array_push(tiles, tileId);
}

tiles = array_reverse(tiles);
patternPos = 0;
patternAlpha = 0;
fadein = true;
stateTimer = 90;
patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles));
tileSurf = surface_create(960, 540);
depth = 50;
need_mask_update = false;

if (array_length(tiles) == 0)
    instance_destroy();

dudles_text = -4
if global.level == "dudles"
{
	if room == secret_ending
	{
		with obj_exitgate
			openn = true
	}
	else
	{
		if room == secret_entrance
		{
			global.allsecrets = []
			for (var i = 0; i < array_length(global.rooms); i++)
			{
				if string_count("_secret", global.rooms[i])
					array_push(global.allsecrets, i)
			}
		}
		else
			dudles_text = array_length(global.allsecrets)
		with obj_secret
		{
			if array_length(global.allsecrets) == 0
				targetRoom = secret_ending
			else
			{
				var _index = irandom(array_length(global.allsecrets)-1)
				targetRoom = global.allsecrets[_index]
				array_delete(global.allsecrets, _index, 1)
			}
		}
	}
}
else if (room != hotel_soundtest && room != hotel_soundtestentrance)
{
	global.secretCount++;
	text_clear(lang_get_phrase("secret_get"));
	scr_transfotip(lang_get_phrase("secret_get"));
	if !room_exists(global.secretOriginRoom) || global.secretOriginRoom == room
	{
		var _newroom = asset_get_index(string_split(room_get_name(room), "_secret")[0] + "_1")
		if room_exists(_newroom)
		{
			scr_transfotip("ERROR: ORIGIN UNSET, SET EXIT " + room_get_name(_newroom))
			with obj_secret
				targetRoom = _newroom
		}
		else
		{
			scr_transfotip("ERROR: ORIGIN UNSET, EXIT NOT FOUND")
			with obj_secret
				targetRoom = room
		}
	}
}