function scr_hudNGAB2_init()
{
	global.font_hudNGAB2_score = font_add_sprite_ext(font_hudNGAB2_score, "0123456789", 1, 0)
	global.font_hudNGAB2_combo = font_add_sprite_ext(font_hudNGAB2_combo, "1234567890", 1, 0)
	state = 33
	switchstate = 0
	switchtimer = 0
	drawingalpha = 1
	todrawingindex = 0
	drawingindex = 0
	switchhandY = -192
	comboY = -64
	combovsp = 0
	combopart = 0
	milkpos = 0
	collectshake = 0
	combopalindex = !global.combo.dropped
	surf = surface_create(278, 139)
	clip = surface_create(278, 139)
}
function scr_hudNGAB2_step()
{
	var comboshake = (global.combo.timer < 30) ? ((8 * (30 - global.combo.timer)) / 30) : 0, p = obj_player.id, idle = 0
	if global.combo.amt >= 3 idle = 3
	if global.escapeActive idle = 4
	switch (state)
	{
	    case 33:
	        drawingalpha = approach(drawingalpha, 1, 0.25)
	        switchhandY = approach(switchhandY, -192, 20)
	        switch drawingindex
	        {
	            case 4:
	                if p.state == scr_player_mach3
	                {
	                    todrawingindex = 1
	                    switchstate = 0
	                    state = 32
	                }
	                else if !global.escapeActive
	                {
	                    todrawingindex = idle
	                    switchstate = 0
	                    state = 32
	                }
	                break
	            case 3:
	                if global.combo.amt < 3
	                {
	                    todrawingindex = idle
	                    switchstate = 0
	                    state = 32
	                }
	            case 0:
	                if global.escapeActive
	                {
	                    todrawingindex = idle
	                    switchstate = 0
	                    state = 32
	                }
	                else if p.state == scr_player_mach3
	                {
	                    todrawingindex = 1
	                    switchstate = 0
	                    state = 32
	                }
	                break;
            
	            case 1:
	                if p.state != scr_player_mach3
	                {
	                    todrawingindex = idle
	                    switchstate = 0
	                    state = 32
	                }
	                else if p.sprite_index == p.sprites.crazyrun
	                {
	                    todrawingindex = 2
	                    switchstate = 0
	                    state = 32
	                }
	                break
	            case 2:
	                if p.state != scr_player_mach3
	                {
	                    todrawingindex = idle
	                    switchstate = 0
	                    state = 32
	                }
	                else if p.sprite_index != p.sprites.crazyrun
	                {
	                    todrawingindex = 1
	                    switchstate = 0
	                    state = 32
	                }
	                break
	        }
	        break
	    case 32:
	        switch switchstate
	        {
	            case 0:
	                switchhandY = approach(switchhandY, -76, 15)
	                if switchhandY >= -76
	                {
	                    switchtimer = 15
	                    switchstate++
	                }
	                break
	            case 1:
	                drawingalpha = approach(drawingalpha, 0, 0.25)
	                switchtimer--
	                if switchtimer <= 0
	                {
	                    switchstate++
	                    drawingindex = todrawingindex
	                    state = 33
	                }
	                break
	        }
	}
	switch combopart
	{
	    case 0:
	        comboY = approach(comboY, -84, 5) + irandom_range(comboshake, -comboshake)
	        combovsp = 0
	        if global.combo > 0
	        {
	            combopart++
	            combovsp = 5
	        }
	        break
	    case 1:
	        comboY = approach(comboY, 234, combovsp)
	        combovsp += 0.5
	        if comboY >= 230
	            combopart++
	        break
	    case 2:
	        comboY = lerp(comboY, 224 + wave(-2, 2, 4, 0), 0.1) + irandom_range(comboshake, -comboshake)
	        if global.combo.amt <= 0
	            combopart = 0
	        break
	}

	combopalindex = approach(combopalindex, !global.combo.dropped, 0.011904761904761904)
	comboX = 832 + wave(-2, 2, 2, 0) + irandom_range(comboshake, -comboshake)
	milkpos = lerp(milkpos, (60 * (60 - global.combo.timer)) / 60, 0.4)
	collectshake = approach(collectshake, 0, 1)
	
	if (!ds_list_empty(collectVis))
	{
	    for (var i = 0; i < ds_list_size(collectVis); i++)
	    {
	        var q = ds_list_find_value(collectVis, i);
        
	        with (q)
	        {
	            var targetxx = 144;
	            var targetyy = 79;
	            var point = point_direction(x, y, targetxx, targetyy);
	            hsp = lengthdir_x(25, point);
	            vsp = lengthdir_y(25, point);
	            x += hsp;
	            y += vsp;
            
	            if (point_distance(x, y, targetxx, targetyy) <= 25)
	            {
	                with (other)
	                {
	                    collectshake = 10;
	                    q = undefined;
	                    ds_list_delete(collectVis, i);
	                    i--;
	                }
	            }
	        }
	    }
	}
}
function scr_hudNGAB2_draw()
{
	if global.level == -4 exit
	if instance_exists(obj_titlecard) exit
	
	if (!ds_list_empty(collectVis))
	{
	    for (var i = 0; i < ds_list_size(collectVis); i++)
	    {
	        with (ds_list_find_value(collectVis, i))
	            draw_sprite_ext(sprite_index, 4, x, y, 1, 1, 0, c_white, 1);
	    }
	}
	
	draw_set_colour(c_white)
	draw_set_font(global.font_hudNGAB2_score)
	draw_set_halign(1)
	draw_set_valign(0)
	
    var hudxx = 144 + irandom_range(collectshake, -collectshake), hudyy = 79 + irandom_range(collectshake, -collectshake)
    draw_sprite(spr_hudNGAB2_score, 0, hudxx, hudyy + 32)
    draw_text(hudxx - 4 + 32, hudyy - 7, global.collect)
	
	draw_set_halign(0)
	
    if surface_exists(surf) && surface_exists(clip)
    {
        surface_set_target(surf)
        pal_swap_set(spr_hudNGAB2_comboPal, combopalindex, false)
        draw_sprite(spr_hudNGAB2_comboMask, 1, 139, 69)
        shader_reset()
        draw_sprite(spr_hudNGAB2_comboMilk, (current_time/1000)*21, 22, 22 + milkpos)
        surface_reset_target()
        surface_set_target(clip)
        draw_clear(c_white)
        gpu_set_blendmode(bm_subtract)
        draw_sprite(spr_hudNGAB2_comboMilk, 0, 139, 69)
        surface_reset_target()
        surface_set_target(surf)
        draw_surface(clip, 0, 0)
        gpu_set_blendmode(bm_normal)
        surface_reset_target()
        draw_surface(surf, comboX - 139, comboY - 69)
    }
    else
    {
        surf = surface_create(278, 139)
        clip = surface_create(278, 139)
    }
    
    var xx = (comboX - 31) + 16, yy = comboY + 33, _str = string(global.combo)
	var _len = string_length(_str)
	draw_set_font(global.font_hudNGAB2_combo)
    for (var i = 0; i < _len; i++)
    {
        draw_text(xx, yy, string_char_at(_str, i + 1))
        xx += 18
        yy -= 2
    }
    
    pal_swap_set(spr_hudNGAB2_comboPal, combopalindex, false)
    draw_sprite(spr_hudNGAB2_combo, (current_time/1000)*21, comboX, comboY)
    shader_reset()
	
    xx = 823 + wave(-2, 2, 4, 0)
    yy = 75 + wave(-2, 2, 8, 0)
	
    draw_sprite(spr_hudNGAB2_tvBase, 0, xx, yy)
    draw_sprite_ext(spr_hudNGAB2_tvDrawing, drawingindex, xx, yy, 1, 1, 0, c_white, drawingalpha)
    draw_sprite(spr_hudNGAB2_tvHand, 0, xx - 55 + irandom_range(-5, 5), switchhandY + irandom_range(-3, 3))
    if global.escapeActive
	{
		var _sec = wrap(global.escapeTimer / 60, 0, 59)
	    var _timer = $"{_sec < 10 ? "0" : ""}{_sec}:{wrap(global.escapeTimer / 3600, 0, 59)}"
        draw_set_halign(1)
		draw_set_font(global.creditsfont)
		draw_text(480, 150, _timer)
		draw_set_halign(0)
	}
    
    //draw_sprite_ext(spr_fiveish, ish_index, xx - 200, yy, ish_size, ish_size, ish_rot, c_white, 1);
}
function scr_hudNGAB2_clean()
{
	surface_free(surf)
	surf = -4
	surface_free(clip)
	clip = -4
	font_delete(global.font_hudNGAB2_score)
	font_delete(global.font_hudNGAB2_combo)
	global.font_hudNGAB2_score = -4
	global.font_hudNGAB2_combo = -4
}