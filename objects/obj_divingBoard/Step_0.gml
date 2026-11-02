with (obj_player)
{
    if (state != scr_player_diveboard && place_meeting(x, y + 1, other) && vsp >= 0 && grounded)
    {
        diveboardSaved.movespeed = movespeed;
        diveboardSaved.state = state;
        diveboardSaved.sprite_index = sprite_index;
        diveboardSaved.image_index = image_index;
        diveboardSaved.y = y;
        state = scr_player_diveboard;
    }
}
