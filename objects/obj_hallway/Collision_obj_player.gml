with (other)
{
	door = other.targetDoor;
	targetRoom = other.targetRoom;
	hallway = true;
	hallwayDirection = other.dir;
	if scr_fadeout()
	{
		instance_destroy(other)
        FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
	}
}
