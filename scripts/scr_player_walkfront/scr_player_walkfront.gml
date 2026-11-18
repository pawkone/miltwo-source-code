function scr_player_walkfront()
{
    image_speed = 0.35;
    hsp = 0;
    vsp = 0;
    
    if (sprite_index == sprites.walkfront)
    {
		if global.level == "publicplaytest3" && place_meeting(x, y, obj_exitgate)
			sprite_index = spr_player_walkfrontfake
        if ((floor(image_index) == 5 || floor(image_index) == 13) && buffers.step <= 0)
        {
            buffers.step = 12;
            plrsnds_play(sfx.step, x, y);
            create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
        }
        
        buffers.step--;
    }
    if (sprite_index == spr_player_walkfrontfake)
    {
        if ((floor(image_index) == 5 || floor(image_index) == 13 || floor(image_index) == 15+5 || floor(image_index) == 15+13) && buffers.step <= 0)
        {
            buffers.step = 12;
            plrsnds_play(sfx.step, x, y);
            create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
        }
        
        buffers.step--;
    }
    
    if (animation_end())
    {
        if (sprite_index == spr_player_walkfrontfake)
        {
			image_index = 0;
			scr_soundeffect(sfx_step, 0.7)
			sprite_index = spr_player_gateslamfake
        }
        else if (sprite_index == sprites.walkfront)
        {
            if (place_meeting(x, y, obj_exitgate))
            {
                sprite_index = sprites.gateslam;
				image_index = 0;
	            shake_camera(25);
	            with (instance_place(x, y, obj_exitgate))
	            {
	                image_index = 0;
	                with obj_player
						plrsnds_play(sfx.slam, x, y);
	                ds_list_add(global.saveroom, id);
	            }
            }
            else
            {
                sprite_index = sprites.idle;
                image_index = 0;
                state = scr_player_normal;
            }
        }
        else
        {
            sprite_index = sprites.idle;
            image_index = 0;
            state = scr_player_normal;
        }
    }
}
