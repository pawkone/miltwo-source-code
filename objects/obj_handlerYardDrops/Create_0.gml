layer_set_visible("Effects_2", true)
var layer_fx = layer_get_fx("Effect_1")
if layer_fx != -1 && fx_get_name(layer_fx) == "_filter_tintfilter"
	fx_set_parameter(layer_fx, "g_TintCol", [1, 0.5, 0.6, 0.9])
rain = layer_exists("Backgrounds_rain")
if rain
{
	layer_set_visible("Backgrounds_rain", false)
	repeat 350
	{
		with instance_create(0,0,obj_yardDrop)
			y = irandom(room_height)
	}
}