draw_self();

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_set_font(global.creditsfont);
    xdata_open(global.saveFile);
    draw_set_halign(fa_center);
    draw_textEX(x, y - 164, string("{0}/3", countTotems));
    xdata_close();
    draw_set_alpha(1);
}
