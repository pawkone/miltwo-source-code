if (dark)
{
	var cam = view_camera[0]
	var _cx = camera_get_view_x(cam), _cy = camera_get_view_y(cam)
	var w = 960, h = 540
	if !surface_exists(fadeSurface) fadeSurface = surface_create(w, h)
	surface_set_target(fadeSurface)
	draw_clear_alpha(c_black, 0)
	draw_set_alpha(0.9)
	draw_set_colour(c_black)
	draw_rectangle(0, 0, w, h, false)
	gpu_set_blendmode(bm_subtract)
	draw_set_colour(c_white)
	draw_set_circle_precision(circlePre)
	if instance_exists(obj_player)
	{
		var px = obj_player.x - _cx
		var py = obj_player.y - _cy
		var r = circleRan
		draw_set_alpha(0.5)
		draw_circle(px+r[0], py+r[1], circleSizeLrp, false)
		draw_set_alpha(1)
		draw_circle(px+r[2], py+r[3], circleSizeLrp*0.8, false)
	}
	draw_set_circle_precision(24)
	draw_set_alpha(1)
	gpu_set_blendmode_default()
	surface_reset_target()
	with obj_baddie
	{
		var _old_image_alpha = image_alpha
		var _old_image_blend = image_blend
		image_alpha = clamp(((other.circleSizeLrp+50)-point_distance(obj_player.x, obj_player.y, x, y))/150,0,1)
		x -= _cx
		y -= _cy
		event_perform(ev_draw, 0)
		image_blend = c_black
		image_alpha = (1-image_alpha)*0.25
		event_perform(ev_draw, 0)
		x += _cx
		y += _cy
		image_alpha = _old_image_alpha
		image_blend = _old_image_blend
	}
	with obj_baddiedead
	{
		var _old_image_alpha = image_alpha
		var _old_image_blend = image_blend
		image_alpha = clamp(((other.circleSizeLrp+50)-point_distance(obj_player.x, obj_player.y, x, y))/150,0,1)
		x -= _cx
		y -= _cy
		event_perform(ev_draw, 0)
		image_blend = c_black
		image_alpha = (1-image_alpha)*0.25
		event_perform(ev_draw, 0)
		x += _cx
		y += _cy
		image_alpha = _old_image_alpha
		image_blend = _old_image_blend
	}
	draw_surface(fadeSurface, 0, 0)
}