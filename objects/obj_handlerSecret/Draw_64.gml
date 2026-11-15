if dudles_text != -4
{
	draw_set_font(global.smallfont)
	draw_set_alpha(1)
	draw_set_valign(0)
	draw_set_halign(1)
	draw_set_colour(c_white)
	draw_textEX(480,500,$"dudles left : {dudles_text}")
}