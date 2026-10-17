if (ds_map_find_value(async_load, "status"))
{
    if (ds_map_find_value(async_load, "result") != "")
		create_notifAsync(global.username + " : " + string_copy(ds_map_find_value(async_load, "result"),0,48))
}