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
	draw_set_alpha(1)
}