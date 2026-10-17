if floor(global.racemode.timer) >= 0
{
	draw_set_font(global.creditsfont)
	draw_set_halign(1)
	draw_set_valign(0)
	draw_set_alpha(1)
	draw_set_colour(c_white)
	var _t = ceil(global.racemode.timer)
	if _t >= 5
		draw_text(480+random_range(-1,1),458,_t-4)
	else if _t >= 2
		draw_text(480+random_range(-1,1),458,"GO!")
	draw_set_halign(0)
}