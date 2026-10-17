with (other)
{
	door = other.targetDoor;
	targetRoom = other.targetRoom;
	hallway = true;
	hallwayDirection = -sign(other.image_yscale);
	savedspd = vsp;
	savedpos = clamp(abs(x - other.x) / other.sprite_width, 0, 1);
	hallway = 2;
	if scr_fadeout()
	{
		instance_destroy(other)
		FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
	}
}