draw_set_font(global.creditsfont)
draw_set_halign(1)
draw_set_valign(0)
draw_set_alpha(1)
draw_set_colour(c_white)
var _t = abs(ceil(global.prophuntmode.timer))
var _t2 = _t mod 60
_t = _t div 60

if win != 0
{
	var _txt = ""
	if win == 1
		_txt = lang_get_phrase("online_prophunt_win_props")
	else if win == 2
		_txt = lang_get_phrase("online_prophunt_win_hunters")
	draw_text(480+random_range(-1,1),458,_txt)
	exit
}

if global.prophuntmode.select == -4 && global.prophuntmode.waitphase
	draw_rectangle_colour(0,0,960,540,0,0,0,0,false)
draw_text(480+random_range(-1,1),25,string_concat(_t, ":", _t2 < 10 ? "0" : "", _t2))
if global.prophuntmode.waitphase
	draw_text(480+random_range(-1,1),458,global.prophuntmode.select == -4 ? lang_get_phrase("online_prophunt_waitphase_hunters") : lang_get_phrase("online_prophunt_waitphase_props"))
draw_set_halign(0)