BGX--
if BGX > 400 BGX = BGX mod 400

draw_set_colour(c_white);
draw_sprite_tiled_ext(spr_optionsBG, 0, BGX, wave(-32, 32, 5, 0), 1, 1, c_white, 1);

for (var i = 0; i < array_length(backgrounds); i++)
{
	if backgrounds[i].alpha > 0
		draw_sprite_tiled_ext(spr_optionsBG, backgrounds[i].index, BGX, wave(-32, 32, 5, 0), 1, 1, c_white, backgrounds[i].alpha);
    
    if (backgrounds[i].menu != [optionstype.mainpage])
    {
        var _alpha = 0;
        
        for (var q = 0; q < array_length(backgrounds[i].menu); q++)
        {
            if (currentmenu == backgrounds[i].menu[q])
                _alpha = 1;
        }
        
        backgrounds[i].alpha = approach(backgrounds[i].alpha, _alpha, 0.1);
    }
    else
    {
        backgrounds[i].alpha = 1;
    }
}

var m = menus[currentmenu];
var opt = m.options;
var _length = array_length(opt);

switch (m.anchor)
{
    case optionstype.anchor_center:
        var xx = 960 / 2;
        var yy = (540 / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            var q = opt[i];
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_font(global.bigfont);
            draw_set_colour(_col);
            draw_set_halign(fa_center);
            draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
            
            if (is_struct(q.icon))
            {
                draw_set_alpha(q.icon.alpha);
                draw_sprite(spr_pauseicons, q.icon.index, floor((xx + irandom_range(-1, 1)) - (string_width(lang_get_phrase(q.name)) / 2) - 50), floor(yy + (m.ypad * i) + irandom_range(-1, 1)));
                draw_set_alpha(1);
                q.icon.alpha = approach(q.icon.alpha, selected == i, 0.1);
            }
        }
        
        break;
    
    case optionstype.anchor_left:
        var xx = 960 / 5;
        var yy = (540 / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            draw_set_font(global.bigfont);
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_colour(_col);
            var q = opt[i];
            
            switch (q.type)
            {
                case optionstype.element_button:
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    break;
                
                case optionstype.element_toggle:
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    draw_set_halign(fa_right);
                    draw_textEX(960 - xx, yy + (m.ypad * i), lang_get_phrase(q.toggle[q.val]));
                    break;
                
                case optionstype.element_slider:
                    if (selected != i && q.moving)
                        q.moving = false;
                    
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    draw_set_halign(fa_right);
                    draw_sprite(spr_slider, 0, 960 - xx - 150, yy + (m.ypad * i));
                    draw_sprite((currentmenu != 1) ? spr_slidericon2 : spr_slidericon, q.moving, (960 - xx - 150) + (200 * (q.val / 100)), yy + (m.ypad * i) + 12);
                    break;
            }
        }
        
        break;
    
    case optionstype.anchor_controls:
        draw_set_halign(fa_left);
        draw_sprite(spr_tutorialkey, 0, 56, (540 - 192) + 2);
        draw_set_colour(c_black);
        draw_set_font(global.npcfont);
        draw_set_halign(fa_left);
        draw_text(59, 540 - 192 - 6, "F1");
        draw_set_colour(c_white);
        draw_set_font(global.bigfont);
        draw_textEX(64, 540 - 128, lang_get_phrase("option_add_bind"));
        draw_text(128, 540 - 192, lang_get_phrase("option_reset_binds"));
        draw_textEX(64, 540 - 64, lang_get_phrase("option_clear_binds"));
        
        for (var i = 0; i < _length; i++)
        {
            draw_set_font(global.bigfont);
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_colour(_col);
            var q = opt[i];
            
            switch (q.type)
            {
                case optionstype.element_button:
                    var xx = 960 / 5;
                    var yy = 16 + m.ypad;
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    break;
                
                case optionstype.element_bind:
                    var xx = (960 / 2) - 16;
                    var yy = (16 + m.ypad) - keyscroll;
                    draw_set_colour(_col);
                    keyscroll = lerp(keyscroll, 48 * (selected - 1), 0.02);
                    
                    if (!is_string(q.iconIndex))
                    {
                        draw_sprite_ext(spr_controlicons, q.iconIndex, xx, yy + (m.ypad * i), 1, 1, 0, _col, 1);
                    }
                    else
                    {
                        draw_set_font(global.bigfont);
                        draw_set_halign(fa_left);
                        draw_textEX(xx - 16, yy + (m.ypad * i), q.iconIndex);
                    }
                    
                    draw_set_halign(fa_right);
                    
                    for (var p = 0; p < array_length(variable_struct_get(global.inputMap, q.key)); p++)
                    {
                        if (currentmenu == 6)
                        {
                            switch (array_get(variable_struct_get(global.inputMap, q.key), p))
                            {
                                case 37:
                                    draw_sprite(spr_tutorialkeyspecial, 6, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 40:
                                    draw_sprite(spr_tutorialkeyspecial, 4, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 38:
                                    draw_sprite(spr_tutorialkeyspecial, 3, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 39:
                                    draw_sprite(spr_tutorialkeyspecial, 5, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32:
                                    draw_sprite(spr_tutorialkeyspecial, 2, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 17:
                                    draw_sprite(spr_tutorialkeyspecial, 1, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 27:
                                    draw_sprite(spr_tutorialkeyspecial, 7, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 16:
                                    draw_sprite(spr_tutorialkeyspecial, 0, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                default:
                                    draw_sprite(spr_tutorialkey, 0, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    draw_set_colour(c_black);
                                    draw_set_font(global.npcfont);
                                    draw_set_halign(fa_left);
                                    draw_text(960 - 64 - (42 * p), (yy + (m.ypad * i)) - 6, chr(array_get(variable_struct_get(global.inputMap, q.key), p)));
                                    break;
                            }
                        }
                        
                        if (currentmenu == 8)
                        {
                            switch (array_get(variable_struct_get(global.inputMap, q.key), p))
                            {
                                case 32769:
                                    draw_sprite(global.buttonSpr, 0, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32770:
                                    draw_sprite(global.buttonSpr, 1, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32771:
                                    draw_sprite(global.buttonSpr, 2, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32772:
                                    draw_sprite(global.buttonSpr, 3, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32773:
                                    draw_sprite(global.buttonSpr, 4, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32774:
                                    draw_sprite(global.buttonSpr, 5, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32776:
                                    draw_sprite(global.buttonSpr, 6, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32775:
                                    draw_sprite(global.buttonSpr, 7, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32779:
                                    draw_sprite(global.buttonSpr, 8, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32780:
                                    draw_sprite(global.buttonSpr, 9, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32781:
                                    draw_sprite(global.buttonSpr, 10, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32784:
                                    draw_sprite(global.buttonSpr, 11, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32782:
                                    draw_sprite(global.buttonSpr, 12, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32783:
                                    draw_sprite(global.buttonSpr, 13, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32778:
                                    draw_sprite(global.buttonSpr, 14, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32777:
                                    draw_sprite(global.buttonSpr, 15, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLL":
                                    draw_sprite(global.joystickSpr, 0, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLR":
                                    draw_sprite(global.joystickSpr, 1, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLU":
                                    draw_sprite(global.joystickSpr, 2, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLD":
                                    draw_sprite(global.joystickSpr, 3, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRL":
                                    draw_sprite(global.joystickSpr, 4, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRR":
                                    draw_sprite(global.joystickSpr, 5, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRU":
                                    draw_sprite(global.joystickSpr, 6, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRD":
                                    draw_sprite(global.joystickSpr, 7, 960 - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                            }
                        }
                    }
                    
                    break;
            }
        }
        
        break;
		
	case optionstype.anchor_credits:
		draw_set_halign(0)
		draw_set_valign(0)
		
		if miltwocredits_extendview_enabled
		{
			var _gal = miltwocredits_credits[miltwocredits_selected]
			var _gal2 = _gal[miltwocredits_extendview_selected+2], _gal2n = "???"
			if sprite_exists(_gal2) _gal2n = sprite_get_name(_gal2)
			else if audio_exists(_gal2) _gal2n = audio_get_name(_gal2)
			var _oldm = miltwocredits_extendview_selected
			var _move = mky_left2 + mky_right2
			miltwocredits_extendview_selected = wrap(miltwocredits_extendview_selected + _move, 0, array_length(_gal)-3)
			if _oldm != miltwocredits_extendview_selected
			{
				audio_stop_sound(miltwocredits_extendview_music)
				miltwocredits_extendview_music = -4
			}
			draw_set_halign(1)
			draw_set_font(-1)
			if sprite_exists(_gal2)
			{
				var _spd = (sprite_get_speed_type(_gal2) == spritespeed_framespersecond ? ((current_time/1000)*sprite_get_speed(_gal2)) : ((current_time/1000)*60*sprite_get_speed(_gal2)))*0.35
				var _w = sprite_get_width(_gal2), _h = sprite_get_height(_gal2)
				var _scale = min(960 / _w, 540 / _h, 1)
				draw_set_alpha(0.5)
				draw_rectangle_colour((960 - _w * _scale) / 2, (540 - _h * _scale) / 2, (960 - _w * _scale) / 2 + _w * _scale, (540 - _h * _scale) / 2 + _h * _scale, 0, 0, 0, 0, false)
				draw_set_alpha(1)
				draw_sprite_stretched(_gal2, _spd, (960 - _w * _scale) / 2, (540 - _h * _scale) / 2, _w * _scale, _h * _scale)
			}
			if audio_exists(_gal2)
			{
				draw_set_valign(1)
				if miltwocredits_extendview_music == -4
					draw_text(480, 270, $"{_gal2n}\n{timeString(0)}/{timeString(audio_sound_length(_gal2))}")
				else
					draw_text(480, 270, $"{_gal2n}\n{timeString(audio_sound_get_track_position(miltwocredits_extendview_music))}/{timeString(audio_sound_length(_gal2))}")
				if mky_jump2
				{
					if miltwocredits_extendview_music == -4
						miltwocredits_extendview_music = audio_play_sound(_gal2, 10, true)
					else
					{
						audio_stop_sound(miltwocredits_extendview_music)
						miltwocredits_extendview_music = -4
					}
				}
				draw_set_valign(0)
			}
			var _w = string_width(_gal2n)/2+4
			draw_rectangle_colour(480-_w,460-2,480+_w,460+22,0,0,0,0,false)
			draw_text(480,460,_gal2n)
			var _txt = $"{miltwocredits_extendview_selected+1}/{array_length(_gal)-2}"
			var _w = string_width(_txt)/2+4
			draw_rectangle_colour(480-_w,484-2,480+_w,484+22,0,0,0,0,false)
			draw_text(480,484,_txt)
			draw_set_halign(0)
			if mky_slap2 && buffer == 0
			{
				buffer = 2
				miltwocredits_extendview_enabled = false
				miltwocredits_extendview_selected = 0
				audio_stop_sound(miltwocredits_extendview_music)
				miltwocredits_extendview_music = -4
			}
		}
		else
		{
			var kl = array_length(miltwocredits_creditsshow)
			miltwocredits_selected = clamp(miltwocredits_selected + mky_down2 - mky_up2, 0, kl-1)
			miltwocredits_yoffset = lerp(miltwocredits_yoffset, miltwocredits_starty[miltwocredits_selected], 0.25)
			if mky_slap2 || (mky_jump2 && miltwocredits_selected == 0) && buffer == 0
			{
				buffer = 2
				miltwocredits_selected = 0
				menus[currentmenu].backfunc();
				FMODevent_oneshot("event:/Sfx/UI/Pause/menuback");
			}
			if mky_jump2 && miltwocredits_selected != 0 && buffer == 0
			{
				buffer = 2
				miltwocredits_extendview_enabled = true
				// make it show miltwocredits_credits
				// and not miltwocredits_creditsshow for ONE PERSON
				// make it like a slideshow and support music (sfx is too low effort, no need to credit) too
			}
		
			var _xx = 228, _yy = 64 - miltwocredits_yoffset
			for (var k = 0; k < kl; k++)
			{
				var ki = miltwocredits_creditsshow[k]
				var kil = array_length(ki)
			
				draw_set_font(global.smallfont)
				var _w2 = string_width(ki[1]), _h2 = string_height(ki[1])
				draw_set_font(global.creditsfont)
				var _w1 = string_width(ki[0]), _h1 = string_height(ki[0])
			
				draw_set_colour(miltwocredits_selected == k ? c_aqua : c_black)
				draw_rectangle(_xx-4,_yy-4,_xx+(max(_w1, _w2))+4,_yy+_h1+_h2+4, false)
			
				draw_set_colour(c_white)
				draw_text(_xx, _yy+1, ki[0])
				draw_text(_xx, _yy, ki[0])
				_yy += string_height(ki[0])
				draw_set_font(global.smallfont)
				draw_text(_xx, _yy, ki[1])
			
				_yy += miltwocredits_startoffset[k] / 2
				if kil > 3
				{
					var _show = (floor(current_time / 500) + ((current_time % 500 > 300) ? power((current_time % 500 - 300) / 200, 3) : 0)) % (kil - 2)
					var jf = round(_show) + 2, globalfuckeryoffset = 16
					var fuckme = 48 + ((kil - 2) / 2) * globalfuckeryoffset
					for (var j = 2; j < kil; j++)
					{
						if j != jf
						{
							var _xx2 = wrap2(((j - 2) - _show), -(kil - 2) / 2, (kil - 2) / 2), _t = max(0, 1 - abs(wrap2((_show - (j - 2)), -(kil - 2) / 2, (kil - 2) / 2)))
							draw_sprite_ext(ki[j], (current_time / 1000) * 21, _xx + fuckme + _xx2 * globalfuckeryoffset, _yy, 1, 1, 0, c_white, lerp(0.2, 1, _t))
						}
					}
					if jf >= 2 && jf < kil
					{
						var _xx2 = wrap2(((jf - 2) - _show), -(kil - 2) / 2, (kil - 2) / 2), _t = max(0, 1 - abs(wrap2((_show - (jf - 2)), -(kil - 2) / 2, (kil - 2) / 2)))
						draw_sprite_ext(ki[jf], (current_time / 1000) * 21, _xx + fuckme + _xx2 * globalfuckeryoffset, _yy, 1, 1, 0, c_white, lerp(0.2, 1, _t))
					}
				}
				else if kil == 3
					draw_sprite_ext(ki[2], (current_time / 1000) * 21, _xx + 48, _yy, 1, 1, 0, c_white, 1)
				_yy += miltwocredits_startoffset[k] / 2
				if k == 0
					_yy += 72
			}
		}
		break;
}

draw_set_colour(c_white);

if (changingBind)
{
    draw_set_alpha(0.5);
    draw_set_colour(c_black);
    draw_rectangle(0, 0, 960, 540, false);
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_textEX(960 / 2, 540 / 2, "PRESS ANY KEY");
}

if desc_alpha > 0
{
	draw_set_alpha(desc_alpha/2);
    draw_set_colour(c_black);
	draw_set_font(global.smallfont);
	var _strw = string_width(desc_text)
	var _strh = string_height(desc_text)
    draw_roundrect_ext(960/2-_strw/2-16, 540-48-_strh/2-16, 960/2+_strw/2+16, 540-48+_strh/2+16, 20, 20, false);
	draw_set_colour(c_white);
	draw_set_alpha(desc_alpha);
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(960/2, 540-48,desc_text)
	draw_set_alpha(1);
	draw_set_halign(0)
	draw_set_valign(0)
}
