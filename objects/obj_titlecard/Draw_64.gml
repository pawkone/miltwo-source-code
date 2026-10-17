if (scene == 1 || scene == 2)
{
    titlecardName.x = irandom_range(-1, 1);
    titlecardName.y = irandom_range(-1, 1);
    draw_sprite(titlecardSprite, 0, 0, 0);
    
    if (obj_player.character == chars.milton)
        draw_sprite(titlecardMilton, titlecardMiltonIndex, 0, 0);
    
    draw_set_alpha(titlecardName.alpha);
    draw_sprite(titlecardName.sprite, 0, titlecardName.x, titlecardName.y);
    draw_set_alpha(1);
}

if (!surface_exists(fadeSurface))
    fadeSurface = surface_create(960, 540);

var _blend = gpu_get_blendmode_ext()
surface_set_target(fadeSurface);
draw_clear_alpha(c_black, 0);
draw_set_colour(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_colour(c_white);
gpu_set_blendmode(bm_subtract);
draw_circle(960 / 2, 540 / 2, circleSize, false);
gpu_set_blendmode(bm_normal)
surface_reset_target();
gpu_set_blendmode_ext(_blend[0],_blend[1]);
draw_set_alpha(fadeAlpha);
draw_surface(fadeSurface, 0, 0);
draw_set_alpha(1);
