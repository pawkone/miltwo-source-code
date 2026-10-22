if !instance_exists(obj_multiplayerHandler) exit
if onlineSynced exit
var _size = 32, _data = []
array_push(_data, buffer_u8, multiplayerType.createParticle)
array_push(_data, buffer_u16, room)
array_push(_data, buffer_u16, sprite_index)
array_push(_data, buffer_u8, wrap(image_index,0,255))
array_push(_data, buffer_u16, clamp(x+100,0,65535))
array_push(_data, buffer_u16, clamp(y+100,0,65535))
array_push(_data, buffer_u16, hsp*100)
array_push(_data, buffer_u16, vsp*100)
array_push(_data, buffer_u16, grav*100)
array_push(_data, buffer_u8, (image_angle/360)*255)
array_push(_data, buffer_u8, image_speed*255)
array_push(_data, buffer_s8, image_xscale)
array_push(_data, buffer_s16, depth)
with obj_multiplayerHandler
{
	if isHost
		sendDataHost(_data, _size)
	else
		sendDataClient(_data, _size)
}