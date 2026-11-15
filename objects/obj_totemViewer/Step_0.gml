time = max(time-1, 0)
alpha = approach(alpha, time > 0, 0.01)
if alpha <= 0
	instance_destroy()