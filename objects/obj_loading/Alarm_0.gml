if array_length(textures) > 0
{
	texture_prefetch(textures[0])
	array_shift(textures)
}
else
{
	room_goto(initObject);
	exit
}
alarm[0] = 2
prg = (1 - (array_length(textures) / texturesMax))*445.36