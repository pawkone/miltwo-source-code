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

	select_pal[select] += pky_right2 + pky_left2
	if select_pal[select] <= 0
		select_pal[select] = count_pal[select]-1
	else if select_pal[select] >= count_pal[select]
		select_pal[select] = 1

	if pky_jump2
	{
		obj_player.character = select
		obj_player.palIndex = select_pal[select]
		with obj_player
		{
			event_user(0)
			sprite_index = sprites.idle
			image_index = 0
			image_speed = 0.35
			state = states.normal
			hsp = 0
			vsp = 0
			movespeed = 0
			grounded = true
			doTaunt(true, false)
		}
	
		xdata_open(global.saveFile)
		if xdata_read("Modded", "c_char", -4) != obj_player.character
		{
			xdata_write("Modded", "c_char", obj_player.character)
			obj_savesystem.saveiconTimer = 60
		}
		if xdata_read("Modded", "c_pal", -4) != obj_player.palIndex
		{
			xdata_write("Modded", "c_pal", obj_player.palIndex)
			obj_savesystem.saveiconTimer = 60
		}
		xdata_close()
	
		closee = true
	}
}
else
	buffer--
selectspd = lerp(selectspd, -selectadd * 0.15, 0.3)
selectadd += selectspd

selectthing = approach(selectthing, 0, 0.3)
selectthinglrp = lerp(selectthinglrp, selectthing, 0.15)