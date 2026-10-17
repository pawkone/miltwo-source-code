for (var i = 0; i < count; i++)
{
	if gamepad_is_connected(i) && !global.gamepadConnected
	{
	    global.gamepadConnected = true
	    global.gamepadCurrent = i
	}
}
alarm[0] = 60