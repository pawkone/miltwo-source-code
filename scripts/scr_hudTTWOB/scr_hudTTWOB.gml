global.font_hudTTWOB_score = font_add_sprite_ext(font_hudTTWOB_score, "0123456789", 1, 0)
global.font_hudTTWOB_combo = font_add_sprite_ext(font_hudTTWOB_combo, "0123456789", 1, 0)
function scr_hudTTWOB_init()
{
	combo_x = 832
	combo_y = -64
	combo_y2 = 0
	combo_vsp = 0
	combo_state = 0
	tv_spr = spr_tv_idleB3
	tv_img = 0
	tv_state = "expression"
	tv_idle = 0
	expressionsprite = -4
	expressiontimer = 0
	switchtimer = 0
}
function scr_hudTTWOB_step()
{
	var p = obj_player
	var idle = spr_tv_idleB3
	if global.escapeActive idle = spr_tv_escapeB3
	if global.combo.amt >= 3 idle = spr_tv_comboB3
	switch tv_state
	{
		case "expression":
			switch tv_spr
			{
				case spr_tv_escapeB3:
				case spr_tv_comboB3:
					if tv_spr != idle
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
					if p.state == scr_player_mach3
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = spr_tv_machB3
						expressiontimer = 0
					}
					break
				case spr_tv_idleB3:
					if tv_spr != idle
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
					tv_idle--
					if tv_idle <= 0
					{
						tv_img = 0
						tv_spr = choose(spr_tv_idleanim1B3, spr_tv_idleanim2B3)
						tv_idle = random_range(60 * 3, 60 * 6)
					}
					if p.state == scr_player_mach3
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = spr_tv_machB3
						expressiontimer = 0
					}
					break
				case spr_tv_idleanim1B3:
				case spr_tv_idleanim2B3:
					if tv_img + 0.35 >= sprite_get_number(tv_spr) - 1
					{
						tv_img = 0
						tv_spr = spr_tv_idleB3
					}
					if p.state == scr_player_mach3
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = spr_tv_machB3
						expressiontimer = 0
					}
					break
				case spr_tv_machB3:
					if p.state != scr_player_mach3 && p.state != scr_player_machturn && p.state != scr_player_machslide
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
					if p.sprite_index == p.sprites.crazyrun
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = spr_tv_crazyrunB3
						expressiontimer = 0
					}
					break
				case spr_tv_crazyrunB3:
					if p.state != scr_player_mach3 && p.state != scr_player_machturn && p.state != scr_player_machslide
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
					if p.sprite_index != p.sprites.crazyrun
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = spr_tv_machB3
						expressiontimer = 0
					}
					break
				case spr_tv_hurtheavy1B3: 
				case spr_tv_hurtheavy2B3:
				case spr_tv_hurtheavy3B3: 
				case spr_tv_hurtheavy4B3:
				case spr_tv_hurtheavy5B3:
					expressiontimer = approach(expressiontimer, 0, 1) 
					if expressiontimer <= 0
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
					break
				case spr_tv_hurtB3:
				case spr_tv_happyB3:
					expressiontimer = approach(expressiontimer, 0, 1)
					if expressiontimer <= 0
					{
						switchindex = 0
						tv_state = "transition"
						expressionsprite = idle
						expressiontimer = 0
					}
				break
			}
			break
		case "transition":
			switchindex = approach(switchindex, sprite_get_number(spr_tv_transB3) - 1, 0.35)
			if switchindex >= sprite_get_number(spr_tv_transB3) - 1
			{
				tv_spr = expressionsprite
				switchindex = 0
				tv_state = "expression"
			}
			break
	}
	tv_img += 0.35
	if tv_img >= sprite_get_number(tv_spr) - 1
		tv_img = 0
	switch combo_state
	{
		case 0:
			combo_y = approach(combo_y, -160, 5)
			combo_vsp = 0
			if global.combo.amt > 0
			{
				combo_state++
				combo_vsp = 5
			}
			break
		case 1:
			combo_y = approach(combo_y, 220, combo_vsp)
			combo_vsp += 0.5
			if combo_y >= 210
				combo_state++
			break
		case 2:
			combo_y = lerp(combo_y, 192, 0.1)
			if global.combo.amt <= 0
				combo_state = 0
			break
	}
	combo_y2 = lerp(combo_y2, (60 - global.combo.timer) / 60 * 50, 0.4)
}
function scr_hudTTWOB_draw()
{
	var combo_shake = global.combo.timer < 30 ? (8 * (30 - global.combo.timer) / 30) : 0
	var combo_x = 820 + wave(-3, 3, 1, 0) + irandom_range(combo_shake, -combo_shake)
	var combo_yfin = combo_y + (combo_state != 1 ? irandom_range(combo_shake, -combo_shake) : 0)

	draw_set_halign(0)
	draw_set_valign(0)

	draw_sprite(spr_hudTTWOB_combo, 1, combo_x, combo_yfin - 25 + combo_y2)
	draw_sprite(spr_hudTTWOB_combo, 2, combo_x, combo_yfin - 25 + combo_y2)
	draw_sprite(spr_hudTTWOB_combo, 0, combo_x, combo_yfin)
	
	draw_set_font(global.font_hudTTWOB_combo)
	draw_text(combo_x - 19, combo_yfin + 53, global.combo.amt)
	
	draw_sprite_ext(spr_tv_bgB3, 0, 823, 73, 1, 1, 0, tvbg_backindex, 1)
	pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false)
	draw_sprite(tv_spr, tv_img, 823, 73)
	shader_reset()
	pattern_draw(tv_spr, tv_img, 823, 73, 1, 1, 0, c_white, 1, global.patternSpr, global.PlayerCharacters[obj_player.character].patColors);
	if tv_state == "transition"
		draw_sprite(spr_tv_transB3, switchindex, 823, 73)
	
	var _xx = 163, _yy = 88
	draw_sprite(spr_hudTTWOB_score,0,_xx,_yy)
	draw_set_font(global.font_hudTTWOB_score)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(_xx+13,_yy+13,global.collect)
	draw_set_halign(0)
	draw_set_valign(0)
	
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
	draw_sprite_ext(spr_hudTTWOB_rank, rankindex, _xx + 128, _yy, 1, 1, 0, c_white, 1)
}
function scr_hudTTWOB_clean()
{
}