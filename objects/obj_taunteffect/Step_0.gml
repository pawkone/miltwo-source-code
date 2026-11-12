if photoOn
{
	if (target.state != scr_player_taunt)
		destroy = true;

	if (destroy)
	    image_alpha -= 0.04;
	else
	{
		x = target.x;
		y = target.y;
	}
}
else
{
	if (target.state != scr_player_taunt)
	    instance_destroy();
	x = target.x;
	y = target.y;
}


if (animation_end())
    image_speed = 0;
