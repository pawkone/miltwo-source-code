characterOld = character

xdata_open(global.saveFile)
if xdata_read("Modded", "c_char", -4) != character
{
	xdata_write("Modded", "c_char", character)
	obj_savesystem.saveiconTimer = 60
}
xdata_close()

sprites = global.PlayerCharacters[character].sprites.player;
spr_palette = global.PlayerCharacters[character].sprites.player.palette;
global.patternSpr = global.PlayerCharacters[character].patternSpr;

scr_playerSounds_load()