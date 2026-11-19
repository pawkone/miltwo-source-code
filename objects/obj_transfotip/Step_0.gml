if buf > 0
{
	image_alpha = approach(image_alpha, 1, 0.05)
	buf--
}
else
{
	image_alpha = approach(image_alpha, 0, 0.01)
	if image_alpha <= 0
	    instance_destroy()
}