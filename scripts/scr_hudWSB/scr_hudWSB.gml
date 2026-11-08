function scr_hudWSB_init()
{
	hud_alpha = 0
	kettle = {};
	kettle.x = 124;
	kettle.y = 54;
	kettle.kx = kettle.x;
	kettle.ky = kettle.y;
	kettle.rankScale = 0;
	kettle.previousRank = 0;
	kettle.cloudIndex = 0;
	kettle.offset = 0;
	kettle.shake = 0;
	tv = {};
	tv.state = scr_player_normal;
	tv.sprite_index = spr_tv_off;
	tv.image_index = 0;
	tv.image_speed = 0.35;
	tv.x = 960 - 132;
	tv.y = 73;
	tv.expressionSprite = spr_tv_idle;
	tv.expressionTimer = 0;
	tv.switchindex = 0;
	tv.offset = 0;
	combometer = {};
	combometer.x = 811;
	combometer.y = 237;
	combometer.arrowx = combometer.x;
	combometer.vsp = 0;
	combometer.state = -1;
	combometer.lights = [];

	repeat (4)
	{
	    array_push(combometer.lights, 
	    {
	        on: true,
	        sprite: spr_comboLights,
	        x: 0,
	        y: 0,
	        index: 0
	    });
	}

	bar = {};
	bar.x = 960 / 2;
	bar.y = 540 - 100;
	bar.sparkIndex = 0;
	bar.spacePos = 0;
}
function scr_hudWSB_step()
{
	visible = !(global.escapePartyOver && global.escapeActive)
	if !visible
		hud_alpha = 0
	else
	{
		var _visible = !instance_exists(obj_uncleflo) && !(instance_exists(obj_titlecardFadeout) && obj_titlecardFadeout.circleSize < 256) && !roomthing
		hud_alpha = lerp(hud_alpha, _visible, 0.05)
		hud_alpha = approach(hud_alpha, _visible, 0.003)
	}

	with (kettle)
	{
		if obj_player.character == chars.bacon_crash
			x = (271-147) + 26
		else
			x = 124
	    kx = lerp(kx, x, 0.2) + irandom_range(shake, -shake);
	    ky = lerp(ky, y, 0.05) + irandom_range(shake, -shake);
	    shake = approach(shake, 0, 1);
	    rankScale = approach(rankScale, 1, 0.2);
	    cloudIndex += 0.15;
	}

	sprites = global.PlayerCharacters[obj_player.character].sprites.tv;
	var _sprites = sprites
	with (tv)
	{
	    var isSecret = string_pos("secret", string_letters(room_get_name(room))) > 0;
	    var _idleSprite = _sprites.idle;
    
	    if (isSecret)
	        _idleSprite = _sprites.secret;
    
	    if (global.escapeActive && !isSecret)
	        _idleSprite = _sprites.escape;
    
	    if (global.combo.amt >= 15 && !isSecret)
	        _idleSprite = _sprites.combo;
    
	    if (obj_player.state == scr_player_ski)
	        _idleSprite = _sprites.ski;
    
	    if (!other.visible)
	    {
	        state = scr_player_normal;
	        sprite_index = _sprites.off;
	    }
    
	    image_index += image_speed;
    
	    switch (state)
	    {
	        case scr_player_normal:
	            switch (sprite_index)
	            {
	                case _sprites.off:
	                    image_index = 0;
	                    sprite_index = _sprites.turnon;
	                    break;
                
	                case _sprites.turnon:
	                    if (image_index >= sprite_get_number(sprite_index))
	                    {
	                        image_index = 0;
	                        sprite_index = _idleSprite;
	                    }
                    
	                    break;
                
	                case _sprites.happy:
	                    expressionTimer--;
                    
	                    if (expressionTimer <= 0)
	                        tv_anim(_idleSprite);
                    
	                    break;
                
	                case _sprites.crazyrun:
	                case _sprites.mach:
	                    if (obj_player.state != scr_player_mach3 && obj_player.state != scr_player_climbwall && obj_player.state != scr_player_buzzsaw)
	                        tv_anim(_idleSprite);
                    
	                    if (obj_player.mach4mode && expressionSprite == _sprites.mach)
	                        tv_anim(_sprites.crazyrun);
                    
	                    if (!obj_player.mach4mode && expressionSprite == _sprites.crazyrun)
	                        tv_anim(_sprites.mach);
                    
	                    break;
                
	                case _sprites.secret:
	                case _sprites.escape:
	                case _sprites.idle:
	                case _sprites.combo:
	                case _sprites.ski:
	                    roomname = room_get_name(room);
	                    roomname = string_letters(roomname);
	                    isSecret = string_pos("secret", roomname) > 0;
                    
	                    if (expressionSprite != _idleSprite)
	                        tv_anim(_idleSprite);
                    
	                    if (obj_player.state == scr_player_mach3)
	                        tv_anim(_sprites.mach);
                    
	                    break;
	            }
            
	            break;
        
	        case "move":
	            switchindex = approach(switchindex, sprite_get_number(_sprites.trans) - 1, 0.35);
            
	            if (switchindex >= (sprite_get_number(_sprites.trans) - 1))
	            {
	                sprite_index = expressionSprite;
	                switchindex = 0;
	                state = scr_player_normal;
	                image_speed = 0.35;
	            }
            
	            break;
	    }
	}

	if (!ds_list_empty(collectVis))
	{
	    for (var i = 0; i < ds_list_size(collectVis); i++)
	    {
	        var q = ds_list_find_value(collectVis, i);
        
	        with (q)
	        {
	            var targetxx = other.kettle.x;
	            var targetyy = other.kettle.y;
	            var point = point_direction(x, y, targetxx, targetyy);
	            hsp = lengthdir_x(24, point);
	            vsp = lengthdir_y(24, point);
	            x += hsp;
	            y += vsp;
            
	            if (point_distance(x, y, targetxx, targetyy) <= 25)
	            {
	                with (other)
	                {
	                    kettle.shake = 5;
	                    q = undefined;
	                    ds_list_delete(collectVis, i);
	                    i--;
	                }
	            }
	        }
	    }
	}
}
function scr_hudWSB_draw()
{
	var _ha = hud_alpha
	if _ha <= 0 exit

	with obj_globaltimer
	{
		if global.level != -4
		{
			draw_set_font(global.smallfont);
			draw_set_colour(c_white);
			draw_set_halign(fa_left);
			var _xx = (960 - 128) + 16;
			var _yy = 540 - 32;
			draw_text(_xx, _yy + lerp(48, 0, _ha), timeString(global.level_timer));
		}
	}

	if (!ds_list_empty(collectVis))
	{
	    for (var i = 0; i < ds_list_size(collectVis); i++)
	    {
	        var q = ds_list_find_value(collectVis, i);
        
	        with (q)
	            draw_sprite_ext(sprite_index, 4, x, y, _ha, _ha, 0, c_white, 1);
	    }
	}

	with (kettle)
	{
		var _offset2 = lerp(-200, 0, _ha)
	    draw_sprite(get_baconera(spr_kettleScore, obj_player.character), 0, kx, ky - offset + _offset2);
	    draw_set_font(global.fnt_kettle[obj_player.character]);
	    draw_set_halign(fa_center);
	    draw_text(kx + 16, (ky + 12) - offset + _offset2, global.collect);
	    var rankindex = 0;
    
	    if (scr_Prank())
	        rankindex = 5;
	    else if (global.collect >= global.Srank)
	        rankindex = 4;
	    else if (global.collect >= global.Arank)
	        rankindex = 3;
	    else if (global.collect >= global.Brank)
	        rankindex = 2;
	    else if (global.collect >= global.Crank)
	        rankindex = 1;
    
	    if (previousRank != rankindex)
	    {
	        previousRank = rankindex;
	        rankScale = 2;
	    }
	
	    var rankX = x + (sin(current_time * 0.001) * 2);
	    var rankY = (y + (cos(current_time * 0.001) * 2)) - offset;
	    draw_sprite_ext(spr_hudRanks, rankindex, rankX + 160, rankY + _offset2, rankScale, rankScale, 0, c_white, 1);
	    var perc = 0;
    
	    switch (rankindex)
	    {
	        case 5:
	            perc = 1;
	            break;
        
	        case 4:
	            perc = 0;
	            break;
        
	        case 3:
	            perc = (global.collect - global.Arank) / (global.Srank - global.Arank);
	            break;
        
	        case 2:
	            perc = (global.collect - global.Brank) / (global.Arank - global.Brank);
	            break;
        
	        case 1:
	            perc = (global.collect - global.Crank) / (global.Brank - global.Crank);
	            break;
        
	        default:
	            perc = global.collect / global.Crank;
	            break;
	    }
    
	    var amt = sprite_get_height(spr_hudRanksFill) * perc;
	    var top = sprite_get_height(spr_hudRanksFill) - amt;
	    var xo = sprite_get_xoffset(spr_hudRanksFill);
	    var yo = sprite_get_yoffset(spr_hudRanksFill);
	    draw_sprite_part_ext(spr_hudRanksFill, rankindex, 0, top, sprite_get_width(spr_hudRanksFill), sprite_get_height(spr_hudRanksFill) - top, (rankX + 160) - xo, (rankY - yo) + top + _offset2, rankScale, rankScale, c_white, 1);
    
	    if (obj_player.x < 295 && obj_player.y < 170)
	        offset = approach(offset, 300, 50);
	    else
	        offset = approach(offset, 0, 50);
	}

	with (combometer)
	{
		var _offset2 = lerp(-400, 0, _ha)
	    var _perc = global.combo.timer / 60;
    
	    if (state == -1)
	    {
	        x = (960 - 149) + wave(-5, 5, 3, 0);
	        y = approach(y, -128, 5);
        
	        if (global.combo.amt > 0)
	        {
	            state = 0;
	            vsp = 15;
	        }
	    }
	    else if (state == 0)
	    {
	        x = (960 - 149) + wave(-5, 5, 3, 0);
	        vsp += 0.5;
	        y += vsp;
        
	        if (y > 234)
	            state = 1;
	    }
	    else if (state == 1)
	    {
	        if (_perc <= 0.5 && _perc > 0.2)
	        {
	            x = (960 - 149) + wave(-5, 5, 3, 0) + irandom_range(-2, 2);
	            vsp += 0.3;
	            y += vsp;
            
	            if (y > 224)
	            {
	                y = 224;
	                vsp = -2;
	            }
	        }
	        else if (_perc <= 0.2)
	        {
	            x = (960 - 149) + wave(-5, 5, 3, 0) + irandom_range(-5, 5);
	            vsp += 0.3;
	            y += vsp;
            
	            if (y > 224)
	            {
	                y = 224;
	                vsp = -4;
	            }
	        }
	        else
	        {
	            x = (960 - 149) + wave(-5, 5, 3, 0);
	            y = lerp(y, 224, 0.1);
	        }
        
	        if (global.combo.amt == 0)
	            state = -1;
	    }
    
	    draw_sprite(spr_combo_meter, 1, x, y + _offset2 - other.tv.offset);
    
	    for (var i = 0; i < array_length(lights); i++)
	    {
	        var q = lights[i];
	        _lights = array_length(lights) * _perc;
        
	        if (arrowx < q.x && q.sprite == spr_comboLights)
	        {
	            q.sprite = spr_comboLightsOff;
            
	            if (state != -1)
	                FMODevent_oneshot("event:/Sfx/UI/Combo/flick", x, y);
	        }
	        else if (arrowx >= q.x && q.sprite == spr_comboLightsOff)
	        {
	            q.sprite = spr_comboLights;
	        }
        
	        if (q.sprite == spr_comboLights)
	        {
	            q.x = (x - 72) + (45 * i);
	            q.y = (y - 5) + sin((current_time / 215) - (i * 60.5));
	        }
        
	        if (q.sprite == spr_comboLightsOff)
	        {
	            q.x = (x - 72) + (45 * i) + irandom_range(-1, 1);
	            q.y = (y - 5) + irandom_range(-1, 1);
	        }
        
	        q.index += 0.1;
	        pal_swap_set(spr_comboPalette, global.combo.dropped, false);
	        draw_sprite(q.sprite, q.index, q.x, q.y + _offset2 - other.tv.offset);
	        shader_reset();
	    }
    
	    var _startPos = lights[3].x + 15;
	    var _endPos = lights[0].x - 5;
	    var _lights = (array_length(lights) * _perc) / array_length(lights);
	    arrowx = lerp(arrowx, _endPos + ((_startPos - _endPos) * _lights), 0.1);
	    draw_sprite(spr_combo_arrow, 0, arrowx, y + _offset2 - 34 - other.tv.offset);
	    draw_sprite(spr_combo_meter, 0, x, y + _offset2 - other.tv.offset);
	    draw_set_font(global.comboFont);
	    draw_set_halign(fa_right);
	    draw_text(x - 4, (y + _offset2 + 32) - other.tv.offset, global.combo.amt);
	}

	var _sprites = sprites
	var backindex = tvbg_backindex
	with (tv)
	{
		var _offset2 = lerp(-300, 0, _ha)
		if obj_player.character == chars.preoutman
		{
			pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
			draw_sprite(_sprites.idle, current_time, x, y - offset + _offset2);
			shader_reset();
			pattern_draw(_sprites.idle, current_time, x, y - offset + _offset2, 1, 1, 0, 16777215, 1, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors);
    
		}
		else
		{
		    if (sprite_index != _sprites.turnon)
		        draw_sprite_ext(_sprites.bg, 0, x, y - offset + _offset2,1,1,0,backindex,1);
		    pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
		    draw_sprite(sprite_index, image_index, x, y - offset + _offset2);
		    shader_reset();
		    pattern_draw(sprite_index, image_index, x, y - offset + _offset2, 1, 1, 0, 16777215, 1, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors);
    
		    if (state == "move")
		        draw_sprite(_sprites.trans, switchindex, x, y - offset + _offset2);
	
		    if (sprite_index != _sprites.turnon)
		    {
		        if obj_player.character == chars.milton pal_swap_set(spr_tv_palette, 1, false);
		        draw_sprite(_sprites.empty, 0, x, y - offset + _offset2);
		        if obj_player.character == chars.milton shader_reset();
				if obj_player.character == chars.soda
					draw_sprite(spr_tv_soda, clamp(obj_player.palIndex-1,0,sprite_get_number(spr_playersoda_idle)-1), x, y - offset + _offset2);
		    }
    
		    if (sprite_index == _sprites.turnon)
		    {
				if obj_player.character == chars.milton pal_swap_set(spr_tv_palette, 1, false);
		        draw_sprite(_sprites.turnon, image_index, x, y - offset + _offset2);
		        if obj_player.character == chars.milton shader_reset();
		    }
		}
    
	    if (obj_player.x > (room_width - 270) && obj_player.y < 320)
	        offset = approach(offset, 400, 100);
	    else
	        offset = approach(offset, 0, 100);
	}

	with (bar)
	{
	    var _escape = global.escapeActive == true;
	    var roomname = string_letters(room_get_name(room));
	    var _secret = string_pos("secret", roomname) > 0;
	    var _sec = wrap(global.escapeTimer / 60, 0, 59);
	    var _seconds = _sec;
    
	    if (_sec < 10)
	        _seconds = string("0{0}", _sec);
    
	    var _minutes = wrap(global.escapeTimer / 3600, 0, 59);
	    var _timer = string("{1}:{0}", _seconds, _minutes);
	    draw_set_font(global.bigfont);
	    draw_set_halign(fa_center);
    
	    if (_escape)
	    {
			var putdown = _secret || global.escapeTimer <= 0
			var alt_putdown = !putdown && obj_music.captions.curtime >= 346.41 && (obj_music.captions.old < 0 || obj_music.captions.str[obj_music.captions.old] != "") && y <= 540 - 32
	        y = approach(y, putdown ? (540 + 100) : (alt_putdown ? (540 - 32) : (540 - 80)), putdown ? 15 : (alt_putdown ? 3 : 1));
	        var _realy = lerp(540+100, y, _ha)
			var _width = sprite_get_width(spr_timerBar);
	        var _height = sprite_get_height(spr_timerBar);
	        var _cigarOffset = 42;
	        var _chunkFill = 1 - (global.escapeTimer / global.escapeMaxTimer);
	        var _fill = _width * _chunkFill;
	        sparkIndex += 0.35;
		
	        draw_sprite_part(spr_timerBar, 1, 0, 0, _fill, _height, x - (_width / 2) - _cigarOffset, _realy - (_height / 2));
	        draw_sprite_part(spr_timerBar, 0, _fill, 0, _width, _height, ((x - (_width / 2)) + _fill) - _cigarOffset, _realy - (_height / 2));
	        draw_sprite(spr_timerMoon, sparkIndex, x + (_width / 2) + 10, _realy);
	        draw_sprite(spr_timerBar_flame, sparkIndex, (x - (_width / 2) - _cigarOffset) + (_width * _chunkFill), _realy);
	        draw_text(x, _realy - 24, _timer);
	    }
	    else
	        y = 640
	}
}
function scr_hudWSB_clean()
{
	delete tv
	tv = -4
	delete kettle
	kettle = -4
	for (var i = 0; i < array_length(combometer.lights); i++)
	{
		delete combometer.lights[i]
		combometer.lights[i] = -4
	}
	delete combometer
	combometer = -4
	delete bar
	bar = -4
}