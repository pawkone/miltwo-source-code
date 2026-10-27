if !(obj_player.state == states.walkfront && obj_player.sprite_index == obj_player.sprites.walkfront)
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
