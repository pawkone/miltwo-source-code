function scr_player_noclip()
{
	var spd = pky_run ? 32 : 16
	y += (pky_down - pky_up) * spd
	x += (pky_right + pky_left) * spd
	hsp = 0
	vsp = 0
	if pky_jump2
		state = states.normal
}