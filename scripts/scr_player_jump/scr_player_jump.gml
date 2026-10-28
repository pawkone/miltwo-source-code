function scr_player_jump()
{
    if (pky_taunt)
    {
        buffers.breakdanceheld++;
    }
    else
    {
        buffers.breakdanceheld = 0;
        buffers.notes = 10;
        breakdancespeed = 0.25;
        
        if (sprite_index == sprites.breakdance)
            sprite_index = sprites.fall;
    }
    
    if (buffers.breakdanceheld > 10)
    {
        breakdancespeed = approach(breakdancespeed, 0.5, 0.005);
        
        if (sprite_index != sprites.breakdance)
            sprite_index = sprites.breakdance;
        
        image_speed = breakdancespeed;
    }
    
    if (breakdancespeed >= 0.5)
    {
        if (breakdanceID == -4)
        {
			image_index = 0
            with (instance_create(x, y, obj_beatbox))
            {
                other.breakdanceID = id;
                target = other.id;
            }
        }
        
        if (!instance_exists(breakdanceID))
            breakdanceID = -4;
        
        if (buffers.notes <= 0)
        {
            buffers.notes = 10;
            instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes);
        }
    }
    
    buffers.notes = approach(buffers.notes, 0, 1);
    
	
    hsp = movespeed * xscale;
    var move = pky_right + pky_left;
	if sprite_index != sprites.breakdance
		image_speed = 0.35;
    freefalling++;
    
    if (jumpstop == false && !pky_jump && vsp < grav)
    {
        jumpstop = true;
        vsp /= 20;
    }
    
    if (move != 0)
    {
        xscale = move;
        
        if (!place_meeting(x + xscale, y, obj_solid))
            movespeed = approach(movespeed, 6, 0.5);
        else
            movespeed = approach(movespeed, 0, 0.65);
    }
    else
    {
        movespeed = approach(movespeed, 0, 0.65);
    }
    
    if (animation_end() && sprite_index == sprites.jump)
    {
        image_index = 0;
        sprite_index = sprites.fall;
    }
    
    if (animation_end() && sprite_index == spr_player_bumpenemystart)
    {
        image_index = 0;
        sprite_index = spr_player_bumpenemy;
    }
    
    if (animation_end() && sprite_index == sprites.grabcancel)
    {
        image_index = 0;
        sprite_index = sprites.fall;
    }
    if sprite_index != sprites.breakdance
	{
	    if (freefalling >= 120)
	        sprite_index = spr_player_fallfast2;
	    else if (freefalling >= 60)
	        sprite_index = spr_player_fallfast1
	}
    
    if (((pky_down2 && global.dirGround) || (pky_groundpound2 && !global.dirGround)) && !grounded)
    {
        vsp = -6;
        sprite_index = sprites.groundpoundstart;
        image_index = 0;
        state = states.groundpoundstart;
        squashX = 1.3;
        squashY = 0.8;
        freefalling = 0;
    }
    
    if (grounded)
    {
        create_particleStatic(spr_landeffect, x, y, 1, 1);
		if sprite_index != sprites.breakdance
		{
	        image_index = 0;
	        sprite_index = (move != 0) ? sprites.land2 : sprites.land;
		}
        state = states.normal;
        plrsnds_play(sfx.step, x, y);
    }
	
    doTaunt();
    
    if (sprite_index != sprites.grabbump)
        doGrab();
}
