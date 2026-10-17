if improvedyard_rain
{
	repeat 7
		instance_create(0,0,obj_yardDrop)
	var _camx = camera.x - (camera.width / 2), _camy = camera.y - (camera.height / 2)
	repeat 2
	{
		with instance_create(0,0,obj_yardDrop)
			x = _camx + random(960)
	}
}