ip = "127.0.0.1"

isHost = false
socket = -4
port = 2236
plrId = -4
plrObj = instance_find(obj_player,0)
plrList = array_create(49,240)
plrDraw = array_create(49,-4)
plrDrawExtra = array_create(49,-4)
plrDrawMe = 0
plrUpdateDelay = 0
tempInfo = -4

alarm[0] = 1

enum multiplayerType
{
	assignId,
	updatePlayer,
	createTaunt,
	createAfterimage,
	createParticle,
}

function sendDataClient(_data = [], _size = 8)
{
	var _buf = buffer_create(_size, buffer_fixed, 1)
	for (var i = 0; i < array_length(_data); i += 2)
		buffer_write(_buf, _data[i], _data[i+1])
	network_send_packet(socket,_buf,buffer_get_size(_buf))
	buffer_delete(_buf)
}

function sendDataHost(_data = [], _size = 8, _socket = -4)
{
	var _buf = buffer_create(_size, buffer_fixed, 1)
	for (var i = 0; i < array_length(_data); i += 2)
		buffer_write(_buf, _data[i], _data[i+1])
	if _socket >= 0
		network_send_packet(_socket,_buf,buffer_get_size(_buf))
	else
	{
		for (var i = 0; i < array_length(plrList); i++)
			network_send_packet(i,_buf,buffer_get_size(_buf))
	}
	buffer_delete(_buf)
}