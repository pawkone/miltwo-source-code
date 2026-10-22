var _asType = async_load[? "type"]

if isHost && (_asType == network_type_connect || _asType == network_type_disconnect)
{
	var _asSocket = async_load[? "socket"]
	switch _asType
	{
		case network_type_connect:
		
			plrList[_asSocket] = 240
			sendDataHost([
				buffer_u8, multiplayerType.assignId,
				buffer_u8, _asSocket
			], 8, _asSocket)
			
		break case network_type_disconnect:
			
			for (var i = 0; i < array_length(plrList); i++)
			{
				if plrList[i] == _asSocket
				{
					array_delete(plrList, i, 1)
					break
				}
			}
		
		break
	}
}
else if _asType == network_type_data
{
	if isHost
	{
		tempInfo = [async_load[? "socket"], async_load[? "buffer"]]
		event_user(0)
	}
	else
	{
		tempInfo = async_load[? "buffer"]
		event_user(1)
	}
}