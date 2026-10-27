alpha = approach(alpha, 0, 0.01)
if start < 1 start += 1/60

var _bth = id
with (obj_player)
{
	state = -4
	with obj_camera
	{
		if _bth.start < 0.1
		{
			state = -4
			camera.x = obj_player.backtohubX
			camera.y = obj_player.backtohubY
			camera.zoom = 0.01
		}
		else
		{
			_bth.spd += 1/675
			camera.zoom = lerp(camera.zoom, 1 - (other.backtohubY-other.y)/1250, _bth.spd*0.5)
			camera.y = lerp(camera.y, other.backtohubY - 50 - (other.backtohubY-other.y)/5, _bth.spd)
		}
	}
	if (other.start == 1)
    {
	    hsp = 0
	    movespeed = 0
	    vsp = 0
	    if (sprite_index == spr_player_spinout)
	    {
	        y += other.fakeVsp;
	        other.fakeVsp += 0.5;
	        buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);    
	        if (buffers.afterimageBlur == 0)
	        {
	            buffers.afterimageBlur = 4;
	            create_blur_effect(sprite_index, image_index, x, y, xscale);
	        }
	        if (y > backtohubY)
	        {
	            y = backtohubY;
	            plrsnds_play(sfx.slam, x, y);
	            sprite_index = spr_player_beakerintro;
	            image_index = 0;
	            image_speed = 0.35;
	            shake_camera(15);
	        }
	    }
	    else if sprite_index == spr_player_beakerintro
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
			sprite_index = spr_player_spinout;
			image_speed = 0.35;
		}
	}
	else
	{
		x = backtohubX;
		y = backtohubY - (540 * 1.4);
	}
}