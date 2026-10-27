if (!surface_exists(fadeSurface))
    fadeSurface = surface_create(960, 540);

var _blend = gpu_get_blendmode_ext()
surface_set_target(fadeSurface);
draw_clear_alpha(c_black, 0);
draw_set_colour(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_colour(c_white);
gpu_set_blendmode(bm_subtract);
draw_circle((obj_player.x - camera_get_view_x(view_camera[0])) * (960 / camera_get_view_width(view_camera[0])), (obj_player.y - camera_get_view_y(view_camera[0])) * (540 / camera_get_view_height(view_camera[0])), circleSize*(16/9), false);
gpu_set_blendmode_default()
surface_reset_target();
gpu_set_blendmode_ext(_blend[0],_blend[1]);
draw_surface(fadeSurface, 0, 0);
draw_set_alpha(1);
