function scr_collide_destructibles()
{
	if (state == states.jump && vsp < 0)
	{
		if scr_collide_destructibles_helper(x,y,x, y + vsp * 1.33)
			vsp = 0
	}
	if (state == states.dreamcrusher || state == states.hammerwirl || state == states.mach2 || state == states.mach3 || state == states.grab || state == states.tumble || state == states.hammerattack || (sprite_index == spr_player_swingading && state == states.hauling) || state == states.snowball || state == states.dreamspin || state == states.dreambounce || state == states.retwistedBuzzsaw || state == states.groundpound || state == states.uppercut || state == states.superjump || state == states.buzzsaw || state == states.climbwall || state == states.skateboard || state == states.skateboardmove || state == states.skateboardwall || state == states.skateboardramp || state == states.slip || state = states.water)
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
