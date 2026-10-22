miltwocredits_credits = 
[
	["Back", "note : press confirm on any person to see all\nsprites they did or view music tracks they composed..."],
	[
		"Pawkone",
		"director : coder : artist : ideas : etc",
		spr_milton_rollstart, spr_baconsmacon_deadlintro, spr_baconsmacon_deadloop,
		spr_bacadmadLocate, spr_minilogo, spr_menunew, spr_menunew_tvhint,
		spr_gate_shell, spr_floorgate, spr_floorgate_over, spr_uparrow,
		spr_titlecardShell, spr_titlecardShellTitle1, tilespr_fruitcup,
		tilespr_hotel2,
	],
	[
		"MrAlt- (Ex Miltu Member)",
		"former co director : coder : level designer",
		tilespr_frontyard, tilespr_outbreak
	],
	[
		"Targetbuldoser (Ex Miltu Member)",
		"artist : composer : ideas",
		spr_milton_mach1, spr_milton_mach2, spr_milton_mach3turn, spr_milton_wallslide,
		spr_player0_groundpoundstart, spr_player0_groundpound, spr_player0_groundpoundbump,
		spr_soda, spr_tv_soda, spr_titlecardFrontyard, spr_titlecardFrontyardTitle1
	],
	[
		"Toasty64 (Ex Miltu Member)",
		"coder : artist : ideas",
		spr_player_chat
	],
	[
		"PaintlesNoise (Ex Miltu Member)",
		"artist",
		spr_tv_happyT, spr_milton_mach3turnfall
	],
	[
		"Polyg0n5",
		"volunteered artist : artist for og miltu",
		spr_butterAir, spr_butterGround, spr_pepperni_mach1, spr_pepperni_mach3,
		spr_pepperni_taunt, spr_milton_jump, spr_milton_fall, spr_titlecardFruitcup,
		spr_titlecardFruitcupTitle1, spr_titlecardFruitcupTitle2
	],
	[
		"ElCacas.XD.RenovadoXD",
		"volunteered artist",
		spr_pepperni_idleanim1
	],
	[
		"CoolGuy_The_Guy",
		"volunteered composer",
		mu_peppernilap2
	],
]
miltwocredits_creditsshow = []
miltwocredits_selected = 0
miltwocredits_yoffset = 0
miltwocredits_starty = []
miltwocredits_startoffset = []
miltwocredits_extendview_enabled = false
miltwocredits_extendview_selected = 0

var _yy = 0, kl = array_length(miltwocredits_credits)
draw_set_font(global.creditsfont)
for (var k = 0; k < kl; k++)
{
	miltwocredits_starty[k] = _yy
	var ki = miltwocredits_credits[k]
	var kil = array_length(ki)
	miltwocredits_creditsshow[k] = [ki[0], ki[1]]
	_yy += string_height(ki[0])
	var _yoffset = 0
	for (var j = 2; j < kil; j++)
	{
		if sprite_exists(ki[j])
		{
			var _h = sprite_get_height(ki[j])
			if _h < 200
			{
				array_push(miltwocredits_creditsshow[k], ki[j])
				_yoffset = max(_yoffset, _h)
			}
		}
	}
	_yy += _yoffset+48
	miltwocredits_startoffset[k] = _yoffset+48
}

buffer = 0;
menus = [];
currentmenu = 0;
selected = 0;
move = 0;
backgrounds = [];
changingBind = false;
keyscroll = 0;
desc_text = ""
desc_alpha = 0

enum optionstype
{
	mainpage, // 0
	audio, // 1
	video, // 2
	window, // 3
	controls, // 4
	controls_keyboard, // 5
	controls_keyboard_config, // 6
	controls_pad, // 7
	controls_pad_config, // 8
	controls_pad_deadzones, // 9
	game, // 10
	anchor_center, // 11
	anchor_left, // 12
	anchor_controls, // 13
	element_button, // 14
	element_toggle, // 15
	element_slider, // 16
	element_bind, // 17
	modded,
	modded_old,
	modded_custom,
	credits,
	anchor_credits,
}

