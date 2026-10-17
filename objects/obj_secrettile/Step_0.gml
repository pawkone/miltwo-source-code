var _placeMeeting = false
with (obj_player)
{
	if place_meeting(x, y, obj_secrettile)
		_placeMeeting = true
}
alpha = approach(alpha, !_placeMeeting, 0.1)
active = _placeMeeting