draw_set_alpha(onlrp*0.5)
draw_rectangle_colour(0, lerp(270,0,onlrp),960,lerp(270,540,onlrp),c_white,c_white,c_white,c_white,false)
draw_set_alpha(1)

var _sl1 = selectthinglrp >= 0.5 ? oldoldSelect : select, _sl2 = abs(selectthinglrp-0.5)*2

var xx = 0, yy = 0, hh = sprite_get_height(spr_pal[_sl1])
for (var i = 1; i < count_pal[_sl1]; i++)
{
	pal_swap_set(spr_pal[_sl1], i, false)
	draw_sprite_stretched(global.PlayerCharacters[_sl1].sprites.player.palettepreview, 0, 34+xx*_sl2, lerp(270,34+yy,onlrp)+(1-_sl2)*46, 46*(1+(1-_sl2)*2), 46*onlrp*_sl2)
	shader_reset()
	draw_sprite_stretched(spr_dressermenu_panel, select_pal[select] == i, 32+xx*_sl2, lerp(270,32+yy,onlrp)+(1-_sl2)*50, 50*(1+(1-_sl2)*2), 50*onlrp*_sl2)
	xx += 64
	if xx == 64*4
	{
		xx = 0
		yy += 64
	}
}

var _x = 960-270, _y = 270

var _p = function(_add,ya)
{
	var _s = (select + _add + select_count) mod select_count
	if _s >= 0 && _s < select_count
	{
		var _sc = max(0, 2-abs(ya)/175)
		ya = sin(ya/100)*100
		if _sc > 0.05
		{
			var _t = global.PlayerCharacters[_s].sprites.player.idle
			if _sc > 0.35
			{
				gpu_set_fog(true,merge_colour(c_white,c_aqua,max(0,_sc-1)),0,0)
				draw_sprite_ext(_t,-1,960-270+_sc,270+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,-1,960-270-_sc,270+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,-1,960-270,270+(ya+_sc)*onlrp,_sc,_sc*onlrp,0,c_white,1)
				draw_sprite_ext(_t,-1,960-270,270+(ya-_sc)*onlrp,_sc,_sc*onlrp,0,c_white,1)
				gpu_set_fog(false,c_white,0,0)
			}
			pal_swap_set(global.PlayerCharacters[_s].sprites.player.palette, select_pal[_s], false)
			draw_sprite_ext(_t,-1,960-270,270+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1)
			shader_reset()
			if _sc > 0.35
				pattern_draw(_t,-1,960-270,270+(ya*onlrp),_sc,_sc*onlrp,0,c_white,1,global.PlayerCharacters[_s].sprites.player.pattern, global.PlayerCharacters[_s].sprites.player.patcolours, global.PlayerCharacters[_s].sprites.player.palette, select_pal[_s])
			draw_sprite_ext(_t,-1,960-270,270+(ya*onlrp),_sc,_sc*onlrp,0,c_black,(2-_sc)/2)
		}
	}
}

_p(2,175*2+selectadd)
_p(1,175+selectadd)
_p(-1,-175+selectadd)
_p(-2,-175*2+selectadd)
_p(0,selectadd)

//draw_sprite_ext(spr_uparrow,0,960-116,270,3*onlrp,3,point_direction(_x,_y+(sin(selectadd/75)*100),960-96,_y)+90,c_white,1)
draw_set_font(global.smallfont)
draw_set_halign(2)
draw_set_valign(1)
draw_text_transformed(_x-100,270,string_lower(global.PlayerCharacters[_sl1].name),1,onlrp*_sl2,0)
draw_set_font(-1)
draw_set_halign(0)
draw_set_valign(0)