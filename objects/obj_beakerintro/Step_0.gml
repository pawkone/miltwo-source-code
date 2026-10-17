if start < 1 start += 1/60
with (obj_player)
{
	state = -4
	if (other.start == 1)
    {
	    hsp = 0
	    movespeed = 0
	    vsp = 0
		with instance_place(x,y,obj_destructibles)
			instance_destroy()
	    if (sprite_index == spr_player3_slipbanan1 || sprite_index == spr_player_spinout)
	    {
	        y += other.fakeVsp;
	        other.fakeVsp += 0.5;
	        buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);    
	        if (buffers.afterimageBlur == 0)
	        {
	            buffers.afterimageBlur = 4;
	            create_blur_effect(sprite_index, image_index, x, y, xscale);
	        }
	        if (y > obj_doorA.y - 14)
	        {
	            y = obj_doorA.y - 14;
				if sprite_index == spr_player3_slipbanan1
				{
					other.fakeVsp = -5;
		            FMODevent_oneshot("event:/Sfx/Player/slipbump", x, y);
					image_speed = 0.35;
		            sprite_index = spr_player_spinout;
		            image_index = 0;
				}
				else if sprite_index == spr_player_spinout
				{
		            FMODevent_oneshot("event:/Sfx/Player/slipend", x, y);
					image_speed = 0.35;
		            sprite_index = spr_player3_slipbanan2;
		            image_index = 0;
				}
	        }
	    }
	    else if sprite_index == spr_player3_slipbanan2
	    {
			if animation_end()
			{
		        instance_destroy(other);
		        state = states.normal;
		        obj_camera.state = states.normal;
		        sprite_index = sprites.idle;
		        image_index = 0;
			}
	    }
		else
		{
			sprite_index = spr_player3_slipbanan1;
			image_speed = 0;
			image_index = image_number-1
		}
	}
	else
	{
		x = obj_doorA.x + 16;
		y = -100
	}
}