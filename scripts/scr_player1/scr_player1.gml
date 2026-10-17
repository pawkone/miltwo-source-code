function scr_player_dreambounce()
{
    sprite_index = spr_player1_grabspinny;
    image_speed = 0.5;
	move = pky_right + pky_left
    hsp = approach(hsp, movespeed*move, 1);
    
	vsp -= 0.04
	
    if (move != 0)
    {
        if (abs(hsp) < 13)
            movespeed = 9;
    }
    else
        movespeed = 0;
    
    if (!jumpstop)
    {
        if (!pky_jump && vsp < 0)
        {
            vsp /= 20;
            jumpstop = true;
        }
    }
    
    if (grounded)
    {
        if (pky_run)
        {
	        state = states.mach3;
        
			if move != 0
				xscale = move
			else if sign(hsp) != 0
				xscale = sign(hsp)
		
			movespeed = abs(movespeed)
	        if (movespeed < 13)
	            movespeed = 13;
			
			hsp = xscale * movespeed
        
	        sprite_index = spr_player1_grabspinnyland;
	        image_index = 0;
        }
        else
        {
            movespeed = abs(hsp);
            create_particleStatic(spr_dreambounceeffect, x, y, 1, -2);
			
            if (move != 0)
                sprite_index = spr_player1_land2;
            else
                sprite_index = spr_player1_land;
            
            image_index = 0;
            state = states.normal;
        }
    }
	
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 3;
        create_dreamAttack_effect(sprite_index, image_index, x, y, xscale);
    }
	
    if (pky_grab2)
    {
        sprite_index = spr_player1_spincancel;
        image_index = 0;
        state = states.dreamspin;
        if (movespeed < 12)
            movespeed = 12;
        if (move != 0)
            xscale = move;
    }
    
    if (pky_down2 && vsp < 14)
        vsp = 14;

}

function scr_player_dreamspin()
{
    image_speed = 0.35;
	move = pky_right + pky_left;
	hsp = movespeed * xscale;
    vsp += 0.46;
	
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 4;
        create_dreamAttack_effect(sprite_index, image_index, x, y, xscale);
    }
    
    if (place_meeting(x + xscale, y, obj_solid))
    {
        jumpstop = true;
        vsp = -14;
		xscale *= -1;
        movespeed = 0;
        sprite_index = spr_player1_grabspinny;
        image_index = 0;
        state = states.dreambounce;
		create_particleStatic(spr_dreambounceeffect, x, y, 1, -2);
    }
    
    if (grounded)
    {
        state = states.mach3;
        
		if move != 0
			xscale = move
		else if sign(hsp) != 0
			xscale = sign(hsp)
		
		movespeed = abs(movespeed)
        if (movespeed < 13)
            movespeed = 13;
			
		hsp = xscale * movespeed
        
        sprite_index = spr_player1_grabspinnyland;
        image_index = 0;
    }
    
    if (animation_end() && sprite_index == spr_player1_spincancel)
        sprite_index = spr_player1_spincancelloop;
}

