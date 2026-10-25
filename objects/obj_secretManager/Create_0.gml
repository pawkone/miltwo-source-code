collectables = [];
alarm[0] = 2;
layers = layer_get_all();

for (var i = 0; i < array_length(layers); i++)
{
    var tileId = layer_tilemap_get_id(layers[i]);
    if tileId != -1
        instance_create_depth(0,0,layer_get_depth(layers[i])-1,obj_secretShader).tile = tileId
}

thing_q = sprite_get_texture(spr_secretColors, 0)
thing_p = sprite_get_uvs(spr_secretColors, 0)
thing_s = texture_get_texel_height(thing_q)

patternPos = 0;
patternAlpha = 0;
fadein = true;
stateTimer = 90;
patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles));
depth = 90;

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
			dudles_text = array_length(global.allsecrets)+1
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
	global.secretCount++
	text_clear(lang_get_phrase("secret_get"))
	scr_transfotip(lang_get_phrase("secret_get"))
}