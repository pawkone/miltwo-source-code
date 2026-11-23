draw_set_alpha(onlrp*0.5)
draw_rectangle_colour(0, lerp(270,0,onlrp),960,lerp(270,540,onlrp),0,0,0,0,false)
draw_set_alpha(1)

var xx = lerp(-64*5, 128, palmode_lrp), yy = 0, hh = sprite_get_height(spr_pal[select])
for (var i = 1; i < count_pal[select]; i++)
{
	pal_swap_set(spr_pal[select], i, false)
	draw_sprite_stretched(global.PlayerCharacters[select].sprites.player.palettepreview, 0, 34+xx, lerp(270,34+yy,onlrp), 46, 46*onlrp)
	shader_reset()
	pattern_draw(global.PlayerCharacters[select].sprites.player.palettepreview, 0,34+xx, lerp(270,34+yy,onlrp), 1, onlrp,0,c_white,1,global.PlayerCharacters[select].sprites.player.pattern, global.PlayerCharacters[select].sprites.player.patcolours, spr_pal[select], i)
	draw_sprite_stretched(spr_dressermenu_panel, select_pal[select] == i, 32+xx, lerp(270,32+yy,onlrp), 50, 50*onlrp)
	xx += 64
	if i mod 4 == 0
	{
		xx -= 64 * 4
		yy += 64
	}
}

var _x = lerp(480, 960-270, palmode_lrp), _y = 270

var _p = function(_add,ya,_xx,_yy)
{
	var _s = (select + _add + select_count) mod select_count
	if _s >= 0 && _s < select_count
	{
		var _sc = max(0, 2-abs(ya)/175)
		ya = sin(ya/100)*100
		if _sc > 0.05
		{
			var _f = _s == chars.soda ? clamp(select_pal[_s]-1, 0, sprite_get_width(spr_playersoda_idle)-1) : -1
			var _t = global.PlayerCharacters[_s].sprites.player.idle
			if _sc > 0.35
			{
				gpu_set_fog(true,merge_colour(c_white,c_aqua,max(0,_sc-1)),0,0)
				draw_sprite_ext(_t,_f,_xx+_sc,_yy+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,_f,_xx-_sc,_yy+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,_f,_xx,_yy+(ya+_sc)*onlrp,_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,_f,_xx,_yy+(ya-_sc)*onlrp,_sc,_sc*onlrp,0,c_white,1)
				gpu_set_fog(false,c_white,0,0)
			}
			pal_swap_set(spr_pal[_s], select_pal[_s], false)
			draw_sprite_ext(_t,_f,_xx,_yy+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
			shader_reset()
			if _sc > 0.35
				pattern_draw(_t,_f,_xx,_yy+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1,global.PlayerCharacters[_s].sprites.player.pattern, global.PlayerCharacters[_s].sprites.player.patcolours, spr_pal[_s], select_pal[_s])
			draw_sprite_ext(_t,_f,_xx,_yy+(ya*onlrp),_sc,_sc*onlrp,0,c_black,(2-_sc)/2)
		}
	}
}

_p(-2,-175*2+selectadd,_x,_y)
_p(2,175*2+selectadd,_x,_y)
_p(1,175+selectadd,_x,_y)
_p(-1,-175+selectadd,_x,_y)
_p(0,selectadd,_x,_y)

draw_set_halign(1)
draw_set_valign(1)
var _sl1 = selectthinglrp >= 0.5 ? oldoldSelect : select
var _n = global.PlayerCharacters[_sl1].name
if _sl1 == chars.soda
{
	switch clamp(select_pal[_sl1]-1, 0, sprite_get_width(spr_playersoda_idle)-1)
	{
		case 1: _n += " (Liquor)" break
		case 2: _n += " (Ludicrous)" break
		case 3: _n += " (PBSB)" break
		case 4: _n += " (Burger)" break
		case 5: _n += " (Bacon Prime)" break
	}
}
if palmode_lrp < 1
{
	draw_set_font(global.creditsfont)
	draw_text_transformed(_x-(100+string_width(_n)/2)*palmode_lrp, lerp(540-64, 270, palmode_lrp),_n,1,(onlrp*(1-palmode_lrp)*abs(selectthinglrp-0.5)*2),0)
}
if palmode_lrp > 0
{
	_n = string_lower(_n)
	draw_set_font(global.smallfont)
	draw_text_transformed(_x-(100+string_width(_n)/2)*palmode_lrp, lerp(540-64, 270, palmode_lrp),_n,1,(onlrp*palmode_lrp*abs(selectthinglrp-0.5)*2),0)
}
draw_set_font(-1)
draw_set_halign(0)
draw_set_valign(0)