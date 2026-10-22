if (global.hide_hud)
    exit;

if (totemAlpha > 0)
{
    draw_set_alpha(totemAlpha);
    draw_sprite(spr_totems, totemIndex, 96, 540 - 92);
    draw_set_font(global.creditsfont);
    draw_set_halign(fa_center);
    draw_textEX(96, 540 - 164, $"[wave2]{itemsCur}/{itemsMax}!");
    draw_set_alpha(1);
}
