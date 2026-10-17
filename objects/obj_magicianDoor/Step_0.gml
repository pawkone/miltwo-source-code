with (obj_player)
{
    if (state == states.enterdoor && animation_end() && place_meeting(x, y, other) && sprite_index == spr_player_doorunlock)
    {
		if scr_fadeout()
			FMODevent_oneshot("event:/Sfx/General/Level/Progression/door");
    }
}
