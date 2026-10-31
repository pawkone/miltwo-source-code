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

function scr_player_dreamcrusher()
{
    image_speed = 0.35;
	var move = pky_right + pky_left
    hsp = approach(hsp, movespeed * move, 1.5);
    
    if (move != 0)
    {
        if (abs(hsp) < 13)
            movespeed = 9;
    }
    else
        movespeed = 0
    if (vsp > 5 && vsp < 20)
        vsp += 1.5;
	if vsp > 12
        sprite_index = spr_player1_umbrellafall
    else
    {
        sprite_index = spr_player1_umbrellaStart
        if animation_end()
            image_index = 8
    }
	
	if character == chars.skatenic
	{
		if slapBuffer > 0
		{
		    slapBuffer = false
		    state = states.mach2
			movespeed = 13
			scale = 1.7
			image_speed = 0.5
		    image_index = 0
		    sprite_index = spr_skatenic_wallclimbcancel
			vsp = -7
			jumpstop = true
			flash = true
			if sign(move) != 0
				xscale = sign(move)
			else if sign(hsp) != 0
				xscale = sign(hsp)
		}
	}
 
    buffers.afterimageBlur = approach(buffers.afterimageBlur, 0, 1);
    
    if (buffers.afterimageBlur <= 0)
    {
        create_blur_effect(sprite_index, image_index, x, y, xscale);
        buffers.afterimageBlur = 4;
    }
    
    if (grounded && vsp > 0 && !place_meeting(x, y + 1, obj_destructibles) && !place_meeting(x, y + 1, obj_metalblock))
    {
		if (scr_slope(x, y + 1) && sprite_index != spr_player_piledriver)
        {
            var slope = instance_place(x, y + 1, obj_slope);
            xscale = -sign(slope.image_xscale);
            movespeed = (freefallsmash >= 10) ? 12 : 8;
            state = states.tumble;
            sprite_index = sprites.rolling;
            create_particleStatic(spr_superdashcloud, x, y, xscale, 1);
        }
		else
		{
	        sprite_index = sprites.groundpoundland
	        image_index = 0
	        vsp = 0
	        hsp = 0
	        state = states.freefallland
	        movespeed = abs(movespeed)
			shake_camera(10,15)
	        plrsnds_play(sfx.slam, x, y)
		}
    }
}
