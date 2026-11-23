function scr_pauseNGAB2()
{
	if !variable_instance_exists(id, "ngab2")
	{
		ngab2 = true
		ngab2_borderpos = 0
	}
	ngab2_borderpos = lerp(ngab2_borderpos, active, 0.2-(active*0.15))
	if active
	{
		draw_set_color(c_white)
		draw_set_alpha(1)
		gpu_set_blendenable(false)
		draw_sprite(screenSprite, 0, 0, 0)
		gpu_set_blendenable(true)
		draw_sprite(screenSprite2, 0, 0, 0)
		draw_sprite(spr_hudNGAB2_pauseGradient, 0, 0, 540*(1-ngab2_borderpos))
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
	if ngab2_borderpos > 0.05
	{
		draw_sprite(spr_hudNGAB2_pauseBorder, 0, -160*(1-ngab2_borderpos) + wave(-2, 2, 4, 0), lerp(384, 224, ngab2_borderpos) + wave(-2, 2, 8, 0))
		draw_sprite(spr_hudNGAB2_pauseBorder, 1, lerp(704, 576, ngab2_borderpos) + wave(-2, 2, 4, 60), lerp(384, 224, ngab2_borderpos) + wave(-2, 2, 8, 60))
	}
}