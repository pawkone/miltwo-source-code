palmode_lrp = lerp(palmode_lrp, palmode_act, 0.25)
palmode_lrp = approach(palmode_lrp, palmode_act, 0.005)
onlrpbe = approach(onlrp, !closee, 0.35)
onlrp = lerp(onlrp, onlrpbe, 0.25)
onlrp = approach(onlrp, onlrpbe, 0.005)

if closee
{
	buffer = 5
	if onlrp <= 0
		instance_destroy()
	exit
}

with obj_player
{
	image_speed = 0.35
	sprite_index = sprites.idle
	state = -4
	hsp = 0
	vsp = 0
	movespeed = 0
}

if buffer < 0
{
	if !palmode_act
	{
		var _oldselect = select
		select += pky_down2 - pky_up2
		if select != oldSelect
		{
			FMODevent_oneshot("event:/Sfx/General/dresser");
			oldoldSelect = _oldselect
			selectadd -= (_oldselect-select)*175
			select = (select + select_count) mod select_count
			oldSelect = select
			selectthing = 1
			selectthinglrp = 1
		}
	}
	else
	{
		var _h = pky_right2 + pky_left2, _v = pky_down2 - pky_up2, _l = count_pal[select] - 1
		var _a = ((select_pal[select] - 1) div 4) * 4 + 1
		var _b = min(_a + 3, _l)
		if _h == -1 && select_pal[select] == _a
			select_pal[select] = _b
		else if _h == 1 && select_pal[select] == _b
			select_pal[select] = _a
		else
			select_pal[select] += _h
		if _v != 0
		{
			var _c = (select_pal[select] - 1) mod 4, _t = select_pal[select] + (_v * 4)
			if _t >= 1 && _t <= _l
				select_pal[select] = _t
			else if _v == 1 && select_pal[select] > _l - 4
				select_pal[select] = _c + 1
			else if _v == -1 && select_pal[select] <= 4 && _l - ((_l - 1) mod 4) + _c <= _l
				select_pal[select] = _l - ((_l - 1) mod 4) + _c
		}
	}

	if pky_grab2 || pky_start2
	{
		if palmode_act
			palmode_act = 0
		else
			closee = true
	}
	else if pky_jump2
	{
		if !palmode_act
			palmode_act = 1
		else
		{
			palmode_act = 0
			obj_player.character = select
			obj_player.palIndex = select_pal[select]
			with obj_player
			{
				event_user(0)
				sprite_index = sprites.idle
				image_index = 0
				image_speed = 0.35
				state = scr_player_normal
				hsp = 0
				vsp = 0
				movespeed = 0
				grounded = true
				doTaunt(true, false)
			}
	
			xdata_open(global.saveFile)
			if xdata_read("Modded", "c_pal", -4) != obj_player.palIndex
			{
				xdata_write("Modded", "c_pal", obj_player.palIndex)
				with obj_handlerGameUI saveiconTimer = 60
			}
			xdata_close()
	
			closee = true
		}
	}
}
else
	buffer--
selectspd = lerp(selectspd, -selectadd * 0.15, 0.3)
selectadd += selectspd

selectthing = approach(selectthing, 0, 0.3)
selectthinglrp = lerp(selectthinglrp, selectthing, 0.15)