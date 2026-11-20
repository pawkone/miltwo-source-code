function scr_collide_destructibles()
{
	if (state == scr_player_jump && vsp < 0)
	{
		if scr_collide_destructibles_helper(x, y + vsp)
			vsp = 0
	}
	else if (
		state == scr_player_hammerwirl
		|| state == scr_player_mach2
		|| state == scr_player_mach3
		|| state == scr_player_grab
		|| state == scr_player_hammerattack
		|| (sprite_index == spr_player_swingading && state == scr_player_hauling)
		|| state == scr_player_climbwall
		|| state == scr_player_skateboard
		|| state = scr_player_water
		|| state = scr_player_machslide
	)
		scr_collide_destructibles_helper(x + xscale + hsp, y + !grounded * vsp)
	else if (
		sprite_index = spr_milton_longjump
		|| sprite_index = spr_milton_longjumpend
		|| state == scr_player_dreamcrusher
		|| state == scr_player_skatenicCrusher
		|| state == scr_player_tumble
		|| state == scr_player_dreamspin
		|| state == scr_player_dreambounce
		|| state == scr_player_twistedBuzzsaw
		|| state == scr_player_twistedWallbounce
		|| state == scr_player_groundpound
		|| state == scr_player_uppercut
		|| state == scr_player_superjump
		|| state == scr_player_buzzsaw
		|| state == scr_player_climbwall
		|| state == scr_player_skateboardmove
		|| state == scr_player_skateboardwall
		|| state == scr_player_skateboardramp
		|| state == scr_player_slip
		|| state == scr_player_beakerintro
		|| state == scr_player_burned
	)
		scr_collide_destructibles_helper(x + xscale + hsp, y + vsp)
}

function scr_collide_destructibles_helper(xx,yy)
{
	if place_meeting(xx, yy, obj_destructibles)
	{
		var _list = ds_list_create()
		var _num = instance_place_list(xx, yy, obj_destructibles, _list, false)
		for (var i = 0; i < _num; i++)
			instance_destroy(_list[| i])
		ds_list_destroy(_list)
		return 1
	}
	return 0
}
