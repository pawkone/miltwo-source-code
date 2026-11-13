if character == chars.pepperni && vsp < 0
	grav = 1
else
{
	grav = 0.5
	if character == chars.bacon_dream && vsp >= 20
		vsp += grav
	if character == chars.bacon_twist && vsp >= 20
		vsp += grav
}

var touchie = place_meeting(x,y,obj_dresser) ||
place_meeting(x,y,obj_door) ||
place_meeting(x,y,obj_levelgate) ||
(instance_place(x,y,obj_exitgate) > 0 && instance_place(x,y,obj_exitgate).openn)
if scr_getera() == "TTWOB"
{
	touchie = touchie && state != scr_player_walkfront && state != scr_player_enterdoor
	if touchie && !uparrow
		uparrow = 2
	else
		uparrow = touchie ? (place_meeting(x,y,obj_dresser)+1) : 0
}
else
{
	var uparrowraw = (touchie && grounded) * (pky_up ? 2 : (pky_down ? 0.5 : 1))
	uparrowadd = lerp(uparrowadd, (uparrowraw - uparrow) * 0.15, 0.5)
	if uparrowraw
	{
		if state == scr_player_enterdoor || instance_exists(obj_rank)
			uparrow = approach(uparrow, 3, 0.2)
		else
			uparrow += uparrowadd
	}
	else
		uparrow += uparrowadd
}
depth = -5
if global.modded_sloperotation
{
	var _angle = [], _finangle = 0
	with obj_slope
	{
		if place_meeting(x,y-1,other)
			array_push(_angle, -sign(image_xscale)*point_direction(bbox_left, bbox_top, bbox_right, bbox_bottom))
	}
	var _angle_len = array_length(_angle)
	for (var i = 0; i < _angle_len; i++) _finangle += _angle[i]/_angle_len
	angle += angle_difference(_finangle, angle) * 0.25
}
else if character == chars.bacon_crash
{
	if (place_meeting(x, y + 1, obj_slope))
	{
	    var _obj = instance_place(x, y + 1, obj_slope);
	    if (abs(_obj.image_yscale) < abs(_obj.image_xscale))
	        angle = lerp(angle, 10 * sign(_obj.image_xscale), 0.5);
	    else
	        angle = lerp(angle, 45 * sign(_obj.image_xscale), 0.5);
	}
	else
		angle = lerp(angle, 0, 0.5);
}
else
	angle = 0

instakill = skatenic_is_tornado() || state == scr_player_dreamcrusher || state == scr_player_water || sprite_index == spr_milton_dive || state == scr_player_slip || state == scr_player_mach3 || state == scr_player_skateboard || state == scr_player_skateboardwall || state == scr_player_skateboardramp || state == scr_player_skateboardmove || state == scr_player_hammerattack || (state == scr_player_machturn && sprite_index == sprites.mach3turn) || state == scr_player_superjump || state == scr_player_uppercut || state == scr_player_groundpound || state == scr_player_groundpoundstart || state == scr_player_buzzsaw;

