if (global.debug)
{
    var devWindow = []
	array_push(devWindow, game_project_name, date_date_string(GM_build_date))
	array_push(devWindow, GM_runtime_version, GM_runtime_type)
	array_push(devWindow, "", "")
    array_push(devWindow, "Runtime FPS", string(floor(fps)))
    array_push(devWindow, "Processer FPS", string(floor(fps_real)))
	array_push(devWindow, "Inst Count", instance_count)
	array_push(devWindow, "Cur Room", room_get_name(room))
	array_push(devWindow, "", "")
    if (instance_exists(obj_player))
    {
	    array_push(devWindow, "Plr Pos X", string(obj_player.x))
	    array_push(devWindow, "Plr Pos Y", string(obj_player.y))
		array_push(devWindow, "Plr SprIndex", sprite_get_name(obj_player.sprite_index))
		array_push(devWindow, "Plr ImgIndex", string(floor(obj_player.image_index)))
	    array_push(devWindow, "Plr State", script_get_name(obj_player.state))
    }
    
    draw_set_font(-1)
    draw_set_halign(fa_left)
    draw_set_alpha(0.3)
    draw_set_colour(c_black)
    var _width = 0
    for (var i = 0; i < array_length(devWindow); i += 2)
		_width = max(_width,string_width(devWindow[i+1])*0.75+96)
	
    var _x = 16, _h = string_height("A")*0.4
	var _height = _h*array_length(devWindow)
	var _y = 540 - _height - 16
    draw_roundrect_ext(_x - 8, _y - 8, _x + _width + 8, _y + _height + 8, 24, 24, false)
    draw_set_alpha(0.5)
    draw_set_colour(c_white)
	_y -= 2
    for (var i = 0; i < array_length(devWindow); i += 2)
	{
        draw_text_transformed(_x, _y + (_h * i), devWindow[i], 0.75, 1, 0)
		draw_text_transformed(_x + 96, _y + (_h * i), devWindow[i+1], 0.75, 1, 0)
	}
	draw_set_alpha(1)
}