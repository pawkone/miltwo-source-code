var _rmname = room_get_name(room)
if string_count("_secret" ,_rmname) > 0
	instance_create(0,0,obj_secretManager)

var _rmyard = string_starts_with(_rmname, "yard_")
improvedyard_on = global.modded_betterwaybackyard && _rmyard
improvedyard_rain = false
if improvedyard_on
{
	var layer_fx = layer_get_fx("Effect_1")
	if layer_fx != -1 && fx_get_name(layer_fx) == "_filter_tintfilter"
		fx_set_parameter(layer_fx, "g_TintCol", [1, 0.5, 0.6, 0.9])
	improvedyard_rain = layer_exists("Backgrounds_rain")
	if improvedyard_rain
	{
		layer_set_visible("Backgrounds_rain", false)
		repeat 350
		{
			with instance_create(0,0,obj_yardDrop)
				y = irandom(room_height)
		}
	}
}
else if _rmyard
	layer_set_visible("Effects_2", false)