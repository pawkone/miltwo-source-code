if array_length(textures) > 0
{
	texture_prefetch(textures[0])
	array_shift(textures)
}
else if array_length(langstuff_names) > 0
{
	var q = variable_struct_get(langstuff, langstuff_names[0]);
	var _spritePath = string("languageLookup/{0}_assets/{1}", global.language, q.path);
	if string_ends_with(_spritePath,".png")
	    ds_map_add(global.langMapArt, langstuff_names[0], sprite_add(_spritePath, 0, false, false, q.xorigin, q.yorigin));
	array_shift(langstuff_names);
}
else
{
	room_goto(initObject);
	exit
}
alarm[0] = 2
prg = (1 - ((array_length(textures)+array_length(langstuff_names)) / texturesMax))*445.36