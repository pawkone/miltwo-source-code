function scr_player_beakerintro()
{
	if grounded && !place_meeting(x, y + 1, obj_destructibles)
	{
		if sprite_index == spr_player3_slipbanan1
		{
			FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y)
			vsp = -5
			image_index = 0
			image_speed = 0.35
			sprite_index = spr_player3_rockethitwall
		}
		else if sprite_index == spr_player3_rockethitwall
		{
			FMODevent_oneshot("event:/Sfx/Player/slipend", x, y)
			sprite_index = spr_player3_slipbanan2
		}
		else if animation_end()
			state = scr_player_normal
	}
}
