function is_transfo_all(_state = state)
{
	if is_transfo_kill(_state) return 1
	
	return array_contains(
		[
			states.coconut_intro, states.coconut_gun, states.coconut_shoot,
		],
	_state)
}
function is_transfo_kill(_state = state)
{
	return array_contains(
		[
			states.snowball, states.snowball_jump, states.snowball_wall,
			
			states.skateboard, states.skateboardAim, states.skateboardhitwall,
			states.skateboardIntro, states.skateboardmove, states.skateboardramp,
			states.skateboardwall,
		],
	_state)
}

function hurt_player(arg0 = -4)
{
    with (obj_player)
    {
        if is_transfo_all()
            exit
			
		if i_frame > 0
            exit
		
        FMODevent_oneshot("event:/Sfx/Player/hurt", x, y);
		plrsnds_play(sfx.voice_hurt, x,y)
        global.collect -= 100;
        
        if (global.collect < 0)
            global.collect = 0;
        
        global.combo.timer -= 25;
        global.combo.timer = clamp(global.combo.timer, 0, 60);
        i_frame = 100;
        var sameFace = true;
        
        if (arg0 != -4)
        {
            var facing = sign(x - arg0.x);
            sameFace = xscale == facing;
            
            if (facing != 0)
                xscale = facing;
        }
        
        hsp = 8 * xscale;
        sprite_index = !sameFace ? spr_player_hurt : spr_player_hurt2;
        flash = true;
        state = states.hurt;
        vsp = -12;
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
        
        create_particleStatic(spr_hurteffect, x, y, 1);
    }
}

function doBump(arg0, arg1 = 4)
{
    var old_x = x;
    var old_y = y;
    x += (xscale * arg1);
    var ty = try_solid(0, -1, obj_solid, arg0);
    x = old_x;
    
    if (ty != -1)
    {
        y -= ty;
        x += xscale;
        
        if (scr_solid(x, y))
        {
            x = old_x;
            y = old_y;
            return true;
        }
        
        return false;
    }
    
    return true;
}

function try_solid(arg0, arg1, arg2, arg3)
{
    var old_x = x;
    var old_y = y;
    var n = -1;
    
    for (var i = 0; i < arg3; i++)
    {
        x += arg0;
        y += arg1;
        
        if (!scr_solid(x, y))
        {
            n = i + 1;
            break;
        }
    }
    
    x = old_x;
    y = old_y;
    return n;
}

function scr_Prank()
{
    return global.treasure && global.collect >= global.Srank && !global.combo.dropped && global.secretCount >= 3 && global.escapeLap >= 2;
}

function generalReset()
{
	instance_destroy(obj_lap2visual)
	instance_destroy(obj_comboTitle)
	instance_destroy(obj_hipnatuese)
	instance_destroy(obj_hipnatueseDead)
	instance_destroy(obj_whiteflash)
	if !variable_global_exists("saveroom") global.saveroom = ds_list_create()
	else ds_list_clear(global.saveroom)
	if !variable_global_exists("escaperoom") global.escaperoom = ds_list_create()
	else ds_list_clear(global.escaperoom)
	if !variable_global_exists("followers") global.followers = ds_list_create()
	else ds_list_clear(global.followers)
	fmod_studio_system_set_parameter_by_name("musicfade", 0, false)
	global.collect = 0
	global.secretCount = 0
	global.treasure = false
	global.resetRoom = -4
	global.level_timer = 0
	global.save_timer = 0
	global.level = -4
	global.key = false
	with (obj_player)
	{
		door = "A"
		visible = true
		hallway = false
		super = false
		xscaleMulti = 1
		yscaleMulti = 1
		hitstun.is = false
		supertaunt = 0
		canSupertaunt = false
	}
	with (obj_hud)
	{
		tv.sprite_index = spr_tv_off;
		combometer.y = -128;
		combometer.state = -1;
	}
	global.modifiers =
	{
		flipped: false,
	}
	
	//escape
	global.escapeActive = false
	global.escapeTimer = 7200
	global.escapeMaxTimer = global.escapeTimer
	global.escapeLap = 0
	global.escapePartyOver = false

	global.combo = 
	{
		dropped: false,
		amt: 0,
		timer: 60,
		previouscombo: 0,
		savecombo: 0,
		highest: 0
	};
	global.toppins = [0,0,0,0,0]
	if !variable_global_exists("lap3checkpoint")
	{
		global.lap3checkpoint =
		{
			saveroom: ds_list_create(),
			escaperoom: ds_list_create(),
		}
	}
	global.lap3checkpoint.collect = 0
	global.lap3checkpoint.combo_amt = 0
	global.lap3checkpoint.combo_dropped = 0
	global.lap3checkpoint.secret = 0
	global.lap3checkpoint.roomsaved = -4
	global.lap3checkpoint.doorsaved = "fA"
	global.lap3checkpoint.toppins = global.toppins
}

