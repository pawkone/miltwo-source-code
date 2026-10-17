global.saveroom = ds_list_create();
global.escaperoom = ds_list_create();
global.followers = ds_list_create();
global.collect = 0;
global.secretCount = 0;
global.treasure = false;
global.resetRoom = -4;
global.patternSpr = spr_playerPat_threads;
global.escape = 
{
	active: false,
	timer: 7200,
	party: false,
	lap3: false,
};
global.lap3checkpoint = {
	saveroom: ds_list_create(),
	escaperoom: ds_list_create(),
	collect: 0,
	combo_amt: 0,
	combo_dropped: 0,
	secret: 0,
	roomsaved: -4,
	doorsaved: "A",
}
global.combo = 
{
	dropped: false,
	amt: 0,
	timer: 60,
	previouscombo: 0,
	savecombo: 0,
	highest: 0
};
global.toppins = 
{
	bean: false,
	cup: false,
	lime: false,
	bag: false,
	orange: false
};
global.level_timer = 0;
global.save_timer = 0;
global.level = -4;
global.key = false;




ini_open(working_directory + "options.ini");
global.MasterVolume = ini_read_real("General", "Master", 1);
global.MusicVolume = ini_read_real("General", "Music", 1);
global.SfxVolume = ini_read_real("General", "Sfx", 0.8);
global.AmbianceVolume = ini_read_real("General", "Ambiance", 1);
global.Fullscreen = ini_read_real("General", "Fullscreen", 0);

switch (global.Fullscreen)
{
    case 0:
        break;
    
    case 1:
        window_set_fullscreen(true);
        break;
    
    case 2:
        window_enable_borderless_fullscreen(true);
        window_set_fullscreen(true);
        break;
}

global.vsync = ini_read_real("General", "Vsync", false);
global.hide_hud = ini_read_real("Visual", "showHud", false);
global.unfocus_mute = ini_read_real("General", "UnfocusMute", true);
global.dirSuper = ini_read_real("General", "dirSuper", true);
global.dirGround = ini_read_real("General", "dirGround", true);
global.windowSize = ini_read_real("General", "Windowsize", 1);
global.texFilter = ini_read_real("General", "texFilter", false);
global.modded_machdoublejump = ini_read_real("Modded", "machdoublejump", false);
global.modded_phototaunt = ini_read_real("Modded", "phototaunt", false);
global.modded_spammabletaunt = ini_read_real("Modded", "spammabletaunt", false);
global.modded_oldsecreteye = ini_read_real("Modded", "oldsecreteye", false);
global.modded_bettermilton = ini_read_real("Modded", "bettermilton", false);
global.modded_betterwaybackyard = ini_read_real("Modded", "betterwaybackyard", false);
global.modded_sloperotation = ini_read_real("Modded", "sloperotation", false);
display_reset(0, global.vsync);
gpu_set_tex_filter(global.texFilter);
var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]];
window_set_size(res[global.windowSize][0], res[global.windowSize][1]);
window_center();
ini_close();
ini_open(global.saveFile);
global.cutscenes.miltonIntro = ini_read_real("Cutscenes", "miltonIntro", false);
obj_player.palIndex = ini_read_real("Game", "Palette", 1);
ini_close();

global.connected = false;