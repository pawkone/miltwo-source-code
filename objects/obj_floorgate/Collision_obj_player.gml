if (other.grounded && pky_up && other.state != scr_player_enterdoor && other.state != scr_player_walkfront)
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
        state = scr_player_enterdoor;
        sprite_index = sprites.entergate;
        image_index = 0;
		with obj_music
			stop_music()
    }
}
