shake = lerp(shake, 0, 0.15)
if distance_to_object(obj_player) > 128
{
	if openned == 1
	{
		openned = 0
		shake_camera(5)
		shake = 25
		event_user(0)
	}
}
else
{
	if (exiting)
	{
		obj_player.visible = false
		obj_player.image_index = 0
		timer++
		with obj_player
		{
			if other.timer == 35 || other.timer == 60 || other.timer == 90
			{
				other.shake = 30
				shake_camera(4)
				FMODevent_oneshot("event:/Sfx/Player/" + choose("punch", "hurt", "slip"), x, y);
			}
			if other.timer == 100 || pky_jump2
			{
				other.exiting = false
				other.timer = 0
				other.openned = 1
				visible = true
				var _ran = irandom(7)
				if _ran == 5
				{
					image_speed = 0.35
					state = states.slip
					xscale = choose(-1,1)
					movespeed = irandom(7)
					vsp = -16
					sprite_index = spr_player_slipsyrup
					image_index = 0
					FMODevent_oneshot("event:/Sfx/Player/slip", x, y)
				}
				else if _ran == 4
				{
					image_speed = 0.35
					state = states.hurt
					xscale = choose(-1,1)
					hsp = irandom(8) * xscale
					vsp = -12
					flash = true
					sprite_index = irandom(1) ? spr_player_hurt : spr_player_hurt2
					image_index = 0
					FMODevent_oneshot("event:/Sfx/Player/hurt", x, y)
				}
				else
					FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
				shake_camera(20)
				other.shake = 50
				with other
					event_user(0)
			}
		}
	}
	else if (entering)
	{
		obj_player.x = lerp(obj_player.x, x + (sprite_width / 2), 0.075)
		timer++
		with obj_player
		{
			visible = false
			if animation_end()
				image_index = image_number-1
			if pky_jump2 && other.timer < 130
			{
				if other.openned == 1
				{
					image_index = 0
					other.openned = 0
					shake_camera(25)
					with other
						event_user(0)
				}
				other.timer = 130
			}
			if other.timer == 110
			{
				other.openned = 0
				shake_camera(20)
				other.shake = 50
				with other
					event_user(0)
			}
			if other.timer == 160
			{
				with other
					enterfunc()
			}
		}
	}
	else
	{
		if openned == 0
		{
			openned = 1
			shake_camera(5)
			shake = 25
			event_user(0)
		}
	}
}
if sign(openspd) != (1-(openned*2))
	openspd = 0
openspd += (1-(openned*2))*0.05
openspd = clamp(openspd, -0.5, 0.5)
openamount = approach(openamount, openned, abs(openspd))