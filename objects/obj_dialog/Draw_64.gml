if (active)
{
    var _xx = 960 / 2, _yy = 125
    draw_sprite(spr_dialogB, 0, _xx, _yy)
	if sprite_exists(dialogStuff[currentDialog][0])
		draw_sprite(dialogStuff[currentDialog][0], dialogStuff[currentDialog][3], _xx - 300, _yy)
    draw_set_font(font_dialog)
    draw_set_colour(c_black)
    draw_set_halign(fa_left)
    draw_text(_xx - 230, _yy - 32, string_hash_to_newline(textVisual))
    draw_set_colour(c_white)
}
