gpu_set_blendmode(bm_normal)
while surface_get_target() != -1
	surface_reset_target()

var _drawgame = true

if partysover
{
	_drawgame = false
	draw_set_alpha(1)
	draw_rectangle_colour(0,0,960,540,0,0,0,0,false)
	if partysovertime > 3
	{
		draw_set_font(font_console)
		draw_set_halign(0)
		draw_set_valign(0)
		draw_set_colour(c_white)
		var _str = "PARTYSOVER"
		for (var i = 0; i < min(string_length(_str), partysovertime-3); i++)
			draw_text_transformed(200+(i*64)+random_range(-10,10),400+random_range(-10,10),string_char_at(_str, i+1),7,4,0)
	}
}

shader_set_uniform_f(shader_get_uniform(shd_gamerender, "hsv_mult"), hueonlrp)
shader_set_uniform_f(shader_get_uniform(shd_gamerender, "lap3_mult"), lap3_mult)
if hueonlrp > 0
{
	shader_set_uniform_f(shader_get_uniform(shd_gamerender, "hsv_hue"), (huelrp+1 mod 2)-1)
	shader_set_uniform_f(shader_get_uniform(shd_gamerender, "hsv_sat"), huevsp*-17)
	shader_set_uniform_f(shader_get_uniform(shd_gamerender, "hsv_val"), hueval)
}
if lap3_mult > 0
{
	shader_set_uniform_i(shader_get_uniform(shd_gamerender, "lap3_timer"), current_time mod 8000)
	shader_set_uniform_f(shader_get_uniform(shd_gamerender, "lap3_offsetx"), camera_get_view_x(view_camera[0]))
	shader_set_uniform_f(shader_get_uniform(shd_gamerender, "lap3_offsety"), camera_get_view_y(view_camera[0]))
}
if _drawgame
{
	gpu_set_blendmode_ext_sepalpha(bm_src_alpha, bm_inv_src_alpha, bm_one, bm_inv_src_alpha)
	gpu_set_blendenable(false)
	if !(instance_exists(obj_pause) && obj_pause.active)
	{
		if surface_exists(application_surface)
		{
			if room != rm_loading
				draw_surface_ext(application_surface, (global.modifiers.flipped ? 960 : 0 + (1-size)*480), (1-size)*270, (global.modifiers.flipped ? -1 : 1) * size, size, 0, c_white, 1)
			else
				draw_surface_ext(application_surface, (1-size)*480, (1-size)*270, size, size, 0, c_white, 1)
		}
	}
	gpu_set_blendenable(true)
	if surface_exists(gameSurface)
		draw_surface_ext(gameSurface, (1-size)*480, (1-size)*270, size, size, 0, c_white, 1)
	gpu_set_blendmode_default()
}
shader_reset()

if (global.debug)
{
    var devWindow = []
    array_push(devWindow, "Oh Mil.. Two?")
	array_push(devWindow, "")
    array_push(devWindow, $"ROOM+-#{room_get_name(room)}")
    array_push(devWindow, $"FPS (Game)+-#{floor(fps)}")
    array_push(devWindow, $"FPS (CPU)+-#{floor(fps_real)}")
    array_push(devWindow, $"Build Type+-#{GM_build_type}")
    if (instance_exists(obj_player))
    {
	    array_push(devWindow, $"Player X+-#{obj_player.x}", obj_player.x)
	    array_push(devWindow, $"Player Y+-#{obj_player.y}", obj_player.y)
	    array_push(devWindow, $"Player State+-#{obj_player.state}")
	    array_push(devWindow, $"Player Sprite+-#{sprite_get_name(obj_player.sprite_index)}")
    }
    
    draw_set_font(-1)
    draw_set_halign(fa_left)
    draw_set_alpha(0.25)
    draw_set_colour(c_black)
    var _width = 0
    for (var i = 0; i < array_length(devWindow); i++)
    {
		devWindow[i] = string_split(devWindow[i], "+-#")
		var _widthnew = (array_length(devWindow[i]) > 1 ? (string_width(devWindow[i][1])+128) : string_width(devWindow[i][0]))
        if _widthnew > _width
            _width = _widthnew
    }
    
	
    var _x = 32, _h = string_height("A")*0.8
	var _height = _h*array_length(devWindow)
	var _y = 540 - _height - 32
    draw_roundrect_ext(_x - 16, _y - 16, _x + _width + 16, _y + _height + 16, 16, 16, false)
    draw_set_alpha(0.5)
    draw_set_colour(c_white)
    for (var i = 0; i < array_length(devWindow); i++)
	{
        draw_text(_x, _y + (_h * i), devWindow[i][0])
		if array_length(devWindow[i]) > 1
			draw_text(_x + 128, _y + (_h * i), devWindow[i][1])
	}
}

draw_set_alpha(1)
draw_set_colour(c_white)