var addBackground = function(arg0 = [], arg1, arg2 = 0)
{
    var q = 
    {
        menu: arg0,
        index: arg1,
        alpha: arg2
    };
    array_push(backgrounds, q);
};

addBackground([0], 0, 1);
addBackground([1], 1);
addBackground([2, 10], 2);
addBackground([3], 3);
addBackground([4, 5, 6, 7, 8, 9], 4);
BGX = 0
depth = obj_pause.depth - 1;
screamSnd = FMODcreate_event("event:/Sfx/UI/Pause/slider");
fmod_studio_event_instance_start(screamSnd);
fmod_studio_event_instance_set_paused(screamSnd, true);

addPause_icon = function(arg0) constructor
{
    index = arg0;
    alpha = 0;
};

goto_menu = function(arg0)
{
    for (var i = 0; i < array_length(menus); i++)
    {
        var m = menus[i];
        
        if (m.menuid == arg0)
            currentmenu = i;
    }
    
    show_debug_message(currentmenu);
    selected = 0;
};

create_menu = function(arg0, arg1, arg2, arg3)
{
    var _opt = 
    {
        menuid: arg0,
        anchor: arg1,
        ypad: arg2,
        options: [],
        backfunc: arg3,
    };
    return _opt;
};

add_option_press = function(arg0, arg1, arg2, arg3 = -4)
{
    var q = 
    {
        name: arg1,
        func: arg2,
        type: optionstype.element_button,
        selecting: false,
        icon: arg3,
		desc: "",
    };
	if string_starts_with(q.name, "option_modded_")
	{
		q.desc = string_replace(q.name, "option_modded_", "option_modded_desc_")
		q.name = string_replace(q.name, "option_modded_", "option_modded_title_")
	}
    array_push(arg0.options, q);
    return q;
};

add_option_ext = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = ["option_off", "option_on"])
{
    var q = 
    {
        specialNumber: 0,
        name: arg2,
        func: arg3,
        val: arg4,
        toggle: arg6,
        type: arg1,
        max: arg5,
        moving: false,
        selecting: false,
		desc: "",
    };
	if string_starts_with(q.name, "option_modded_")
	{
		q.desc = string_replace(q.name, "option_modded_", "option_modded_desc_")
		q.name = string_replace(q.name, "option_modded_", "option_modded_title_")
	}
    array_push(arg0.options, q);
    return q;
};

add_option_key = function(arg0, arg1, arg2, arg3 = "k-leftKey")
{
    var q = 
    {
        type: optionstype.element_bind,
        iconIndex: arg1,
        key: arg3,
        func: arg2,
        selecting: false,
		desc: ""
    };
    array_push(arg0.options, q);
    return q;
};

var category = create_menu(optionstype.mainpage, optionstype.anchor_center, 48, function()
{
    obj_pause.buffer = 2;
    instance_destroy();
});

