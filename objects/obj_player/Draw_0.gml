var sprReal = playerUtil_realSpr()

var _new = character == chars.milton || isMildred || character == chars.pepperni || character == chars.soda

if (super)
{
    for (var i = 0; i < 16; i++)
    {
        var _xx = sin((current_time * 0.001) + (2 * i)) * 2 * i;
        var _yy = cos((current_time * 0.001) + (1 * i)) * 2 * i;
        var _alpha = abs(sin((current_time * 0.001) + (5 * i))) * 0.1;
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(sprReal, image_index, x + _xx, y + _yy, xscale * (_new ? squashX : 1) * xscaleMulti, (1 * _new ? squashY : 1) * yscaleMulti, angle, c_red, image_alpha * _alpha);
        gpu_set_blendmode_default()
    }
}

pal_swap_set(spr_palette, palIndex, false);
draw_sprite_ext(sprReal, image_index, x, y, xscale * (_new ? squashX : 1) * xscaleMulti, (1 * _new ? squashY : 1) * yscaleMulti, angle, image_blend, image_alpha);
shader_reset();
squashX = lerp(squashX, 1, 0.25);
squashY = lerp(squashY, 1, 0.25);
pattern_draw(sprReal, image_index, x, y, xscale * (_new ? squashX : 1) * yscaleMulti, (1 * _new ? squashY : 1) * yscaleMulti, angle, image_blend, image_alpha, global.patternSpr, global.PlayerCharacters[character].patColors);

if (flash)
{
    shader_sset(shd_silo);
    draw_sprite_ext(sprReal, image_index, x, y, xscale * (_new ? squashX : 1) * xscaleMulti, (1 * _new ? squashY : 1) * yscaleMulti, angle, image_blend, image_alpha);
    shader_reset();
}

if uparrow > 0
	draw_sprite_ext(spr_uparrow,0,x,y+-abs(sin(current_time/200)*10)-lerp(40,55,uparrow),lerp(0,1,uparrow),lerp(0,1,uparrow),lerp(0,360,uparrow)+sin(current_time/200)*20,c_white,3-uparrow)

if instance_exists(obj_onlineHandler)
{
	var _c = (global.prophuntmode.active && instance_exists(obj_onlineProphunt) && global.prophuntmode.select < 0) ? c_red : c_white, _hash = 0
	if _c == c_white
	{
		for (var i = 1; i <= string_length(global.username); i++)
			_hash = (_hash * 31 + ord(string_char_at(global.username, i))) mod 16777216
		_c = make_color_hsv(_hash mod 256, 60 + (floor(_hash / 256) mod 63), 255)
	}
	
	if sprite_exists(sprite_index)
		ylerpname = lerp(ylerpname, sprite_get_bbox_top(sprite_index), 0.05)
	
    draw_set_font(global.smallfont);
    draw_set_colour(_c);
    draw_set_halign(fa_center);
    draw_text_transformed(x, y + ylerpname - 72, global.username, global.modifiers.flipped ? -1 : 1, 1, 0);
	draw_set_colour(c_white);
    draw_set_halign(0);
}