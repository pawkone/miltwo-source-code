var _plr = obj_player.id
if _plr < 0 exit
distance = distance_to_object(_plr)
bgalpha = 1 - (distance / visibleradius);
if cancel exit
if (scoreViewer == -4)
{
	if (distance_to_object(_plr) < 300)
	{
	    scoreViewer = instance_create(x + 12, camera_get_view_y(view_camera[0]) - 200, obj_scoreHub);
	    var _r = rank
	    with (scoreViewer)
	    {
			collect = other.collect
	        targetY = other.y - 175;
	        if (_r == "D")
	            rankIndex = 0;
	        if (_r == "C")
	            rankIndex = 1;
	        if (_r == "B")
	            rankIndex = 2;
	        if (_r == "A")
	            rankIndex = 3;
	        if (_r == "S")
	            rankIndex = 4;
	        if (_r == "P")
	            rankIndex = 5;
	    }
	}
}