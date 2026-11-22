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
	tv.switchexpr = -4
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
	
	sprite_idold = -1
}
function scr_hudWSB_step()
{
	var _visible = !instance_exists(obj_uncleflo) && !(instance_exists(obj_titlecardFadeout) && obj_titlecardFadeout.circleSize < 256) && !roomthing
	hud_alpha = lerp(hud_alpha, _visible, 0.05)
	hud_alpha = approach(hud_alpha, _visible, 0.003)

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

	if sprite_idold != obj_player.character
	{
		sprite_idold = obj_player.character
		sprites = global.PlayerCharacters[obj_player.character].sprites.tv
	}
	
	var _sprites = sprites
	with (tv)
	{
	    if (other.hud_alpha < 0.8)
	    {
	        state = "off";
	        sprite_index = _sprites.off;
	    }
		else
		{
		    image_index += image_speed;
		    switch (state)
		    {
		        case scr_player_normal:
					if expressionSprite < 0
						expressionTimer = 0
					if expressionTimer <= 0
					{
						var _cur = -4
						if obj_player.state == scr_player_mach3
						|| obj_player.state == scr_player_climbwall
						|| obj_player.state == scr_player_buzzsaw
						{
				            if (obj_player.movespeed >= 16)
								_cur = _sprites.crazyrun
							else
								_cur = _sprites.mach
						}
						else
						{
							var _se = 0
							try{_se = obj_handlerCamera.isSecretStart}catch(e){}
							if (_se)
						        _cur = _sprites.secret
						    else if (global.combo.amt >= 15)
						        _cur = _sprites.combo
						    else if (global.escapeActive)
						        _cur = _sprites.escape
							else
								_cur = _sprites.idle
						}
					
						if sprite_index != _cur
						{
				            switchindex = 0
				            switchexpr = _cur
							state = "move2"
						}
					}
					else
						expressionTimer--
		            break;
				case "off":
					if sprite_index != _sprites.turnon
					{
						sprite_index = _sprites.turnon
						image_index = 0
					}
		            else if image_index >= sprite_get_number(sprite_index) - 0.35
		            {
						sprite_index = _sprites.idle
		                state = scr_player_normal
		            }
		            break;
		        case "move2":
		        case "move":
					var _n = sprite_get_number(_sprites.trans) - 0.35
		            switchindex = approach(switchindex, _n, 0.35)
		            if switchindex >= _n
		            {
		                sprite_index = state == "move2" ? switchexpr : expressionSprite;
						expressionSprite = -4
		                state = scr_player_normal;
						switchindex = 0
		            }
		            break;
		    }
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

	if global.level != -4
	{
		draw_set_font(global.smallfont);
		draw_set_colour(c_white);
		draw_set_halign(fa_left);
		var _xx = (960 - 128) + 16;
		var _yy = 540 - 32;
		draw_text(_xx, _yy + lerp(48, 0, _ha), timeString(global.level_timer));
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
	    var rankindex = scr_rankGetIndex()
	    if (previousRank != rankindex)
	    {
	        previousRank = rankindex;
	        rankScale = 2;
	    }
	
	    var rankX = x + (sin(current_time * 0.001) * 2), rankY = (y + (cos(current_time * 0.001) * 2)) - offset
		var top = sprite_get_height(spr_hudRanksFill) - (sprite_get_height(spr_hudRanksFill) * scr_rankGetPrec())
	    draw_sprite_ext(spr_hudRanks, rankindex, rankX + 160, rankY + _offset2, rankScale, rankScale, 0, c_white, 1)
	    draw_sprite_part_ext(spr_hudRanksFill, rankindex, 0, top, sprite_get_width(spr_hudRanksFill), sprite_get_height(spr_hudRanksFill) - top, (rankX + 160) - sprite_get_xoffset(spr_hudRanksFill), (rankY - sprite_get_yoffset(spr_hudRanksFill)) + top + _offset2, rankScale, rankScale, c_white, 1)
		
		offset = approach(offset, (obj_player.x < 295 && obj_player.y < 170) ? 300 : 0, 50);
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
	        if (arrowx < q.x && q.sprite == spr_comboLights)
	        {
	            q.sprite = spr_comboLightsOff;
            
	            if (state != -1)
	                FMODevent_oneshot("event:/Sfx/UI/Combo/flick", x, y);
	        }
	        else if (arrowx >= q.x && q.sprite == spr_comboLightsOff)
	            q.sprite = spr_comboLights;
	        if (q.sprite == spr_comboLights)
	        {
	            q.x = (x - 72) + (45 * i);
	            q.y = (y - 5) + sin((current_time / 215) - (i * 60.5));
	        }
			else if (q.sprite == spr_comboLightsOff)
	        {
	            q.x = (x - 72) + (45 * i) + irandom_range(-1, 1);
	            q.y = (y - 5) + irandom_range(-1, 1);
	        }
        
	        q.index += 0.1;
	        pal_swap_set(spr_comboPalette, global.combo.dropped, false);
	        draw_sprite(q.sprite, q.index, q.x, q.y + _offset2 - other.tv.offset);
	        shader_reset();
	    }
		
	    var _endPos = lights[0].x - 5;
	    arrowx = lerp(arrowx, _endPos + ((lights[3].x + 15 - _endPos) * ((array_length(lights) * _perc) / array_length(lights))), 0.1);
	    draw_sprite(spr_combo_arrow, 0, arrowx, y + _offset2 - 34 - other.tv.offset);
	    draw_sprite(spr_combo_meter, 0, x, y + _offset2 - other.tv.offset);
	    draw_set_font(global.comboFont);
	    draw_set_halign(fa_right);
	    draw_text(x - 4, (y + _offset2 + 32) - other.tv.offset, global.combo.amt);
	}

	var _sprites = sprites, backindex = tvbg_backindex
	with (tv)
	{
		var _offset2 = lerp(-300, 0, _ha)
		if obj_player.character == chars.preoutman
		{
			pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false)
			draw_sprite(_sprites.idle, current_time, x, y - offset + _offset2)
			shader_reset()
    
		}
		else
		{
			var _p = 0 //its if below cuz more later maybe uhh idk
			if obj_player.character == chars.milton
				_p = 1
			var _heh = (sprite_index != _sprites.turnon && sprite_index != _sprites.off)
		    if _heh
		        draw_sprite_ext(_sprites.bg, 0, x, y - offset + _offset2,1,1,0,backindex,1);
			if !_heh
			{
				if _p > 0
					pal_swap_set(spr_tv_palette, _p, false)
			}
			else
				pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
		    draw_sprite(sprite_index, image_index, x, y - offset + _offset2);
		    if _p > 0 || _heh
				shader_reset()
		    pattern_draw(sprite_index, image_index, x, y - offset + _offset2, 1, 1, 0, 16777215, 1, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors);
    
		    if (state == "move" || state == "move2")
		        draw_sprite(_sprites.trans, switchindex, x, y - offset + _offset2);
	
			if _heh
			{
			    if _p > 0
					pal_swap_set(spr_tv_palette, _p, false)
			    draw_sprite(_sprites.empty, 0, x, y - offset + _offset2)
			    if _p > 0
					shader_reset()
				if obj_player.character == chars.soda
					draw_sprite(spr_tv_soda, clamp(obj_player.palIndex-1,0,sprite_get_number(spr_playersoda_idle)-1), x, y - offset + _offset2);
			}
		}
	    offset = approach(offset, (obj_player.x > (room_width - 270) && obj_player.y < 320) ? 400 : 0, 100);
	}

	with (bar)
	{
	    if (global.escapeActive)
	    {
		    draw_set_font(global.bigfont);
		    draw_set_halign(fa_center);
			
			var _se = 0
			try{_se = obj_handlerCamera.isSecretStart}catch(e){}
			var putdown = _se || global.escapeTimer <= 0
			var alt_putdown = !putdown && (obj_handlerMusic.captions.old < 0 || obj_handlerMusic.captions.str[obj_handlerMusic.captions.old] != "") && y <= 540 - 32
	        y = approach(y, putdown ? (540 + 100) : (alt_putdown ? (540 - 32) : (540 - 80)), putdown ? 15 : (alt_putdown ? 3 : 1));
	        var _realy = lerp(540+100, y, _ha)
			var _width = sprite_get_width(spr_timerBar), _height = sprite_get_height(spr_timerBar);
	        var _chunkFill = 1 - (global.escapeTimer / global.escapeMaxTimer);
	        var _fill = _width * _chunkFill;
		
	        draw_sprite_part(spr_timerBar, 1, 0, 0, _fill, _height, x - (_width / 2) - 42, _realy - (_height / 2));
	        draw_sprite_part(spr_timerBar, 0, _fill, 0, _width, _height, ((x - (_width / 2)) + _fill) - 42, _realy - (_height / 2));
	        draw_sprite(spr_timerMoon, current_time/(1000/60)*0.35, x + (_width / 2) + 10, _realy);
	        draw_sprite(spr_timerBar_flame, current_time/(1000/60)*0.35, (x - (_width / 2) - 42) + (_width * _chunkFill), _realy);
	        
			var _s = wrap(global.escapeTimer / 60, 0, 59); var _t = _s < 10 ? "0" : "" //no , var thing cuz use brain
			draw_text(x, _realy - 24, $"{wrap(global.escapeTimer / 3600, 0, 59)}:{_t}{_s}");
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