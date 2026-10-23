if (scene == 1)
	draw_clear(c_black)

if (scene == 1 || scene == 2)
{
    draw_sprite(titlecardinfo[0], 0, 0, min(y,0))
    draw_sprite(titlecardinfo[1], 0, irandom_range(-1, 1), -y+irandom_range(-1, 1))
	draw_sprite(titlecardinfo[2], 0, irandom_range(-1, 1), -y+irandom_range(-1, 1)+540)
    if obj_player.character == chars.milton
	{
        draw_sprite(titlecardMilton, titlecardMiltonIndex, 0, 0)
		titlecardMiltonIndex = approach(titlecardMiltonIndex, sprite_get_number(titlecardMilton) - 1, 0.4)
	}
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
draw_circle(960 / 2, 540 / 2, circleSize*(16/9), false);
gpu_set_blendmode_default()
surface_reset_target();
gpu_set_blendmode_ext(_blend[0],_blend[1]);
draw_set_alpha(fadeAlpha);
draw_surface(fadeSurface, 0, 0);
draw_set_alpha(1);
