draw_set_colour(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_colour(c_white);

if (showFmod)
    draw_sprite(spr_intro_fmod, 0, 960 / 2, 540 / 2);
if (showMiltu)
    draw_sprite(spr_intro_logo_miltu, 0, 960 / 2, 540 / 2);
if (showHeart)
    draw_sprite(spr_intro_logo_heart, 0, 960 / 2, 540 / 2);

draw_set_alpha(blackAlpha);
draw_set_colour(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_colour(c_white);
draw_set_alpha(1);
