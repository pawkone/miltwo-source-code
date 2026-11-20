if coltim > 0
{
	coltim -= 1/30
	col = merge_colour(colee, c_black, clamp(1-coltim,0,1))
}
if obj_player.sprite_index == spr_player_gateslamfake
{
	circleSizeSpeed += 0.004 + circleSizeSpeed/45
	circleSize += circleSizeSpeed
	if (circleSize >= 4000)
		instance_destroy()
}
else if obj_player.state != scr_player_walkfront || obj_player.sprite_index == obj_player.sprites.gateslam
{
	circleSizeSpeed += 1.25
	circleSize += circleSizeSpeed
	if (circleSize >= 4000)
		instance_destroy()
}
else
{
	circleSizeSpeed = 0
	circleSize = lerp(circleSize, 35, 0.125)
}
