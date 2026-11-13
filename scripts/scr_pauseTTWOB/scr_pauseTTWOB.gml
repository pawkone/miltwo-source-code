function scr_pauseTTWOB()
{
	if !variable_instance_exists(id, "ttwob")
	{
		ttwob = true
		ttwob_buf = 0
		ttwob_hsp = 0
		ttwob_cursor_x = 1080
		ttwob_cursor_y = -128
		ttwob_circless = []
		ttwob_activeOld = false
		ttwob_pausealpha = array_create(array_length(options), 0)
		ttwob_pausealpha[selected] = 1
	}
	
	if (active)
	{
	    shader_set(shd_waveTTWOB);
		if ttwob_buf < 0
			ttwob_buf = lerp(ttwob_buf, -1, 0.025)
		else
			ttwob_buf = lerp(ttwob_buf, -0.35, 0.045)
		waveTime -= ttwob_buf
	    shader_set_uniform_f(timeUniform, waveTime);
	    shader_set_uniform_f(frequencyUniform, (1+max(0,ttwob_buf/11))*0.01);
	    shader_set_uniform_f(amplitudeUniform, 0.008);
		gpu_set_blendenable(false)
	    draw_sprite(screenSprite, 0, 0, 0);
		gpu_set_blendenable(true)
		draw_sprite(screenSprite2, 0, 0, 0);
	    shader_reset();
	    draw_set_alpha((graphBack.alpha/0.55)*0.5);
	    draw_set_colour(c_black);
	    draw_rectangle(0, 0, 960, 540, false);
	    draw_set_colour(c_white);
	    draw_set_alpha(1);
	}
	
	if active && !ttwob_activeOld
	{
		waveTime = 0
		ttwob_buf = 11
		ttwob_circless = []
		for (var i = 0; i < 32; i++)
			array_push(ttwob_circless, [860-i*4, random(540), random_range(60, 100)/100])
		ttwob_hsp = -1
		x = 360
	}
	if ttwob_activeOld != active
		ttwob_activeOld = active
	
	if active
	{
		x = approach(x, 0, 1)
		x = lerp(x, 0, 0.06)
		ttwob_hsp = approach(ttwob_hsp, -4, 0.1)
		array_push(ttwob_circless, [960, random(540), random_range(60, 100)/100])
	}
	else
	{
		if ttwob_hsp == 0 || x == 960
		{
			x = 360
			ttwob_hsp = 0
			ttwob_circless = []
		}
		else
		{
			for (var i = 0; i < 7; i++)
				array_push(ttwob_circless, [960-i*64, random(540), random_range(60, 100)/100])
			ttwob_hsp = -128
			x = approach(x, 960, 48)
		}
	}
	
	draw_rectangle(x+835-2, 0, 960, 540, false)
	for (var i = array_length(ttwob_circless)-1; i >= 0; i--)
	{
		var _q = ttwob_circless[i]
		ttwob_circless[i][0] += _q[2]*ttwob_hsp
		var _s = 110+(_q[0]-960)/5
		_s += 2
		if _s < 0
		{
			array_delete(ttwob_circless, i, 1)
			continue
		}
		draw_circle(x+_q[0], _q[1], _s, false)
	}
	draw_set_colour(c_black)
	draw_rectangle(x+835, 0, 960, 540, false)
	for (var i = array_length(ttwob_circless)-1; i >= 0; i--)
	{
		var _q = ttwob_circless[i]
		var _s = 110+(_q[0]-960)/5
		if _s > 0
			draw_circle(x+_q[0], _q[1], _s, false)
	}
	if active
	{
		draw_set_colour(c_white)

		draw_set_font(global.bigfont)
		draw_set_valign(0)
		draw_set_halign(1)
		var _offy = 270+(array_length(options)/2)*-48
		for (var i = 0; i < array_length(options); i++)
		{
			var _txt = lang_get_phrase(options[i].option)
			ttwob_pausealpha[i] = approach(ttwob_pausealpha[i], selected == i, 0.1)
			draw_set_alpha(1)
			draw_set_colour(selected == i ? c_white : c_grey)
			draw_text(736, _offy+i*48, _txt)
			draw_set_alpha(ttwob_pausealpha[i])
			draw_sprite(spr_pauseicons, i, random_range(-1,1)+736-(string_width(_txt)/2 + 50), random_range(-1,1)+_offy+i*48)
		}
		draw_set_alpha(1)
		draw_set_halign(0)
		draw_set_colour(c_white)

		ttwob_cursor_x = lerp(ttwob_cursor_x, 736+string_width(lang_get_phrase(options[selected].option))/2 + 20, 0.075)
		ttwob_cursor_y = lerp(ttwob_cursor_y, _offy+selected*48, 0.1)
	}
	else
	{
		ttwob_cursor_x = lerp(ttwob_cursor_x, 1080, 0.075)
		ttwob_cursor_y = lerp(ttwob_cursor_y, -128, 0.1)
	}
	draw_sprite(spr_uparrowog, 0, ttwob_cursor_x, ttwob_cursor_y)
}