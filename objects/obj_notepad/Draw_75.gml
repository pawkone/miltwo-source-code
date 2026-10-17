draw_set_colour(c_white)
draw_set_alpha(1)
draw_rectangle(32,32,960-32,540-32,false)
draw_set_colour(c_black)
draw_set_halign(0)
draw_set_valign(0)
draw_set_font(-1)
for (var i = 0; i < array_length(strings); i++)
{
	draw_set_colour(done[i] ? c_green : c_red)
	draw_circle(64, 58 + (24*i), 3, false)
	draw_set_colour(c_black)
	draw_text(96, 48 + (24*i),
	strings[i] + (select == i ? ((round(current_time/500) mod 2 == 0) ? "|" :"") : "")
	)
}
draw_set_colour(c_white)