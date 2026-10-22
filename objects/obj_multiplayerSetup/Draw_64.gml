var _sel = bgs[bgssel]
var _sell = array_length(_sel)
for (var i = 0; i < _sell; i++)
{
	var _div = _sell-i
	_div = max(1,_div*_div)
	draw_sprite_tiled(_sel[i], 0, -bgx/_div, 0)
}
draw_set_alpha(bgsfade)
draw_rectangle_colour(0,0,960,540,0,0,0,0,false)
draw_set_alpha(1)
draw_set_halign(0)

if (menu == 0)
{
    var xx = 64, yy = (540 / 2) - (48 * (array_length(menus) - 2))
	var xs = xx, ys = yy
	draw_set_font(global.creditsfont)
    for (var i = 0; i < array_length(menus); i++)
    {
		var _amt = max(1 - abs(selectedlrp - i), 0), q = menus[i]
		
		if _amt > 0
		{
			xx = xs + lerp(-48, -8 + sin(current_time/100)*8, _amt)
			yy = ys + i*48
	        draw_set_alpha(_amt)
			draw_set_colour(c_aqua)
			draw_rectangle_colour(xx,yy,xx+string_width("("),yy+string_height("("),0,0,0,0,false)
			draw_text(xx, yy, "(")
			draw_set_alpha(1)
		}
		
		xx = (xs + sin(i*1.33+current_time/400)*3) + lerp(0, 32, _amt)
		yy = ys + i*48 + cos(i*1.33+current_time/400)*3
		draw_rectangle_colour(xx,yy,xx+string_width(q[1]),yy+string_height(q[1]),0,0,0,0,false)
		draw_set_colour(selected == i ? c_aqua : c_white)
		draw_text(xx, yy, q[1])
    }
}
else if (menu == 1)
{
	draw_set_font(global.creditsfont)
	draw_set_halign(fa_center)
	draw_set_colour(c_white)
    draw_textEX(960 / 2, 540 / 2, "[wave2]Enter server's IP")
    draw_textEX(960 / 2, (540 / 2) + 32, textInput)
	draw_set_halign(0)
}
