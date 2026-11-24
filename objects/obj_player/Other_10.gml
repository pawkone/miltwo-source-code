if character < 0 || character >= array_length(global.PlayerCharacters)
	character = 0
	
xdata_open(global.saveFile)
if xdata_read("Modded", "c_char", -4) != obj_player.character
{
	xdata_write("Modded", "c_char", obj_player.character)
	with obj_handlerGameUI saveiconTimer = 60
}
xdata_close()

event_user(1)

characterOld = character
sprites = global.PlayerCharacters[character].sprites.player;
var tv_sprites = global.PlayerCharacters[character].sprites.tv
with obj_handlerGameUI
{
	if variable_instance_exists(id, "tv") && is_struct(tv)
		sprites = tv_sprites
}
spr_palette = global.PlayerCharacters[character].sprites.player.palette;
global.patternSpr = global.PlayerCharacters[character].patternSpr;
scr_playerSounds_load()

if palIndex < 0 || palIndex >= sprite_get_width(spr_palette)
	palIndex = 1