draw_self();

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_set_font(global.creditsfont);
    xdata_open(global.saveFile);
    draw_set_halign(fa_center);
    var _countTotems = (xdata_read("General", "Totem0", false) == true) + (xdata_read("General", "Totem1", false) == true) + (xdata_read("General", "Totem2", false) == true);
    draw_textEX(x, y - 164, string("{0}/3", _countTotems));
    xdata_close();
    draw_set_alpha(1);
}
