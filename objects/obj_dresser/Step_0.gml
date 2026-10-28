if place_meeting(x, y, obj_player) && pky_up2 && obj_player.grounded
{
	if !instance_exists(obj_dressermenu)
		instance_create(0,0,obj_dressermenu)
	else
		obj_dressermenu.closee = false
}