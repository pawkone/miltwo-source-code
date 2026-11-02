if character < 0 || character >= array_length(global.PlayerCharacters)
	character = 0

characterOld = character
sprites = global.PlayerCharacters[character].sprites.player;
spr_palette = global.PlayerCharacters[character].sprites.player.palette;
global.patternSpr = global.PlayerCharacters[character].patternSpr;
scr_playerSounds_load()