if global.hide_hud
    exit
draw_set_alpha(alpha)
draw_sprite(spr_totems, index, 96, 540 - 92)
draw_set_font(global.creditsfont)
draw_set_halign(fa_center)
draw_textEX(96, 540 - 164, $"[wave2]{arr[0]}/{arr[1]}!")
draw_set_alpha(1)