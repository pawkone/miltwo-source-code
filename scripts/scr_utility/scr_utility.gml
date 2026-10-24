gml_pragma("optimise", "js_array_check", "push, false");gml_pragma("optimise", "js_error_check", "push, false");gml_pragma("optimise", "js_check_index", "push, false");gml_pragma("optimise", "js_pre_post_no_long", "push, true");gml_pragma("optimise", "js_use_infix_ops", "push, true");gml_release_mode(true);texturegroup_set_mode(true, false);scheduler_resolution_set(16);gc_target_frame_time(-100);ds_set_precision(0.001)
globalvar wsbMOmInfo; wsbMOmInfo = {}; wsbMOmInfo.version = "???"; try{wsbMOmInfo = json_parse(loadString("gameData/wsbMOmInfo.json"))}catch(e){}; wsbMOmInfo.dir = game_save_id + "ohMiltu/" ;wsbMOmInfo.opt = wsbMOmInfo.dir + "settings.xda"
randomise()

#macro premode (os_type == os_linux)

global.username = string("player{0}",irandom_range(1000,9999))
wsbMOmInfo.options = [
"Modded;machdoublejump;0",
"Modded;phototaunt;0",
"Modded;spammabletaunt;0",
"Modded;oldsecreteye;0",
"Modded;bettermilton;0",
"Modded;betterwaybackyard;0",
"Modded;sloperotation;0",
]

xdata_open(wsbMOmInfo.opt)

for (var i = 0; i < array_length(wsbMOmInfo.options); i++)
{
	wsbMOmInfo.options[i] = string_split(wsbMOmInfo.options[i],";",true)
	wsbMOmInfo.options[i][2] = real(wsbMOmInfo.options[i][2])
	var _e = wsbMOmInfo.options[i]
	variable_global_set(string("{0}_{1}", string_lower(_e[0]), _e[1]), xdata_read(_e[0], _e[1], _e[2]))
}

window_enable_borderless_fullscreen(true)

global.MasterVolume = xdata_read("General", "Master", 1);
global.MusicVolume = xdata_read("General", "Music", 1);
global.SfxVolume = xdata_read("General", "Sfx", 0.8);
global.Fullscreen = xdata_read("General", "Fullscreen", 0);
switch (global.Fullscreen)
{
    case 1:
        window_set_fullscreen(true);
        break;
    case 2:
        window_enable_borderless_fullscreen(true);
        window_set_fullscreen(true);
        break;
}
global.vsync = xdata_read("General", "Vsync", false);
global.hide_hud = xdata_read("Visual", "showHud", false);
global.unfocus_mute = xdata_read("General", "UnfocusMute", true);
global.dirSuper = xdata_read("General", "dirSuper", true);
global.dirGround = xdata_read("General", "dirGround", true);
global.windowSize = xdata_read("General", "Windowsize", 1);
global.texFilter = xdata_read("General", "texFilter", false);
display_reset(0, global.vsync)
gpu_set_tex_filter(global.texFilter)
var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]]
window_set_size(res[global.windowSize][0], res[global.windowSize][1])
window_center()
xdata_close()

function loadString(arg0)
{
	if file_exists(arg0)
	{
	    var _buff = buffer_load(arg0)
	    var _str = buffer_read(_buff, buffer_string)
	    buffer_delete(_buff)
	    return _str
	}
	else
		return ""
}

function gpu_set_blendmode_default()
{
	gpu_set_blendmode(bm_normal)
}

function scr_fadeout(_accel = 0.1)
{
	if instance_exists(obj_fadeout)
	{
		with obj_fadeout
		{
			if !fadein
			{
				instance_destroy(obj_fadeout)
				with instance_create(0,0,obj_fadeout)
					accel = _accel
				return true
			}
		}
	}
	else
	{
		with instance_create(0,0,obj_fadeout)
			accel = _accel
		return true
	}
	return false
}

function shader_sset(shader)
{
	if premode exit
	shader_set(shader)
}

function levelgetname(_t)
{
	switch _t
	{
		case "dudles": return "! The Dudles In The Notebook"
		
		//floor 1
		case "tutorial": return "Overgrown Flo' Patch"
		
		case "yard": return "Way Backyard?"
		case "beach": return "Fruitcup Coast"
		case "shell": return "Shell O' City"
			
		//floor 2
		case "frontyard": return "! Beaker's Frontyard"
		case "clock": return "! Courted Clocks"			
		case "outbreak": return "! Radiation Outbreak"			
		
		//floor extra
		case "crashout": return "Crashout City (Crashout Era)"
		case "bottom": return "Rock Bottom (Dream Era)"
		case "beaker": return "! Beaker Backyard (Twisted Era)"
	}
	return _t
}

