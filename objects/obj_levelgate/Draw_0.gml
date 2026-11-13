draw_set_alpha(1)
draw_rectangle_colour(bbox_left,bbox_top,bbox_right,bbox_bottom,c_white,c_white,c_white,c_white,false)
if (bgalpha > 0)
{
	var cx = camera_get_view_x(view_camera[0]), cy = camera_get_view_y(view_camera[0])
	if !surface_exists(surf)
		surf = surface_create(bbox_right-bbox_left+1, bbox_bottom-bbox_top+1)
	surface_set_target(surf)
	draw_clear(c_white)
	for (var i = 0; i < array_length(gateinfo); i++)
	{
	    var q = gateinfo[i]
	    if !q[6]
	    {
			q[2] += q[4]
	        q[3] += q[5]
	    }
	    draw_sprite_tiled(q[0], q[1], q[2]+q[6]*((960 - (cx * 0.05)) + (960 / 5)), q[3]+q[6]*((540 - (cy * 0.05) - (540 / 2)) + 8))
	}
	surface_reset_target()
	draw_surface_ext(surf, bbox_left, bbox_top,1,1,0,c_white,bgalpha)
}
draw_self();
if place_meeting(x,y,obj_player) && scr_getera() == "TTWOB"
{
	var _r = rank
	if (_r == "D") _r = 0
	else if (_r == "C") _r = 1
	else if (_r == "B") _r = 2
	else if (_r == "A") _r = 3
	else if (_r == "S") _r = 4
	else if (_r == "P") _r = 5
	else _r = 0
	draw_sprite(spr_hudTTWOB_rank,_r,x,y-150)
	draw_set_font(global.smallfont)
	draw_set_colour(c_white)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(x,y-125,collect)
	draw_set_halign(0)
	draw_set_valign(0)
}