if is_transfo_all(other.state)
    exit;

if (other.grounded && pky_up && other.state != scr_player_enterdoor && other.state != scr_player_walkfront && other.state != scr_player_snowball)
{
    with (other)
    {
        targetRoom = other.targetRoom;
        door = other.targetDoor;
        hallway = false;
        movespeed = 0;
        vsp = 0;
        hsp = 0;
        state = scr_player_enterdoor;
        sprite_index = sprites.lookdoor;
        image_index = 0;
    }
}
