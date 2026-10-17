if array_length(notifs) > 0
{
	draw_set_font(global.smallfont)
	draw_set_halign(0)
	draw_set_colour(c_yellow)
	var _y = 0
    for (var i = array_length(notifs) - 1; i >= 0; i--)
    {
		notifs[i][1]--
        if notifs[i][1] <= 1
			array_delete(notifs, i, 1)
		else
		{
			draw_set_alpha(clamp((notifs[i][1]*notifs[i][1]*notifs[i][1]) / 20000,0,1))
			_y += 32
	        draw_text(16, 540 - _y, notifs[i][0])
		}
    }
	draw_set_colour(c_white)
	draw_set_alpha(1)
}
if keyboard_check(vk_tab)
{
	var _arr = [[-4, global.username]]
	var sockets = ds_map_values_to_array(plrsconnected)
	array_copy(_arr,1,sockets,0,array_length(sockets))
	
	draw_set_alpha(0.5)
	draw_set_colour(c_black)
	draw_rectangle(8, 8, 480, 28+(array_length(_arr)*16), false)
	draw_set_font(global.smallfont)
	draw_set_halign(0)
	draw_set_valign(0)
	draw_set_colour(c_white)
	draw_set_alpha(1)
	var _y = 18
	for (var i = 0; i < array_length(_arr); i++)
	{
		draw_text(16,_y,_arr[i][1])
		_y += 16
	}
}