var _xa = irandom_range(-shake, shake)

var _open = !premode && openamount > 0

if _open
{
	var _surf = surface_create(sprite_get_width(spr_floorgate), sprite_get_height(spr_floorgate));
	surface_set_target(_surf);
	if entering
	{
		with obj_player
		{
			x -= other.x
			y -= other.y
			event_perform(ev_draw, 0)
			x += other.x
			y += other.y
		}
	}
	draw_sprite(spr_floorgate, 2, openamount*-50, 0);
	draw_sprite(spr_floorgate, 3, openamount*50, 0);
	surface_reset_target();
    
	var _clip = surface_create(sprite_get_width(spr_floorgate), sprite_get_height(spr_floorgate));

	surface_set_target(_clip)
	draw_clear(c_white)
	gpu_set_blendmode(bm_subtract)
	draw_sprite(spr_floorgate, 1, 0, 0)
	surface_reset_target()

	surface_set_target(_surf)
	draw_surface(_clip, 0, 0)
	gpu_set_blendmode(bm_normal)
	surface_reset_target()
}

pal_swap_set(spr_floorgate_pal, palette, false)

draw_sprite(spr_floorgate, 1, x+_xa, y)
if !_open
{
	draw_sprite(spr_floorgate, 2, x+_xa, y);
	draw_sprite(spr_floorgate, 3, x+_xa, y);
}
draw_sprite(spr_floorgate, 0, x+_xa, y)
if _open
{
	draw_surface(_surf, x+_xa, y)
	surface_free(_surf)
	surface_free(_clip)
}

draw_sprite_ext(spr_floorgate_over, label, x+_xa, y, 1, 1, 0, c_white, 0.75+(sin(current_time/250)*0.25)-random(35)/100)

shader_reset()