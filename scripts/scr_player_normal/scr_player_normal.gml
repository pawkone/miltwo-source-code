function scr_player_normal()
{
    hsp = movespeed * xscale;
    var move = pky_right + pky_left;
	
    if (sprite_index == sprites.move)
    {
        if ((floor(image_index) == 3 || floor(image_index) == 8) && buffers.step <= 0)
        {
            buffers.step = 12;
            plrsnds_play(sfx.step, x, y);
            create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
        }
        
        buffers.step--;
    }
    
    if (move != 0)
    {
        if (sprite_index != sprites.move && sprite_index != sprites.land2 && sprite_index != sprites.machslideend && sprite_index != sprites.breakdance)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
        
        if (sprite_index != sprites.breakdance)
            image_speed = movespeed / 17;
        
        xscale = move;
        
        if (!place_meeting(x + xscale, y, obj_solid))
        {
            movespeed = approach(movespeed, 6, 0.5);
        }
        else
        {
            movespeed = approach(movespeed, 0, 0.65);
            
            if (sprite_index != sprites.breakdance)
                image_speed = 0.1;
        }
        
        if (animation_end() && sprite_index == sprites.land2)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
        
        if (animation_end() && sprite_index == sprites.machslideend)
        {
            image_index = 0;
            sprite_index = sprites.move;
        }
    }
    else
    {
		if global.connected && instance_exists(obj_shell) && obj_shell.isOpen
		{
			hsp = 0
			movespeed = 0
			image_speed = 0.25
			sprite_index = spr_player_chat
		}
		else
		{
	        if (sprite_index != sprites.idle && sprite_index != sprites.idleanim1 && sprite_index != sprites.idleanim2 && sprite_index != sprites.idleanim3 && sprite_index != sprites.idleanim4 && sprite_index != sprites.idleanim5 && sprite_index != sprites.land && sprite_index != sprites.machslideend && sprite_index != sprites.breakdance && sprite_index != spr_player_statue && sprite_index != spr_player_statuestart)
	        {
	            image_speed = movespeed / 15;
            
	            if (movespeed == 0)
	            {
	                image_index = 0;
	                sprite_index = sprites.idle;
	                image_speed = 0.35;
	                buffers.idle = 150;
	            }
	        }
			else
				image_speed = 0.35;
        
	        movespeed = approach(movespeed, 0, 0.65);
        
	        if (sprite_index == sprites.idle)
	            buffers.idle--;
        
	        if (buffers.idle <= 0 && sprite_index != sprites.breakdance && sprite_index != spr_player_statue && sprite_index != spr_player_statuestart)
	        {
	            buffers.idle = 150;
				var _ava = []
				for (var i = 0; i < 5; i++)
				{
					var _sp = struct_get(sprites, string("idleanim{0}", i))
					if _sp > 0
						array_push(_ava, _sp)
				}
				if array_length(_ava) > 0
				{
		            image_index = 0;
		            sprite_index = _ava[irandom(array_length(_ava)-1)]
		            image_speed = 0.35;
		            if (irandom(100) <= 25)
		                plrsnds_play(sfx.ok,x,y);
				}
	        }
        
	        if (animation_end() && (sprite_index == sprites.idleanim1 || sprite_index == sprites.idleanim2 || sprite_index == sprites.idleanim3 || sprite_index == sprites.idleanim4 || sprite_index == sprites.idleanim5))
	        {
	            image_index = 0;
	            sprite_index = sprites.idle;
	        }
        
	        if (animation_end() && sprite_index == sprites.land)
	        {
	            image_index = 0;
	            sprite_index = sprites.idle;
	        }
        
	        if (animation_end() && sprite_index == spr_player_statuestart)
	        {
	            image_index = 0;
	            sprite_index = spr_player_statue;
	        }
        
	        if (animation_end() && sprite_index == sprites.machslideend)
	        {
	            image_index = 0;
	            sprite_index = sprites.idle;
	        }
		}
    }
    
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
            sprite_index = sprites.idle;
    }
    
    if (buffers.breakdanceheld > 10)
    {
        breakdancespeed = approach(breakdancespeed, 0.6, 0.005);
        
        if (sprite_index != sprites.breakdance)
            sprite_index = sprites.breakdance;
        
        image_speed = breakdancespeed;
    }
    
    if (breakdancespeed > 0.5)
    {
        if (breakdanceID == -4)
        {
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
            
            if (instance_exists(obj_onlineHandler))
            {
                with (obj_onlineHandler)
                    instance_create_online(other.x + irandom_range(-70, 70), other.y + irandom_range(-70, 70), other.depth, obj_notes);
            }
            
            instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes);
        }
    }
    
    buffers.notes = approach(buffers.notes, 0, 1);
    
    if (!coyote_time)
    {
        freefalling = 0;
        image_index = 0;
        sprite_index = sprites.fall;
        state = states.jump;
    }
    
    if (jumpBuffer && coyote_time)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = sprites.jump;
        state = states.jump;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
    
    if (pky_down && grounded)
    {
        image_speed = 0.35;
        image_index = 0;
        sprite_index = spr_player_crouchstart;
        state = states.crouch;
    }
    
    if (pky_run && !place_meeting(x + xscale, y, obj_solid))
    {
		if character != chars.valentia
			create_particleStatic(spr_grabcloud, x, y, xscale, 1);
        if (movespeed < 6)
            movespeed = 6;
        sprite_index = sprites.mach1;
        image_index = 0;
        state = states.mach2;
		if character == chars.pepperni
			flash = true;
    }
    
    doTaunt();
    doGrab();
}
