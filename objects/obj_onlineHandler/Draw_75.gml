if array_length(notifs) > 0
{
	draw_set_font(-1)
	draw_set_halign(0)
	var _y = 16
    for (var i = array_length(notifs) - 1; i >= 0; i--)
    {
		notifs[i][1]--
        if notifs[i][1] <= 1
			array_delete(notifs, i, 1)
		else
		{
			_y += 16
			draw_set_alpha(clamp((notifs[i][1]*notifs[i][1]*notifs[i][1]) / 20000,0,1))
			draw_set_colour(c_black)
			draw_rectangle(13,540 - _y - 3,19+string_width(notifs[i][0]),540 - _y + 3 +string_height(notifs[i][0]),false)
		}
    }
	var _y = 16
    for (var i = array_length(notifs) - 1; i >= 0; i--)
    {
        if notifs[i][1] > 1
		{
			_y += 16
			draw_set_alpha(clamp((notifs[i][1]*notifs[i][1]*notifs[i][1]) / 20000,0,1))
			draw_set_colour(notifs[i][2])
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
	draw_set_alpha(1)
	var _y = 18
	for (var i = 0; i < array_length(_arr); i++)
	{
		var _c = c_white, _hash = 0
		for (var i = 1; i <= string_length(_arr[i][1]); i++)
			_hash = (_hash * 31 + ord(string_char_at(_arr[i][1], i))) mod 16777216
		_c = make_color_hsv(_hash mod 256, 60 + (floor(_hash / 256) mod 63), 255)
		draw_set_colour(_c)
		draw_text(16,_y,_arr[i][1])
		_y += 16
	}
	draw_set_colour(c_white)
}