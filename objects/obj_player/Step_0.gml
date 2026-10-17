var yaya = ((
	place_meeting(x,y,obj_dresser) ||
	place_meeting(x,y,obj_door) ||
	place_meeting(x,y,obj_levelgate) ||
	(instance_place(x,y,obj_exitgate) > 0 && instance_place(x,y,obj_exitgate).openn)
) && grounded) * (pky_up ? 2 : (pky_down ? 0.5 : 1))
uparrowadd = lerp(uparrowadd, (yaya - uparrow) * 0.15, 0.5)
if yaya
{
	if state == states.enterdoor || instance_exists(obj_rank)
		uparrow = approach(uparrow, 3, 0.2)
	else
		uparrow += uparrowadd
}
else
	uparrow += uparrowadd

depth = -5
if global.modded_sloperotation
{
	var _angle = 0
	with obj_slope
	{
		with other
		{
			var _angle2 = sign(other.image_xscale) * 45
			_angle2 *= lerp(1.0, 0.8, clamp(abs(other.image_yscale) / abs(other.image_xscale), 0, 1))
			_angle2 *= clamp((max(0,abs(other.sprite_width)-24)-point_distance(x,bbox_bottom,abs(other.bbox_left+other.bbox_right)/2,abs(other.bbox_top+other.bbox_bottom)/2))/max(0,abs(other.sprite_width)-24),0,1)
			if abs(_angle2) > abs(_angle)
				_angle = _angle2
		}
	}
	angle = _angle
}
else if character == chars.bacon_crash
{
	if (place_meeting(x, y + 1, obj_slope))
	{
	    var _obj = instance_place(x, y + 1, obj_slope);
	    if (abs(_obj.image_yscale) < abs(_obj.image_xscale))
	        angle = lerp(angle, 10 * _obj.image_xscale, 0.5);
	    else
	        angle = lerp(angle, 45 * sign(_obj.image_xscale), 0.5);
	}
	else
		angle = lerp(angle, 0, 0.5);
}
else
	angle = 0

instakill = sprite_index == spr_milton_dive || state == states.slip || state == states.mach3 || state == states.skateboard || state == states.skateboardwall || state == states.skateboardramp || state == states.skateboardmove || state == states.hammerattack || (state == states.machturn && sprite_index == sprites.mach3turn) || state == states.superjump || state == states.uppercut || state == states.groundpound || state == states.groundpoundstart || state == states.buzzsaw || state == states.snowball || state == states.snowball_jump || state == states.snowball_wall;

if (hitstun.is == false)
{
    if (!instance_exists(obj_technicaldifficulty) && obj_player.state != states.enterdoor && obj_player.state != states.skateboardIntro && obj_player.state != states.walkfront && !instance_exists(obj_fadeout) && obj_player.state != -4)
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
                image_index = self.getProper(combo);
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
                image_index = self.getProper(combo);
                points = 10 * global.combo.savecombo;
                global.collect += points;
            }
        }
    }
	
	scr_collide_destructibles()
    scr_collision();
    scr_collide_destructibles();
    
    if (grounded)
        coyote_time = 10;
    else if (vsp < 0)
        coyote_time = 0;
    
    coyote_time--;
    
    if (state != states.hurt)
        i_frame = approach(i_frame, 0, 1);
    
    if (i_frame > 0 && state != states.hurt)
        image_alpha = round(wave(0, 1, 0.1, 0));
    else
        image_alpha = 1;
    
    if (state == states.walkfront && sprite_index == sprites.walkfront)
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
	
    if (state == states.crouch || state == states.tumble || state == states.superjumpprep)
        mask_index = spr_crouchmask;
    else
        mask_index = spr_player_mask;

	if state >= 0
	{
		var _asset = asset_get_index("scr_player_" + state_names[state])
		if script_exists(_asset)
			script_execute(_asset)
	}
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