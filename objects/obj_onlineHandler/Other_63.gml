if ds_map_find_value(async_load, "status")
{
	var _clean = "", _str = ds_map_find_value(async_load, "result")
	_str = string_copy(_str, 1, 24)
	_str = string_lower(_str)
	for (var i = 1; i <= string_length(_str); i++)
	{
		var _char = string_char_at(_str, i)
		if (_char >= "a" && _char <= "z") || (_char >= "0" && _char <= "9") || _char == "_"
			_clean += _char
	}
	if _clean != ""
	{
		global.username = _clean
		self.create_notifAsyncClientSide("[Only you can see this] Your new username is set!")
	}
	else
		self.create_notifAsyncClientSide("[Only you can see this] Your username is not able to be set to that...")
}