add_option_press(category, "option_audio", function()
{
    goto_menu(optionstype.audio);
}, new addPause_icon(4));
add_option_press(category, "option_video", function()
{
    goto_menu(optionstype.video);
}, new addPause_icon(5));
add_option_press(category, "option_game", function()
{
    goto_menu(optionstype.game);
}, new addPause_icon(6));
add_option_press(category, "option_controls", function()
{
    goto_menu(optionstype.controls);
}, new addPause_icon(7));
add_option_press(category, "option_modded", function()
{
    goto_menu(optionstype.modded);
}, new addPause_icon(8));
add_option_press(category, "option_credits", function()
{
	buffer = 2
    goto_menu(optionstype.credits);
}, new addPause_icon(8));
array_push(menus, category);
var AUDIO = create_menu(optionstype.audio, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
	xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Music", global.MusicVolume);
    xdata_write("General", "Sfx", global.SfxVolume);
    xdata_write("General", "Master", global.MasterVolume);
    xdata_write("General", "Ambiance", global.AmbianceVolume);
    xdata_write("General", "UnfocusMute", global.unfocus_mute);
	xdata_close()
});
add_option_press(AUDIO, "option_back", function()
{
    goto_menu(optionstype.mainpage);
	xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Music", global.MusicVolume);
    xdata_write("General", "Sfx", global.SfxVolume);
    xdata_write("General", "Master", global.MasterVolume);
    xdata_write("General", "Ambiance", global.AmbianceVolume);
    xdata_write("General", "UnfocusMute", global.unfocus_mute);
	xdata_close()
});
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_master", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MasterVolume = q.val / 100;
    q.val = global.MasterVolume * 100;
}, global.MasterVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_music", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MusicVolume = q.val / 100;
    q.val = global.MusicVolume * 100;
}, global.MusicVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_ambiance", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.AmbianceVolume = q.val / 100;
    q.val = global.AmbianceVolume * 100;
}, global.AmbianceVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_sfx", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.SfxVolume = q.val / 100;
    q.val = global.SfxVolume * 100;
}, global.SfxVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_toggle, "option_audio_unfocus", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.unfocus_mute = q.val;
    q.val = global.unfocus_mute;
}, global.unfocus_mute, 1);
var VIDEO = create_menu(optionstype.video, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
	xdata_open(wsbMOmInfo.opt);
    xdata_write("Visual", "showHud", global.hide_hud);
    xdata_write("General", "Vsync", global.vsync);
    xdata_write("General", "Windowsize", global.windowSize);
    xdata_write("General", "texFilter", global.texFilter);
	xdata_close()
});
add_option_press(VIDEO, "option_back", function()
{
    goto_menu(optionstype.mainpage);
	xdata_open(wsbMOmInfo.opt);
    xdata_write("Visual", "showHud", global.hide_hud);
    xdata_write("General", "Vsync", global.vsync);
    xdata_write("General", "Windowsize", global.windowSize);
    xdata_write("General", "texFilter", global.texFilter);
	xdata_close()
});
add_option_press(VIDEO, "option_video_window_mode", function()
{
    goto_menu(optionstype.window);
});
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_resolution", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]];
    window_set_size(res[q.val][0], res[q.val][1]);
    window_center();
    global.windowSize = q.val;
    q.val = global.windowSize;
}, global.windowSize, 5, ["480 X 270", "960 X 540", "1024 X 576", "1280 X 720", "1600 X 900", "1920 X 1080"]);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_vsync", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.vsync = q.val;
    display_reset(0, global.vsync);
    q.val = global.vsync;
}, global.vsync, 1);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_filtering", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.texFilter = q.val;
    gpu_set_texfilter(global.texFilter);
    q.val = global.texFilter;
}, global.texFilter, 1);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_hide_hud", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.hide_hud = q.val;
    q.val = global.hide_hud;
}, global.hide_hud, 1);
var GAME = create_menu(optionstype.game, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(GAME, "option_back", function()
{
    goto_menu(optionstype.mainpage);
});
var controlsMain = create_menu(optionstype.controls, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(controlsMain, "option_back", function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(controlsMain, "option_controls_keyboard", function()
{
    goto_menu(optionstype.controls_keyboard);
});
add_option_press(controlsMain, "option_controls_controller", function()
{
    goto_menu(optionstype.controls_pad);
});
add_option_press(controlsMain, "option_controls_reset_config", function()
{
    reset_input();
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_reset_tip"));
    _s.depth = depth - 1;
});
var controlsKeyMain = create_menu(optionstype.controls_keyboard, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.controls);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "dirSuper", global.dirSuper);
    xdata_write("General", "dirGround", global.dirGround);
    xdata_close();
});
add_option_press(controlsKeyMain, "option_back", function()
{
    goto_menu(optionstype.controls);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "dirSuper", global.dirSuper);
    xdata_write("General", "dirGround", global.dirGround);
    xdata_close();
});
add_option_press(controlsKeyMain, "option_controls_bindings", function()
{
    goto_menu(optionstype.controls_keyboard_config);
});
add_option_ext(controlsKeyMain, optionstype.element_toggle, "option_controls_controller_dir_superjump", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.dirSuper = q.val;
    q.val = global.dirSuper;
}, global.dirSuper, 1);
add_option_ext(controlsKeyMain, optionstype.element_toggle, "option_controls_controller_dir_groundpound", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.dirGround = q.val;
    q.val = global.dirGround;
}, global.dirGround, 1);
var controlsPadMain = create_menu(optionstype.controls_pad, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.controls);
});
add_option_press(controlsPadMain, "option_back", function()
{
    goto_menu(optionstype.controls);
});
add_option_press(controlsPadMain, "option_controls_bindings", function()
{
    goto_menu(optionstype.controls_pad_config);
});
add_option_press(controlsPadMain, "option_controls_deadzones", function()
{
    goto_menu(optionstype.controls_pad_deadzones);
});
var controlsKey = create_menu(optionstype.controls_keyboard_config, optionstype.anchor_controls, 64, function()
{
    goto_menu(optionstype.controls_keyboard);
    var json = json_stringify(global.inputMap, false);
    var _file = file_text_open_write(global.inputFile);
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_press(controlsKey, "option_back", function()
{
    goto_menu(optionstype.controls_keyboard);
    var json = json_stringify(global.inputMap, false);
    var _file = file_text_open_write(global.inputFile);
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_key(controlsKey, 0, function()
{
}, "k-up");
add_option_key(controlsKey, 1, function()
{
}, "k-down");
add_option_key(controlsKey, 3, function()
{
}, "k-left");
add_option_key(controlsKey, 2, function()
{
}, "k-right");
add_option_key(controlsKey, 4, function()
{
}, "k-jump");
add_option_key(controlsKey, 5, function()
{
}, "k-slap");
add_option_key(controlsKey, 6, function()
{
}, "k-attack");
add_option_key(controlsKey, 7, function()
{
}, "k-taunt");
add_option_key(controlsKey, 8, function()
{
}, "k-start");
add_option_key(controlsKey, 9, function()
{
}, "k-superjump");
add_option_key(controlsKey, 10, function()
{
}, "k-groundpound");
add_option_key(controlsKey, "MENU LEFT", function()
{
}, "k-menu_left");
add_option_key(controlsKey, "MENU RIGHT", function()
{
}, "k-menu_right");
add_option_key(controlsKey, "MENU UP", function()
{
}, "k-menu_up");
add_option_key(controlsKey, "MENU DOWN", function()
{
}, "k-menu_down");
add_option_key(controlsKey, "MENU CONFIRM", function()
{
}, "k-menu_confirm");
add_option_key(controlsKey, "MENU BACK", function()
{
}, "k-menu_back");
add_option_key(controlsKey, "MENU CLEAR", function()
{
}, "k-menu_clear");
var controlsPad = create_menu(optionstype.controls_pad_config, optionstype.anchor_controls, 55, function()
{
    goto_menu(optionstype.controls_pad);
    var json = json_stringify(global.inputMap, false);
    var _file = file_text_open_write(global.inputFile);
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_press(controlsPad, "option_back", function()
{
    goto_menu(optionstype.controls_pad);
    var json = json_stringify(global.inputMap, false);
    var _file = file_text_open_write(global.inputFile);
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_key(controlsPad, 0, function()
{
}, "p-up");
add_option_key(controlsPad, 1, function()
{
}, "p-down");
add_option_key(controlsPad, 3, function()
{
}, "p-left");
add_option_key(controlsPad, 2, function()
{
}, "p-right");
add_option_key(controlsPad, 4, function()
{
}, "p-jump");
add_option_key(controlsPad, 5, function()
{
}, "p-slap");
add_option_key(controlsPad, 6, function()
{
}, "p-attack");
add_option_key(controlsPad, 7, function()
{
}, "p-taunt");
add_option_key(controlsPad, 8, function()
{
}, "p-start");
add_option_key(controlsPad, 9, function()
{
}, "p-superjump");
add_option_key(controlsPad, 10, function()
{
}, "p-groundpound");
add_option_key(controlsPad, "MENU LEFT", function()
{
}, "p-menu_left");
add_option_key(controlsPad, "MENU RIGHT", function()
{
}, "p-menu_right");
add_option_key(controlsPad, "MENU UP", function()
{
}, "p-menu_up");
add_option_key(controlsPad, "MENU DOWN", function()
{
}, "p-menu_down");
add_option_key(controlsPad, "MENU CONFIRM", function()
{
}, "p-menu_confirm");
add_option_key(controlsPad, "MENU BACK", function()
{
}, "p-menu_back");
add_option_key(controlsPad, "MENU CLEAR", function()
{
}, "p-menu_clear");
var DEADZONES = create_menu(optionstype.controls_pad_deadzones, optionstype.anchor_left, 55, function()
{
    goto_menu(optionstype.controls_pad);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("Deadzones", "general", global.gamepadDeadzones.general);
    xdata_write("Deadzones", "horiz", global.gamepadDeadzones.horizontal);
    xdata_write("Deadzones", "verti", global.gamepadDeadzones.vertical);
    xdata_write("Deadzones", "press", global.gamepadDeadzones.press);
    xdata_close();
});
add_option_press(DEADZONES, "option_back", function()
{
    goto_menu(optionstype.controls_pad);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("Deadzones", "general", global.gamepadDeadzones.general);
    xdata_write("Deadzones", "horiz", global.gamepadDeadzones.horizontal);
    xdata_write("Deadzones", "verti", global.gamepadDeadzones.vertical);
    xdata_write("Deadzones", "press", global.gamepadDeadzones.press);
	xdata_close()
});
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_general", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.general = q.val / 100;
    q.val = global.gamepadDeadzones.general * 100;
}, global.gamepadDeadzones.general * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_horiz", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.horizontal = q.val / 100;
    q.val = global.gamepadDeadzones.horizontal * 100;
}, global.gamepadDeadzones.horizontal * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_vert", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.vertical = q.val / 100;
    q.val = global.gamepadDeadzones.vertical * 100;
}, global.gamepadDeadzones.vertical * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_press", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.press = q.val / 100;
    q.val = global.gamepadDeadzones.press * 100;
}, global.gamepadDeadzones.press * 100, 100);
var windowMode = create_menu(optionstype.window, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.video);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Fullscreen", global.Fullscreen);
    xdata_close();
});
add_option_press(windowMode, "option_back", function()
{
    goto_menu(optionstype.video);
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Fullscreen", global.Fullscreen);
    xdata_close();
});
add_option_press(windowMode, "option_video_window_mode_windowed", function()
{
    goto_menu(optionstype.video);
    window_set_fullscreen(false);
    window_enable_borderless_fullscreen(false);
    global.Fullscreen = 0;
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Fullscreen", global.Fullscreen);
    xdata_close();
});
add_option_press(windowMode, "option_video_window_mode_fullscreen", function()
{
    goto_menu(optionstype.video);
    window_enable_borderless_fullscreen(false);
    window_set_fullscreen(true);
    global.Fullscreen = 1;
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Fullscreen", global.Fullscreen);
    xdata_close();
});
add_option_press(windowMode, "option_video_window_mode_borderless", function()
{
    goto_menu(optionstype.video);
    
    if (window_get_fullscreen())
        window_set_fullscreen(false);
    
    window_enable_borderless_fullscreen(true);
    window_set_fullscreen(true);
    global.Fullscreen = 2;
    xdata_open(wsbMOmInfo.opt);
    xdata_write("General", "Fullscreen", global.Fullscreen);
    xdata_close();
});

nonmod_menu = false
modded_save_options = function(){
	xdata_open(wsbMOmInfo.opt);
	for (var i = 0; i < array_length(wsbMOmInfo.options); i++)
	{
		var _e = wsbMOmInfo.options[i]
		xdata_write(_e[0], _e[1], variable_global_get(string("{0}_{1}", string_lower(_e[0]), _e[1])))
	}
	xdata_close()
}

var MODDED = create_menu(optionstype.modded, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
    modded_save_options()
});
add_option_press(MODDED, "option_back", function()
{
    goto_menu(optionstype.mainpage);
	modded_save_options()
});
add_option_press(MODDED, "option_modded_menucustom", function()
{
	 goto_menu(optionstype.modded_custom);
});
add_option_press(MODDED, "option_modded_menuoldies", function()
{
	 goto_menu(optionstype.modded_old);
});
add_option_press(MODDED, "option_modded_menuonline", function()
{
	instance_destroy()
	with obj_pause
		doUnpause()
	generalReset()
	room_goto(serverMenuShit)
});
array_push(menus, AUDIO);
array_push(menus, VIDEO);
array_push(menus, GAME);
array_push(menus, controlsMain);
array_push(menus, controlsKeyMain);
array_push(menus, controlsKey);
array_push(menus, controlsPadMain);
array_push(menus, controlsPad);
array_push(menus, DEADZONES);
array_push(menus, windowMode);
array_push(menus, MODDED);

