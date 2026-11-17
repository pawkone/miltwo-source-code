if rain
{
	repeat 7
		instance_create(0,0,obj_yardDrop)
	var _camx = obj_handlerCamera.camera.x - (obj_handlerCamera.camera.width / 2), _camy = obj_handlerCamera.camera.y - (obj_handlerCamera.camera.height / 2)
	repeat 2
	{
		with instance_create(0,0,obj_yardDrop)
			x = _camx + random(960)
	}
}