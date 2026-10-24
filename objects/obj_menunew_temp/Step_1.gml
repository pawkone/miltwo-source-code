select = clamp(select+pky_down2-pky_up2, 0, array_length(opt)-1)
if pky_jump2
	optfunc[select]()