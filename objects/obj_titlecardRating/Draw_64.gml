if (!surface_exists(fadeSurface))
    fadeSurface = surface_create(960, 540);

surface_set_target(fadeSurface);
draw_clear_alpha(c_black, 0);
draw_set_colour(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_colour(c_white);
gpu_set_blendmode(bm_subtract);
draw_circle(960 / 2, 540 / 2, circleSize, false);
gpu_set_blendmode_default()
surface_reset_target();
draw_set_alpha(1);
draw_surface(fadeSurface, 0, 0);
draw_set_alpha(1);
draw_set_alpha(ratingAlpha);
draw_sprite(spr_ratingLabel, eForEveryone, 32, 32);
draw_set_alpha(1);
