y = wave(ystart - 5, ystart + 5, 5, 5)
draw_self()
var _alpha = 1 - (distance_to_object(obj_player) / 250)
if _alpha > 0
{
    draw_set_alpha(_alpha)
    draw_set_font(global.creditsfont)
    draw_set_halign(fa_center)
    draw_textEX(x, y - 64, $"[wave2]{arr[0]}/{arr[1]}")
    draw_set_alpha(1)
}
