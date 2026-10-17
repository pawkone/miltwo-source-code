if dark
{
	with obj_baddie visible = false
	with obj_baddiedead visible = false
	darkTimer--
	if darkTimer <= 0
	{
		darkTimer = 4
		if darkTimer2 <= 0
		{
			darkTimer2 = 3
			circlePre = choose(8, 12, 16, 24)
			circleRan = [irandom_range(-2,2), irandom_range(-2,2), irandom_range(-2,2), irandom_range(-2,2)]
		}
		circleSizeLrp = lerp(circleSizeLrp, circleSize, 0.4);
		darkTimer2--
	}
	circleSize = 200 + sin(current_time/700)*45
}
else
{
	circleSize = 0
	circleSizeLrp = 0
}