if instance_exists(obj_option) exit

if state == "tv"
	draw_surface(surf,0,0)
else
{
	shader_sset(shd_menunew)
	shader_set_uniform_i(shd1, shdl)
	shader_set_uniform_f_array(shd2, shda)
	draw_surface(surf,0,0)
	shader_reset()
}


draw_set_font(global.creditsfont);
draw_set_halign(0);
draw_set_valign(0);
if state == "files"
{
	draw_sprite(spr_minilogo, 0, 796+sin(current_time/777)*4, 433+cos(current_time/777)*4)
	
	draw_textEX(25, 525-32-32-32,	"[J]/Left Click : Hold")
	draw_textEX(25, 525-32-32,		"[G]/Right Click : Slap")
	draw_textEX(25, 525-32,			"[S] : Options")
}
else if state == "draw"
{
	draw_textEX(25, 525-32-32-32,	"[J]/Left Click : Draw")
	draw_textEX(25, 525-32-32,		"[G]/Right Click : Erase")
	draw_textEX(25, 525-32,			"[S] : Go Back")
}
else if state == "tv"
{
	draw_textEX(25, 525-32,			"[S] : Go Back")
}