var _obj = [
	obj_solid, obj_slope, obj_platform, obj_destroyable_secret1,
	obj_destroyable_secret2, obj_secretmetalblock, obj_ladder
]
for (var i = 0; i < array_length(_obj); i++)
{
    with _obj[i]
    {
        if object_index == _obj[i]
            visible = global.showcollisions
    }
}