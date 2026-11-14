function scr_roomnameWSB_step()
{
	roomname_showbuffer = approach(roomname_showbuffer, 0, 1)
	if instance_exists(obj_fadeout) && obj_fadeout.fadein
		roomname_textY = approach(roomname_textY, -64, 8)
	else
		roomname_textY = (roomname_showbuffer > 0) ? approach(roomname_textY, 27, 10) : approach(roomname_textY, -64, 2)
	if roomname_textY > -64 &&roomname_text != ""
	{
		var _xx = (960 / 2) + wave(-3, 3, 3, 0)
		draw_sprite(spr_roomname, 0, _xx, roomname_textY)
		draw_set_font(global.smallfont)
		draw_set_halign(fa_center)
		draw_text(_xx + 5, roomname_textY + 12, roomname_text)
	}
}
function scr_roomnameWSB_roomstart()
{
	roomname_textY = -128
	roomname_showbuffer = 180
}