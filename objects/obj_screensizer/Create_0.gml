xdata_open(wsbMOmInfo.opt)

depth = -998;
global.pausenew = false
global.debug = false
if global.gameframe_enabled
	gameframe_init();
global.gameframe_caption_text = "What's Shakin, Bacon?";
global.gameframe_caption_font = font_caption;
global.gameframe_caption_icon = spr_ico;
lap2alt = false
hue = 0;
huevsp = 0;
hueval = 0;
size = 1
partysover = false
partysovertime = 0
beat_time = 0
lap3_mult = 0
mouse_in_window = false;
gameframe_visible_time = 60;
mouseX = mouse_x;
mouseY = mouse_y;
displayWidth = 960;
displayHeight = 540;
gameSurface = -4;
size = 1;
x = 0;
y = 0;

beat_old = 0
beat_current = 0
huelrp = 0
hueonlrp = 0

__display_set_gui_size_hook(displayWidth, displayHeight)
application_surface_draw_enable(false)