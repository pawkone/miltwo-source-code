y += vsp
x += hsp
vsp += 0.2
timer -= 1/60
if timer < 0
	image_alpha -= 1/45
if image_alpha <= 0
	instance_destroy()