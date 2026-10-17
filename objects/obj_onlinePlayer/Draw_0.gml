if (currentRoom == room)
{
	if !sprite_exists(sprite_index)
		exit
	if object >= 0
	{
		draw_sprite_ext(sprite_index, image_index, xlerp+global.prophuntmode.sprites[object][2], ylerp+global.prophuntmode.sprites[object][3], global.prophuntmode.sprites[object][4] ? xscale : 1, 1, 0, c_white, 1)
		exit
	}
    draw_sprite_ext(sprite_index, image_index, xlerp, ylerp, xscale, 1, image_angle, image_blend, alpha);
    pal_swap_set(spr_palette, palIndex, false);
    draw_sprite_ext(sprite_index, image_index, xlerp, ylerp, xscale, 1, image_angle, image_blend, alpha);
    shader_reset();
    pattern_draw(sprite_index, image_index, xlerp, ylerp, xscale, 1, image_angle, image_blend, alpha, spr_pattern, spr_playerPatCol, spr_palette, palIndex);
    if (flash)
    {
        shader_sset(shd_silo);
        draw_sprite_ext(sprite_index, image_index, xlerp, ylerp, xscale, 1, image_angle, image_blend, alpha);
        shader_reset();
    }
    draw_set_font(global.smallfont);
    draw_set_colour(hunter ? c_red : c_white);
    draw_set_halign(fa_center);
    draw_text_transformed(xlerp, ylerp + ylerpname - 72, string_lower(name), global.modifiers.flipped ? -1 : 1, 1, 0);
	draw_set_colour(c_white);
    draw_set_halign(0);
}