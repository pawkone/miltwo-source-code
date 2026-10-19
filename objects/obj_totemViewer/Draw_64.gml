if (global.hide_hud)
    exit;

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_sprite(spr_totems, totemIndex, 96, 540 - 92);
    draw_set_font(global.creditsfont);
    xdata_open(global.saveFile);
    draw_set_halign(fa_center);
    draw_textEX(96, 540 - 164, string("[wave]{0}/3!", countTotems));
    xdata_close();
    draw_set_alpha(1);
}
