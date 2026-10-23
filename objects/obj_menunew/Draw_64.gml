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
	draw_sprite(spr_minilogo, 0, 866+sin(current_time/777)*4, 483+cos(current_time/777)*4)
	
	draw_textEX(25, 525-32-32-32, lang_get_phrase("menunew_files_controltip1"))
	draw_textEX(25, 525-32-32, lang_get_phrase("menunew_files_controltip2"))
	draw_textEX(25, 525-32, lang_get_phrase("menunew_files_controltip3"))
}
else if state == "draw"
{
	draw_textEX(25, 525-32-32-32, lang_get_phrase("menunew_draw_controltip1"))
	draw_textEX(25, 525-32-32, lang_get_phrase("menunew_draw_controltip2"))
	draw_textEX(25, 525-32, lang_get_phrase("menunew_draw_controltip3"))
}
else if state == "tv"
	draw_textEX(25, 525-32, lang_get_phrase("menunew_tv_controltip1"))

if state == "files"
	event_user(0)
else if state == "draw"
	event_user(1)
else if state == "tv"
	event_user(2)