draw_set_halign(fa_center);
draw_set_font(global.smallnumberfnt);
draw_set_alpha(image_alpha);
if flash
	gpu_set_fog(true,16580604,0,1)
draw_text_transformed(x, y, text, image_xscale, image_yscale, 0);
if flash
	gpu_set_fog(false,c_white,0,1)
draw_set_alpha(1);
