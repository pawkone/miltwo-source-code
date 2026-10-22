if plrId >= 0
{
	if plrUpdateDelay-- < 0
	{
		plrUpdateDelay = 3
		var _size = 48, _data = []
		array_push(_data, buffer_u8, multiplayerType.updatePlayer)
		array_push(_data, buffer_u8, plrId)
		array_push(_data, buffer_u16, plrObj.sprite_index)
		array_push(_data, buffer_u8, wrap(plrObj.image_index,0,255))
		array_push(_data, buffer_u16, clamp(plrObj.x+100,0,65535))
		array_push(_data, buffer_u16, clamp(plrObj.y+100,0,65535))
		array_push(_data, buffer_u8, plrObj.image_speed*255)
		array_push(_data, buffer_s8, plrObj.squashX * plrObj.xscaleMulti * 50)
		array_push(_data, buffer_s8, plrObj.squashY * plrObj.yscaleMulti * 50)
		
		var flags = 0
		flags |= bool(plrObj.flash) << 0
		flags |= bool(plrObj.xscale == -1) << 1
		flags |= bool(instance_exists(obj_chargeeffect) && plrObj.state == states.mach3) << 2
		flags |= bool(instance_exists(obj_chargeeffect) && plrObj.state == states.groundpound) << 3
		flags |= bool(plrObj.breakdancespeed > 0.5 && plrObj.sprite_index == plrObj.sprites.breakdance) << 4
		array_push(_data, buffer_u8, flags)
		
		array_push(_data, buffer_u16, plrObj.sprites.palette)
		array_push(_data, buffer_u8, plrObj.palIndex)
		array_push(_data, buffer_u16, global.patternSpr)
		array_push(_data, buffer_u16, room)
		with plrObj
		{
			if state == states.walkfront && sprite_index == sprites.walkfront
				array_push(_data, buffer_u8, (image_index / image_number) * 255)
			else
				array_push(_data, buffer_u8, 255)
		}
		
		if isHost
			sendDataHost(_data, _size)
		else
			sendDataClient(_data, _size)
	}
}
for (var i = 0; i < array_length(plrList); i++)
{
	if plrList[i] <= 0
	{
		plrDrawExtra[i] = -4
		plrDraw[i] = -4
	}
	else
		plrList[i]--
}