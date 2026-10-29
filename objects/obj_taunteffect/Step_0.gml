if sprite_index == spr_taunteffect_old
{
	if (target.state != states.taunt)
		destroy = true;

	if (destroy)
	    image_alpha -= 0.04;
}
else
{
	if (target.state != states.taunt)
	    instance_destroy();
	x = target.x;
	y = target.y;
}

if (animation_end())
    image_speed = 0;
