alpha = 1

var lay = layer_get_id("Tiles_secret")
if layer_exists(lay)
{
	secret_tile_start = function()
	{
		if event_type == ev_draw && event_number == 0
		{
			shader_sset(shd_secrettile)
			shader_set_uniform_f(shader_get_uniform(shd_secrettile, "alpha"), alpha)
		}
	};
	secret_tile_end = function()
	{
	    if event_type == ev_draw && event_number == 0
			shader_reset()
	}
	layer_script_begin(lay, secret_tile_start)
	layer_script_end(lay, secret_tile_end)
}