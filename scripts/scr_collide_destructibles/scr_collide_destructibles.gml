function scr_collide_destructibles()
{
	if (state == scr_player_jump && vsp < 0)
	{
		if scr_collide_destructibles_helper(x,y,x, y + vsp * 1.33)
			vsp = 0
	}
	if (state == scr_player_dreamcrusher || state == scr_player_hammerwirl || state == scr_player_mach2 || state == scr_player_mach3 || state == scr_player_grab || state == scr_player_tumble || state == scr_player_hammerattack || (sprite_index == spr_player_swingading && state == scr_player_hauling) || state == scr_player_snowball || state == scr_player_dreamspin || state == scr_player_dreambounce || state == scr_player_retwistedBuzzsaw || state == scr_player_groundpound || state == scr_player_uppercut || state == scr_player_superjump || state == scr_player_buzzsaw || state == scr_player_climbwall || state == scr_player_skateboard || state == scr_player_skateboardmove || state == scr_player_skateboardwall || state == scr_player_skateboardramp || state == scr_player_slip || state = scr_player_water)
		scr_collide_destructibles_helper(x, y, x + xscale + hsp * 1.33, y + vsp * 1.33)
}

function scr_collide_destructibles_helper(xx1,yy1,xx2,yy2)
{
	for (var j = 0; j <= 3; j++)
	{
		var t = j / 3
		var xx = lerp(xx1, xx2, t)
		var yy = lerp(yy1, yy2, t)
		if place_meeting(xx, yy, obj_destructibles)
		{
			var _list = ds_list_create()
			var _num = instance_place_list(xx, yy, obj_destructibles, _list, false)
			if _num > 0
			{
				for (var i = 0; i < _num; ++i)
					instance_destroy(_list[| i])
			}
			ds_list_destroy(_list)
			return true
		}
	}
	return false
}
