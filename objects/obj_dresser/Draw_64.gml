if textAlpha > 0
{
	var _x = 960 / 2;
	var _y = 540 - 100;
	draw_set_alpha(textAlpha);
	draw_set_font(global.creditsfont);
	draw_set_colour(c_white);
	draw_set_halign(fa_center);
	draw_textEX(_x, _y, $"{obj_player.palIndex+1} / {sprite_get_width(obj_player.sprites.palette)+1}");
	draw_set_alpha(1);
}