if timer > 0
	draw_sprite_ext(spr_fnf_countdown,countdownspr,480,270,1,1,0,c_white,countdownalpha)
for (var i = 0; i < array_length(sturmpal); i++)
{
	pal_swap_set(pal_fnf_arrows, sturmpal[i], false)
	draw_sprite_ext(spr_fnf_arrow, 0, (i>3 ? 288 : 0) + (96+((i mod 4>0)*8 + (i mod 4>2)*8)+i*64),64, 1, 1, i mod 4 == 0 ? 90 : (i mod 4 == 1 ? 180 : (i mod 4 == 2 ? 0 : 270)), c_white, 1)
	shader_reset()
}
with obj_fnf_arrowhold
{
	pal_swap_set(pal_fnf_arrows, pal, false)
	draw_self()
	shader_reset()
}
with obj_fnf_arrow
{
	pal_swap_set(pal_fnf_arrows, pal, false)
	draw_self()
	shader_reset()
}
with obj_fnf_arrowspla
{
	pal_swap_set(pal_fnf_arrows, pal, false)
	draw_self()
	shader_reset()
}
if collect != collectOld
{
	collectOld = collect
	text_imagescale = 1.1
}
text_imagescale = lerp(text_imagescale, 1, 0.175)
hpOld = lerp(hpOld, hp, 0.175)
if abs(hpOld - hp) < 0.005
	hpOld = hp

draw_set_alpha(1)
draw_set_font(global.smallfont)
draw_set_valign(0)
draw_set_halign(1)
draw_set_colour(c_white)
draw_text_transformed(x + 200, y + 24, $"score : {collect}   misses : {misses}", text_imagescale, text_imagescale, 0)
draw_set_halign(0)
	
draw_rectangle_colour(x, y, x + 400, y + 10, c_black, c_black, c_black, c_black, false)
draw_rectangle_colour(x + 1, y + 1, x + 399, y + 9, colour2, colour2, colour2, colour2, false)
draw_rectangle_colour(x + 1, y + 1, x + 399 - 200 * clamp(hpOld, -0.01, 2), y + 9, colour1, colour1, colour1, colour1, false)
draw_sprite_part_ext(spr_fnf_bficon, 0, hp < 0.4 ? 64 : 0, 0, 64, 64, (x + 400 - 200 * clamp(hpOld, -0.01, 2)) + (64 * (((iconZoom-1)*1.05)+1)), y - (32 * iconZoom), -iconZoom, iconZoom, c_white, 1)
draw_sprite_part_ext(spr_fnf_dadicon, 0, hp > 1.6 ? 64 : 0, 0, 64, 64, (x + 400 - 200 * clamp(hpOld, -0.01, 2)) - (64 * (((iconZoom-1)*1.05)+1)), y - (32 * iconZoom), iconZoom, iconZoom, c_white, 1)