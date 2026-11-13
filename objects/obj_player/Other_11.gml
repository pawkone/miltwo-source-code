var _arr = [
	obj_destroyable_donut1, obj_destroyable_donut2,
	obj_destroyable1, obj_destroyable2,
	obj_collect_escape, obj_bigcollect_escape,
]
for (var i = 0; i < array_length(_arr); i++)
{
	with _arr[i]
		sprite_index = sprite_getera(sprite_index)
}