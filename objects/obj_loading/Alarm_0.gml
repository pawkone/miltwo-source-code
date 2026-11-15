if array_length(textures) > 0
{
	texture_prefetch(textures[0])
	array_shift(textures)
}
else
{
	instance_create(0,0,obj_shell)
	instance_create(0,0,obj_handlerAfterimage)
	instance_create(0,0,obj_handlerAudio)
	instance_create(0,0,obj_handlerCamera)
	instance_create(0,0,obj_handlerGameUI)
	instance_create(0,0,obj_handlerInput)
	instance_create(0,0,obj_handlerMusic)
	instance_create(0,0,obj_handlerPause)
	instance_create(0,0,obj_player)
	room_goto(Mainmenu)
	exit
}
alarm[0] = 2
prg = (1 - (array_length(textures) / texturesMax))*445.36