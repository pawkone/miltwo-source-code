if character < 0 || character >= array_length(global.PlayerCharacters)
	character = 0
	
xdata_open(global.saveFile)
if xdata_read("Modded", "c_char", -4) != obj_player.character
{
	xdata_write("Modded", "c_char", obj_player.character)
	obj_savesystem.saveiconTimer = 60
}
xdata_close()

event_user(1)

characterOld = character
sprites = global.PlayerCharacters[character].sprites.player;
spr_palette = global.PlayerCharacters[character].sprites.player.palette;
global.patternSpr = global.PlayerCharacters[character].patternSpr;
scr_playerSounds_load()