function doGrab()
{
    var move = pky_right + pky_left;
    
    if (slapBuffer > 0)
    {
        if (!(character == chars.milton))
        {
            if (!pky_up)
            {
                slapBuffer = false;
                state = states.grab;
                sprite_index = sprites.grab;
                image_index = 0;
                create_particleStatic(spr_grabcloud, x, y, xscale, 1);
                
                if (movespeed < 8)
                    movespeed = 8;
            }
            else
            {
                FMODevent_oneshot("event:/Sfx/Player/uppercut", x, y);
                slapBuffer = false;
                
                if (coyote_time)
                    vsp = -17;
                else
                    vsp = -12;
                
                if character == chars.valentia
				{
					vsp = -16
					if state == states.mach3 || sprite_index == sprites.longjump || sprite_index == sprites.longjumpend
						sprite_index = spr_playerV_mach_uppercut
					else
						sprite_index = sprites.uppercut
				}
                else
                    sprite_index = sprites.uppercut;
                image_index = 0;
				state = states.uppercut;
                create_particleStatic(spr_jumpeffect, x, y, 1, 1);
                squashX = 1.5;
                squashY = 0.6;
            }
        }
        else
        {
            if pky_up
			{
				slapBuffer = false;
	            if (move != 0)
	                xscale = move;
				vsp = -12
				movespeed = hsp/2
				state = states.hammerwirl;
				sprite_index = spr_milton_hammerwirl;
				image_index = 0;
				FMODevent_oneshot("event:/Sfx/Player/uppercut", x, y);
				plrsnds_play(sfx.jump, x, y);
            }
            else
	        {
	            if (move != 0)
	                xscale = move;
            
	            vsp = 0;
	            buffers.hammer = 25;
	            slapBuffer = false;
	            state = states.hammerattack;
            
	            if (movespeed < 12)
	                movespeed = 12;
            
	            image_index = 0;
	            sprite_index = spr_milton_hammerspin_prep;
			}
        }
    }
}

function slope_momentum(arg0 = 0.1, arg1 = 0)
{
    var _obj = instance_place(x, y + 1, obj_slope);
    if (instance_exists(_obj))
    {
		if (scr_slope(x, y + 1))
		{
	        if (sign(_obj.image_xscale) != xscale)
	        {
	            if (movespeed < 20)
	                movespeed += arg0;
	        }
	        else
	            movespeed -= arg1;
		}
    }
}

function doTaunt(_force = false, _supertauntenabled = true)
{
    if (_force || pky_taunt2)
    {
        tauntVars = 
        {
            sprite_index: sprite_index,
            image_index: image_index,
            state: state,
            vsp: vsp,
            hsp: hsp,
            movespeed: movespeed,
            image_speed: image_speed
        };
        tauntTimer = 15;
        var _isSupertaunt = _supertauntenabled && canSupertaunt && pky_up;
        
        if (!_isSupertaunt)
        {
            state = states.taunt;
            image_speed = 0;
            sprite_index = sprites.taunt;
            image_index = irandom_range(0, image_number);
            instance_create(x, y, obj_taunteffect);
            instance_create(x, y, obj_parryhitbox);
			if global.modded_phototaunt
				scr_soundeffect(sfx_tauntold, random_range(0.95,1.05))
            else
				plrsnds_play(sfx.taunt, x, y);
        }
        else
        {
            state = states.taunt;
            image_speed = 0.35;
            sprite_index = choose(spr_player_supertaunt1, spr_player_supertaunt2, spr_player_supertaunt3);
            image_index = 0;
            FMODevent_oneshot("event:/Sfx/Player/supertaunt", x, y);
            supertaunt = 0;
            canSupertaunt = false;
            instance_create(x, y, obj_taunteffect);
            
            with (obj_baddie)
            {
                if (in_camera())
                {
                    supertauntKill = true;
                    instance_destroy();
                }
            }
        }
        
        if (place_meeting(x, y, obj_exitgate) && global.combo.timer > 0 && global.escapeActive && global.level != "tutorial")
        {
            if (instance_place(x, y, obj_exitgate).tauntCount < 10)
            {
                obj_exitgate.tauntCount++;
                create_collect(spr_taunteffect, x, y);
                global.collect += 25;
                create_smalltext(25);
            }
        }
    }
}

//arg0 = sprite (sprite ref)
//arg1 = era (int)

//btw tvs are like spr_tv_idle > spr_tv_idleB1

