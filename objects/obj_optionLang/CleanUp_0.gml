for (var i = 0; i < array_length(sprs); i++)
{
	var _q = sprs[i]
	for (var j = 0; j < array_length(_q); j++)
	{
		if sprite_exists(_q[j])
			sprite_delete(_q[j])
	}
}