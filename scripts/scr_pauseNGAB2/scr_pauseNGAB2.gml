function scr_pauseNGAB2()
{
	if !variable_instance_exists(id, "ngab2")
	{
		ngab2 = true
		ngab2_borderpos = [-160, 384, 704, 384, 540]
	}
	
	var accel = active ? 0.05 : 0.2
	ngab2_borderpos[0] = lerp(ngab2_borderpos[0], active ? 0 : -160, accel)
	ngab2_borderpos[1] = lerp(ngab2_borderpos[1], active ? 224 : 384, accel)
	ngab2_borderpos[2] = lerp(ngab2_borderpos[2], active ? 576 : 704, accel)
	ngab2_borderpos[3] = lerp(ngab2_borderpos[3], active ? 224 : 384, accel)
	ngab2_borderpos[4] = lerp(ngab2_borderpos[4], active ? 0 : 540, accel)
	
	if active
	{
	    draw_set_color(c_white)
	    draw_set_alpha(1)
		gpu_set_blendenable(false)
		draw_sprite(screenSprite, 0, 0, 0)
		gpu_set_blendenable(true)
		draw_sprite(screenSprite2, 0, 0, 0)
	    draw_sprite(spr_hudNGAB2_pauseGradient, 0, 0, ngab2_borderpos[4])
	    //update_snooze();
		
		var _len = array_length(options)
	    if _len > 0
	    {
	        var yy = 270 - 48 * (_len - 2)
	        draw_set_font(global.font_hudNGAB2_big)
			draw_set_halign(1)
	        for (var i = 0; i < _len; i++)
	        {
				draw_set_colour(selected == i ? c_white : c_grey)
	            with options[i]
	                draw_text(480, yy, lang_get_phrase(option))
				yy += 48
	        }
			draw_set_colour(c_white)
			draw_set_halign(0)
		}
	}
	draw_set_colour(c_white)
	draw_sprite(spr_hudNGAB2_pauseBorder, 0, ngab2_borderpos[0] + wave(-2, 2, 4, 0), ngab2_borderpos[1] + wave(-2, 2, 8, 0));
	draw_sprite(spr_hudNGAB2_pauseBorder, 1, ngab2_borderpos[2] + wave(-2, 2, 4, 60), ngab2_borderpos[3] + wave(-2, 2, 8, 60));
}