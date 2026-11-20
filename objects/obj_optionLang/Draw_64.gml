draw_sprite_tiled_ext(spr_optionsBG, 3, current_time/(1000/60), wave(-32, 32, 5, 0), 1, 1, c_white, 1)

draw_set_alpha(0.5)
draw_rectangle_colour(0,288,960,540,0,0,0,0,false)
draw_set_alpha(1)

shader_set(shd_wave)
shader_set_uniform_f(timeUniform, current_time/16)
shader_set_uniform_f(frequencyUniform, 0.02)
shader_set_uniform_f(amplitudeUniform, 0.04)
var _spr = sprs[select][0]
_spr = _spr > 0 ? _spr : spr_langDefault_flag
draw_sprite_stretched(_spr, 0, 480-64*sizet, 96, 128*sizet, 128)
shader_reset()

var _spr = sprs[select][1]
_spr = _spr > 0 ? _spr : spr_langDefault_gag
draw_sprite_stretched(_spr, 0, 960 - 128 - 96, 540 - 128 - 96, 128, 128)

draw_set_font(-1)
draw_set_halign(0)
draw_set_valign(2)
draw_text(96, 540-96, txt)
draw_set_valign(0)
if stop
{
	draw_set_alpha(0.75)
	draw_rectangle_colour(0,0,960,540,0,0,0,0,false)
	draw_set_alpha(1)
	draw_sprite(spr_escapeoventimer, 0, 480, 270)
}