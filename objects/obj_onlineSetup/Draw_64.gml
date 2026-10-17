draw_sprite_tiled_ext(bg_shellA3, 0, -bgx/4, 0, 1, 1, c_dkgray, 1)
draw_sprite_tiled_ext(bg_shellA2, 0, -bgx/2, 0, 1, 1, c_dkgray, 1)
draw_sprite_tiled_ext(bg_shellA1, 0, -bgx, 0, 1, 1, c_dkgray, 1)

if (menu == 0)
{
    var xx = 960 / 2;
    var opt = menus[currentmenu];
    var yy = (540 / 2) - (48 * (array_length(opt) - 2));
    
    for (var i = 0; i < array_length(opt); i++)
    {
        var q = opt[i];
        var _col = (selected == i) ? 16777215 : 8421504;
        draw_set_font(global.bigfont);
        draw_set_colour(_col);
        draw_set_halign(fa_center);
        draw_textEX(xx, yy, q[1]);
        yy += 48;
    }
}

draw_set_font(global.creditsfont);
draw_set_halign(fa_center);

if (menu == 1)
{
    draw_textEX(960 / 2, 540 / 2, "[wave]Enter the IP");
    draw_textEX(960 / 2, (540 / 2) + 32, string("[wave]{0}", textInput));
}

if (menu == 2)
{
    draw_textEX(960 / 2, 540 / 2, "[wave]Enter the Port");
    draw_textEX(960 / 2, (540 / 2) + 32, string("[wave]{0}", textInput));
}

draw_set_colour(c_white);
