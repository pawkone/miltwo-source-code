global.font_hudTTWOB_score = font_add_sprite_ext(font_hudTTWOB_score, "0123456789", 1, 0)
function scr_hudTTWOB_init()
{
}
function scr_hudTTWOB_step()
{
}
function scr_hudTTWOB_draw()
{
	var _xx = 163, _yy = 88
	draw_sprite(spr_hudTTWOB_score,0,_xx,_yy)
	draw_set_font(global.font_hudTTWOB_score)
	draw_set_halign(1)
	draw_set_valign(1)
	draw_text(_xx+13,_yy+13,global.collect)
	draw_set_halign(0)
	draw_set_valign(0)
	
	var rankindex = 0;
	if (scr_Prank())
	    rankindex = 5;
	else if (global.collect >= global.Srank)
	    rankindex = 4;
	else if (global.collect >= global.Arank)
	    rankindex = 3;
	else if (global.collect >= global.Brank)
	    rankindex = 2;
	else if (global.collect >= global.Crank)
	    rankindex = 1;
	draw_sprite_ext(spr_hudTTWOB_rank, rankindex, _xx + 128, _yy, 1, 1, 0, c_white, 1)
	
	draw_sprite_ext(spr_tv_bgB3, 0, 823, 73, 1, 1, 0, tvbg_backindex, 1)
	draw_sprite_ext(spr_tv_idleB3, -1, 823, 73, 1, 1, 0, c_white, 1)
}
function scr_hudTTWOB_clean()
{
}