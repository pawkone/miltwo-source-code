var _names = struct_get_names(global.PlayerCharacters[select].sprites.player)
var _pre = string_delete(sprite_get_name(get_baconera(spr_player_idle, select)), -4, 4)
sprites = []
for (var i = 0; i < array_length(_names); i++)
{
	var _spr = struct_get(global.PlayerCharacters[select].sprites.player, _names[i])
	var _n = sprite_get_name(_spr)
	if _spr > 0 && string_starts_with(_n, _pre)
		array_push(sprites,_spr)
}
spriteslen = array_length(sprites)
if spriteslen == 0
{
	sprites = [spr_playerN_knightidle]
	spriteslen = 1
}
sprite_index = sprites[irandom(spriteslen-1)]
image_index = 0