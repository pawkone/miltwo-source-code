var _x = 960 / 2;
var _y = 540 - 100;
draw_set_alpha(textAlpha);
draw_set_font(global.creditsfont);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_textEX(_x, _y, palettes[selected].pName);
draw_textEX(_x, _y + 50, palettes[selected].desc);
draw_set_alpha(1);
