draw_set_alpha(image_alpha);
draw_set_colour(c_white);
var _cx = camera_get_view_x(view_camera[0])
var _cy = camera_get_view_y(view_camera[0])
draw_rectangle(_cx-128, _cy-128, _cx + 960 + 128, _cy + 540 + 128, false);

if (instance_exists(obj_player))
{
    with (obj_player)
    {
		var ogblend = image_blend
		var ogalpha = image_alpha
		image_blend = c_black
		image_alpha = other.image_alpha
		event_perform(ev_draw, 0)
		image_blend = ogblend
		image_alpha = ogalpha
	}
}

if (instance_exists(obj_baddiedead))
{
    with (obj_baddiedead)
    {
        if (sprite_index == spr_mugmonolith_dead)
            draw_sprite_ext(sprite_index, image_index, x - camera_get_view_x(view_camera[0]), y - camera_get_view_y(view_camera[0]), image_xscale, image_yscale, image_angle, c_black, other.image_alpha);
    }
}

draw_set_colour(c_white);
draw_set_alpha(1);