function scr_savelevel()
{
    xdata_open(global.saveFile);
    var _rankString = "D";
    
	if scr_Prank() _rankString = "P";
	else if (global.collect >= global.Srank) _rankString = "S";
	else if (global.collect >= global.Arank) _rankString = "A";
	else if (global.collect >= global.Brank) _rankString = "B";
    else if (global.collect >= global.Crank) _rankString = "C";
	
    if (xdata_read(global.level, "Highscore", 0) < global.collect)
    {
        xdata_write(global.level, "Highscore", global.collect);
        xdata_write(global.level, "Rank", _rankString);
        xdata_write(global.level, "Toppin1", global.toppins[0]);
        xdata_write(global.level, "Toppin2", global.toppins[1]);
        xdata_write(global.level, "Toppin3", global.toppins[2]);
        xdata_write(global.level, "Toppin4", global.toppins[3]);
        xdata_write(global.level, "Toppin5", global.toppins[4]);
        xdata_write(global.level, "Treasure", global.treasure);
        xdata_write(global.level, "Secrets", global.secretCount);
    }
    
    obj_savesystem.saveiconTimer = 60;
    xdata_close();
}

function animation_end()
{
    return (image_index + (image_speed * sprite_get_speed(sprite_index))) >= image_number;
}

function shake_camera(arg0, arg1)
{
    if (is_undefined(arg1))
        arg1 = arg0;
    
    obj_camera.cameraShakeTimer += arg1;
    obj_camera.cameraShake += arg0;
}

function tv_anim(arg0, arg1 = 0)
{
    with (obj_hud.tv)
    {
        if (expressionSprite != arg0)
        {
            switchindex = 0;
            state = states.move;
            expressionSprite = arg0;
            expressionTimer = arg1;
        }
    }
}

function instance_create(obj_x, obj_y, obj, _varstruct = {})
{
    return instance_create_depth(obj_x, obj_y, 0, obj, _varstruct);
}

function scr_cutoff()
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
    {
        with instance_create(x + (_x * 32) + 32, y, obj_cutoff)
			image_angle = 180
        instance_create(x + (_x * 32), y + sprite_height, obj_cutoff);
    }
    
    for (var _y = 0; _y < abs(sprite_height / 32); _y++)
    {
        with instance_create(x + sprite_width, y + (_y * 32) + 32, obj_cutoff)
	        image_angle = 90
        with instance_create(x, y + (_y * 32), obj_cutoff)
			image_angle = -90
    }
}

function create_smalltext(arg0, arg1 = x, arg2 = y)
{
    instance_create(arg1, arg2, obj_smalltext).text = arg0;
}

function in_camera(arg0 = bbox_left, arg1 = bbox_right, arg2 = bbox_bottom, arg3 = bbox_top)
{
    var camx = camera_get_view_x(view_camera[0]);
    var camy = camera_get_view_y(view_camera[0]);
    var camw = camera_get_view_width(view_camera[0]);
    var camh = camera_get_view_height(view_camera[0]);
    return arg0 < (camx + camw) && arg1 > camx && arg3 < (camy + camh) && arg2 > camy;
}

function tile_delete(arg0, arg1)
{
    var layers = layer_get_all();
    
    for (var i = 0; i < array_length(layers); i++)
    {
        var lay = layers[i];
        var layer_name = layer_get_name(lay);
        
        if (layer_name != "Tiles_BG1" && layer_name != "Tiles_BG" && layer_name != "Tiles_BG2" && layer_name != "Tiles_BG3")
        {
            var ID = layer_get_id(layer_name);
            var tilemapID = layer_tilemap_get_id(ID);
            var tiledata = tilemap_get_at_pixel(tilemapID, arg0, arg1);
            tile_set_empty(tiledata);
            tilemap_set_at_pixel(tilemapID, 0, arg0, arg1);
        }
    }
}

function escape_background(arg0, arg1)
{
    for (var i = 0; i < array_length(layers_name); i++)
    {
        var ID = layer_get_id(layers_name[i]);
        var BGID = layer_background_get_id(ID);
        var BGSPR = layer_background_get_sprite(BGID);
        if (BGSPR == arg0 && global.escapeActive)
            layer_background_sprite(BGID, arg1);
        else if (BGSPR == arg1 && !global.escapeActive)
            layer_background_sprite(BGID, arg0);
    }
}

function scr_transfotip(arg0)
{
    instance_destroy(obj_transfotip);
    with (instance_create(x, y, obj_transfotip))
	{
        text = arg0;
		return id;
	}
	return -4;
}

function timeString(arg0)
{
    var _ms = array_last(string_split(string_format(arg0, 0, 2), "."))
	
	arg0 = floor(arg0)
	
    var _s = arg0 mod 60
    _s = (_s < 10 ? "0" : "") + string(_s)
	
    var _m = floor(arg0 / 60) mod 60
    _m = (_m < 10 ? "0" : "") + string(_m)
	
    var _h = floor(arg0 / 3600)
    _h = (_h < 10 ? "0" : "") + string(_h)
	
    return $"{_h}:{_m}:{_s}.{_ms}"
}