global.__baconera_cache = ds_map_create()
function get_baconera(arg0, arg1, notexists_returnnone = false)
{
	if arg1 == 0 return arg0
	var _arr1 = ["playerV","milton","pepperni","player0","player1","player2","player3", "playersoda", "preoutman"]
	var _arr2 = ["V","T","P","B0","B1","B2","B3", "", "POM"]
	var _key = string(arg0) + "|" + string(arg1)
	if ds_map_exists(global.__baconera_cache, _key)
		return global.__baconera_cache[? _key]
	
	var _asset = sprite_get_name(arg0), _spr = arg0, _result = arg0
	if string_starts_with(_asset, "spr_player")
		_spr = asset_get_index(string_replace(_asset, "spr_player", "spr_" + _arr1[arg1-1]))
	else
		_spr = asset_get_index(string_concat(_asset, _arr2[arg1-1]))
	if sprite_exists(_spr)
		_result = _spr
	else if notexists_returnnone
		return -4
	global.__baconera_cache[? _key] = _result
	return _result
}

function playerUtil_realSpr()
{
	with obj_player
	{
		var sprReal = character == chars.soda ? spr_soda : sprite_index
		if character == chars.preoutman
		{
			if string_starts_with(sprite_get_name(sprite_index), "spr_preoutman_")
				sprReal = sprite_index
			else
				sprReal = round(hsp) != 0 ? (abs(hsp) > 16 ? spr_preoutman_mach : spr_preoutman_move) : spr_preoutman_idle
		}
		return sprReal
	}
}