var MODDED_OLD = create_menu(optionstype.modded_old, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.modded);
});
add_option_press(MODDED_OLD, "option_back", function()
{
    goto_menu(optionstype.modded);
});
add_option_ext(MODDED_OLD, optionstype.element_toggle, "option_modded_machdoublejump", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_machdoublejump = q.val;
	q.val = global.modded_machdoublejump;
}, global.modded_machdoublejump, 1);
add_option_ext(MODDED_OLD, optionstype.element_toggle, "option_modded_phototaunt", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_phototaunt = q.val;
	q.val = global.modded_phototaunt;
}, global.modded_phototaunt, 1);
add_option_ext(MODDED_OLD, optionstype.element_toggle, "option_modded_oldsecreteye", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_oldsecreteye = q.val;
	q.val = global.modded_oldsecreteye;
}, global.modded_oldsecreteye, 1);

array_push(menus, MODDED_OLD);

var MODDED_CUSTOM = create_menu(optionstype.modded_custom, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.modded);
});
add_option_press(MODDED_CUSTOM, "option_back", function()
{
    goto_menu(optionstype.modded);
});
add_option_ext(MODDED_CUSTOM, optionstype.element_toggle, "option_modded_betterwaybackyard", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_betterwaybackyard = q.val;
	q.val = global.modded_betterwaybackyard;
}, global.modded_betterwaybackyard, 1);
add_option_ext(MODDED_CUSTOM, optionstype.element_toggle, "option_modded_bettermilton", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_bettermilton = q.val;
	q.val = global.modded_bettermilton;
}, global.modded_bettermilton, 1);
add_option_ext(MODDED_CUSTOM, optionstype.element_toggle, "option_modded_spammabletaunt", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_spammabletaunt = q.val;
	q.val = global.modded_spammabletaunt;
}, global.modded_spammabletaunt, 1);
array_push(menus, MODDED_CUSTOM);
add_option_ext(MODDED_CUSTOM, optionstype.element_toggle, "option_modded_sloperotation", function()
{
	var m = menus[currentmenu];
	var opt = m.options;
	var q = opt[selected];
	global.modded_sloperotation = q.val;
	q.val = global.modded_sloperotation;
}, global.modded_sloperotation, 1);
array_push(menus, MODDED_CUSTOM);

var CREDITS = create_menu(optionstype.credits, optionstype.anchor_credits, 48, function()
{
    goto_menu(optionstype.mainpage);
});
array_push(menus, CREDITS);