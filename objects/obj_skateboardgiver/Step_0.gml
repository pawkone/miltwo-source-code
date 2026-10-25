if animation_end()
{
	if (sprite_index == spr_stickcollect_billlargestack_open)
	{
	    image_index = 0;
	    sprite_index = spr_stickcollect_billlargestack_end;
	}
	else if (sprite_index == spr_stickcollect_billlargestack_end)
	{
	    image_speed = 0;
	    image_index = image_number - 1;
	}
}