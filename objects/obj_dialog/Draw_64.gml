if (active)
{
    var _xx = 960 / 2;
    var _yy = 125;
    draw_sprite(spr_dialogboxPlaceholder, 0, _xx, _yy);
    draw_sprite(dialogStuff[currentDialog].portrait, 0, _xx - 300, _yy);
    draw_set_font(font_dialogPlaceholder);
    draw_set_colour(c_black);
    draw_set_halign(fa_left);
    draw_text(_xx - 230, _yy - 32, textVisual);
    draw_set_colour(c_white);
}
