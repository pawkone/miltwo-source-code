draw_self();

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_set_font(global.creditsfont);
    draw_set_halign(fa_center);
    draw_textEX(x, y - 64, $"[wave2]{obj_totemViewer.itemsCur}/{obj_totemViewer.itemsMax}");
    draw_set_alpha(1);
}