function playerUtil_spr(_e)
{
    var st = 
    {
        player: {},
        tv: {}
    };
	
	st.player.patcolours = get_baconera(spr_playerPatCol, _e)
	st.player.palettepreview = get_baconera(spr_dressermenu_palgrid, _e)
	st.player.palette = get_baconera(spr_playerPalHalloween, _e, 1) //HALLOWEEN SPPOKY PALETTES
	if !sprite_exists(st.player.palette)
		st.player.palette = get_baconera(spr_playerPal, _e) //if no halloween, please die and try again
	st.player.pattern = get_baconera(spr_playerPat, _e)
	st.player.clothes = get_baconera(spr_playerClothes, _e)
	
	
	st.player.crouch = get_baconera(spr_player_crouch, _e)
	st.player.crouchfall = get_baconera(spr_player_crouchfall, _e)
	st.player.crouchhop = get_baconera(spr_player_crouchhop, _e)
	st.player.crouchmove = get_baconera(spr_player_crouchmove, _e)
	st.player.crouchstart = get_baconera(spr_player_crouchstart, _e)
    st.player.idle = get_baconera(spr_player_idle, _e)
	st.player.move = get_baconera(spr_player_move, _e)
	st.player.jump = get_baconera(spr_player_jump, _e)
	st.player.fall = get_baconera(spr_player_fall, _e)
	st.player.land = get_baconera(spr_player_land, _e)
	st.player.land2 = get_baconera(spr_player_land2, _e)
	st.player.machslidestart = get_baconera(spr_player_machslidestart, _e)
    st.player.machslide = get_baconera(spr_player_machslide, _e)
    st.player.machslideend = get_baconera(spr_player_machslideend, _e)
	st.player.walljumpstart = get_baconera(spr_player_walljumpstart, _e)
	st.player.walljump = get_baconera(spr_player_walljump, _e)
	st.player.wallclimb = get_baconera(spr_player_wallclimb, _e)
    st.player.crouchslip = get_baconera(spr_player_crouchslip, _e)
	st.player.mach1 = get_baconera(spr_player_mach1, _e)
	st.player.mach2 = get_baconera(spr_player_mach2, _e)
	st.player.mach2turn = get_baconera(spr_player_mach2turn, _e)
	st.player.mach2turnfall = get_baconera(spr_player_mach2turnfall, _e)
	st.player.mach2jump = get_baconera(spr_player_mach2jump, _e)
	st.player.mach2jumpend = get_baconera(spr_player_mach2jumpend, _e)
    st.player.mach3 = get_baconera(spr_player_mach3, _e)
    st.player.mach3hit = get_baconera(spr_player_mach3hit, _e)
    st.player.mach3jump = get_baconera(spr_player_mach3jump, _e)
	st.player.mach3turn = get_baconera(spr_player_mach3turn, _e)
	st.player.mach3turnfall = get_baconera(spr_player_mach3turnfall, _e)
	st.player.superjump = get_baconera(spr_player_superjump, _e)
	st.player.superjumpcancel = get_baconera(spr_player_superjumpcancel, _e)
	st.player.superjumpcancelstart = get_baconera(spr_player_superjumpcancelstart, _e)
	st.player.superjumpprep = get_baconera(spr_player_superjumpprep, _e)
	st.player.superjumpprepstart = get_baconera(spr_player_superjumpprepstart, _e)
	st.player.superjumpprepwalk = get_baconera(spr_player_superjumpprepwalk, _e)
	st.player.spinout = get_baconera(spr_player_spinout, _e)
	st.player.buzzsaw = get_baconera(spr_player_buzzsaw, _e)
	st.player.buzzsawBump = get_baconera(spr_player_buzzsawBump, _e)
	st.player.buzzsawCancel = get_baconera(spr_player_buzzsawCancel, _e)
	st.player.buzzsawFastFall = get_baconera(spr_player_buzzsawFastFall, _e)
    st.player.crazyrun = get_baconera(spr_player_crazyrun, _e)
	st.player.longjump = get_baconera(spr_player_longjump, _e)
	st.player.longjumpend = get_baconera(spr_player_longjumpend, _e)
	st.player.rollstart = get_baconera(spr_player_rollstart, _e)
    st.player.rolling = get_baconera(spr_player_rolling, _e)
	st.player.rollgetup = get_baconera(spr_player_rollgetup, _e)
    st.player.dive = get_baconera(spr_player_dive, _e)
    st.player.divebomb = get_baconera(spr_player_divebomb, _e);
	st.player.divebombland = get_baconera(spr_player_divebombland, _e);
    st.player.taunt = get_baconera(spr_player_taunt, _e)
    st.player.gateslam = get_baconera(spr_player_gateslam, _e);
	st.player.entergate = get_baconera(spr_player_entergate, _e);
	st.player.walkfront = get_baconera(spr_player_walkfront, _e);
	st.player.airgrab = get_baconera(spr_player_airgrab, _e);
	st.player.airgrabstart = get_baconera(spr_player_airgrabstart, _e);
	st.player.grab = get_baconera(spr_player_grab, _e);
	st.player.grabbump = get_baconera(spr_player_grabbump, _e);
	st.player.grabcancel = get_baconera(spr_player_grabcancel, _e);
	st.player.grabdive = get_baconera(spr_player_grabdive, _e);
	st.player.groundpound = get_baconera(spr_player_groundpound, _e);
	st.player.groundpoundcancel = get_baconera(spr_player_groundpoundcancel, _e);
	st.player.groundpoundland = get_baconera(spr_player_groundpoundland, _e);
	st.player.groundpoundstart = get_baconera(spr_player_groundpoundstart, _e);
	st.player.uppercut = get_baconera(spr_player_uppercut, _e);
	st.player.lookdoor = get_baconera(spr_player_lookdoor, _e);
	st.player.wallsplat = get_baconera(spr_player_wallsplat, _e);
	st.player.idleanim1 = get_baconera(spr_player_idleanim1, _e, 1);
	st.player.idleanim2 = get_baconera(spr_player_idleanim2, _e, 1);
	st.player.idleanim3 = get_baconera(spr_player_idleanim3, _e, 1);
	st.player.idleanim4 = get_baconera(spr_player_idleanim4, _e, 1);
	st.player.idleanim5 = get_baconera(spr_player_idleanim5, _e, 1);
	st.player.breakdance = get_baconera(spr_player_breakdance, _e);
	
	st.player.collect1 = get_baconera(spr_collect1, _e)
	st.player.collect2 = get_baconera(spr_collect2, _e)
	st.player.collect3 = get_baconera(spr_collect3, _e)
	st.player.collect4 = get_baconera(spr_collect4, _e)
	st.player.collect5 = get_baconera(spr_collect5, _e)
	
	st.tv.bg = get_baconera(spr_tv_bg, _e);
    st.tv.off = get_baconera(spr_tv_off, _e);
	st.tv.empty = get_baconera(spr_tv_empty, _e);
	st.tv.turnon = get_baconera(spr_tv_turnon, _e);
	st.tv.trans = get_baconera(spr_tv_trans, _e);
    st.tv.idle = get_baconera(spr_tv_idle, _e);
    st.tv.mach = get_baconera(spr_tv_mach, _e);
	st.tv.combo = get_baconera(spr_tv_combo, _e);
	st.tv.happy = get_baconera(spr_tv_happy, _e);
    st.tv.crazyrun = get_baconera(spr_tv_crazyrun, _e);
	st.tv.escape = get_baconera(spr_tv_escape, _e);
	st.tv.ski = get_baconera(spr_tv_ski, _e);
	st.tv.secret = get_baconera(spr_tv_secret, _e);
	
    return st;
}