if (hitstun.is == false)
{
    if (!instance_exists(obj_technicaldifficulty) && obj_player.state != scr_player_enterdoor && obj_player.state != scr_player_skateboardIntro && obj_player.state != scr_player_walkfront && !instance_exists(obj_fadeout) && obj_player.state != -4)
        global.combo.timer = approach(global.combo.timer, 0, 0.15);
    
    if (global.combo.previouscombo != global.combo.amt)
    {
        global.combo.previouscombo = global.combo.amt;
        
        if (global.combo.amt > 0 && (global.combo.amt % 5) == 0)
        {
            instance_destroy(obj_comboTitle);
            
            with (instance_create(811, 350, obj_comboTitle))
            {
                combo = floor(global.combo.amt / 5);
                
                if (floor(global.combo.amt / 5) > 15)
                    very = true;
                
                combo = wrap(combo, 0, 14);
                image_index = combo*2;
            }
            
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboup");
        }
    }
    
    if (global.combo.timer == 0 && global.combo.amt > 0)
    {
        global.combo.savecombo = global.combo.amt;
        
        if (global.combo.savecombo > global.combo.highest)
            global.combo.highest = global.combo.savecombo;
        
        global.combo.amt = 0;
        
        if (!instance_exists(obj_rank))
        {
            if (!global.combo.dropped)
                FMODevent_oneshot("event:/Sfx/UI/Combo/prankfail");
            
            global.combo.dropped = true;
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboend");
            instance_destroy(obj_comboTitle);
            
            with (instance_create(811, 350, obj_comboTitle))
            {
                combo = floor(global.combo.savecombo / 5);
                
                if (floor(global.combo.savecombo / 5) > 15)
                    very = true;
                
                lostcombo = true;
                combo = wrap(combo, 0, 14);
                image_index = combo*2;
                points = 10 * global.combo.savecombo;
                global.collect += points;
            }
        }
    }
	
    if character == chars.soda
		sfx.laugh = asset_get_index($"sfx_playersoda{playerUtil_realSpr()[1]}")
	if character == chars.bacon_dream
	{
	    switch (state)
	    {
	        case scr_player_normal:
	        case scr_player_jump:
	        case scr_player_mach2:
	        case scr_player_mach3:
	        case scr_player_dreambounce:
	            if (pky_up && pky_jump2 && !grounded)
	            {
	                state = scr_player_dreamcrusher;
	                vsp = -17;
					plrsnds_play(sfx.jump, x, y);
					FMODevent_oneshot("event:/Sfx/Player/slip", x, y);
	                sprite_index = spr_player1_umbrellaStart;
	                image_index = 0;
	            }
	    }
	}
	if character == chars.skatenic
	{
	    switch (state)
	    {
	        case scr_player_normal:
	        case scr_player_jump:
	        case scr_player_mach2:
	        case scr_player_mach3:
	        case scr_player_climbwall:
	            if (pky_up && pky_jump2 && !grounded)
	            {
	                state = scr_player_dreamcrusher;
	                vsp = -17;
					plrsnds_play(sfx.jump, x, y);
					FMODevent_oneshot("event:/Sfx/Player/slip", x, y);
	                sprite_index = spr_player1_umbrellaStart;
	                image_index = 0;
	            }
	    }
	}
	
    if (grounded)
	{
		freefalling = 0
        coyote_time = 10;
	}
    else if (vsp < 0)
        coyote_time = 0;
    
    coyote_time--;
    
    if (i_frame > 0 && state != scr_player_hurt)
	{
        image_alpha = round(wave(0, 1, 0.1, 0));
		i_frame--
	}
    else
        image_alpha = 1;
    
    if (state == scr_player_walkfront && sprite_index == sprites.walkfront)
        image_blend = make_colour_hsv(0, 0, (image_index / image_number) * 255);
    else
        image_blend = make_colour_hsv(0, 0, 255);
    
    if (flash == true && alarm[0] <= 0)
        alarm[0] = 5;
    
    if (y < -500 || (y > (room_height + 500) && state != -4 && !instance_exists(obj_fadeout)))
    {
        if (!instance_exists(obj_technicaldifficulty))
        {
            instance_create(x, y, obj_technicaldifficulty);
            shake_camera(25);
            plrsnds_play(sfx.slam, x, y);
        }
    }

	if is_callable(state)
		state()
	
	mask_index = spr_player_mask
    mask_index = scr_solid(x,y) || (state == scr_player_crouch || state == scr_player_tumble || state == scr_player_superjumpprep) ? spr_crouchmask : spr_player_mask
		
	scr_collide_destructibles()
    scr_collision()
    scr_collide_destructibles()
}
else
{
    if (hitstun.time > 0)
    {
        image_speed = 0;
        x = hitstun.x + irandom_range(-5, 5);
        y = hitstun.y + irandom_range(-5, 5);
        hitstun.time--;
        
        if (instance_exists(obj_fadeout))
        {
            hitstun.time = 0;
            x = hitstun.x;
            y = hitstun.y;
            hitstun.is = false;
        }
    }
    else
    {
        x = hitstun.x;
        y = hitstun.y;
        hitstun.is = false;
    }
}

for (var i = 0; i < 5; i++)
{
	if global.toppins[i]
	{
		if !instance_exists(toppingstr[i])
			instance_create(x,y,toppingstr[i])
	}
	else if instance_exists(toppingstr[i])
		instance_destroy(toppingstr[i])
}