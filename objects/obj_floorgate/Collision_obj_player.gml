if (other.grounded && pky_up && other.state != states.enterdoor && other.state != states.walkfront && other.state != states.snowball)
{
	entering = true
    with (other)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = states.enterdoor;
        sprite_index = sprites.entergate;
        image_index = 0;
		with obj_music
			stop_music()
    }
}
