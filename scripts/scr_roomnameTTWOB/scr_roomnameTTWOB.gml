function scr_roomnameTTWOB_earlystep()
{
	roomname_showbuffer = approach(roomname_showbuffer, 0, 1)
	roomname_textY = (roomname_showbuffer > 0) ? approach(roomname_textY, 540-16, 4) : approach(roomname_textY, 540+32, 0.5)
	if roomname_textY < 540+16 && roomname_text != ""
	{
		draw_set_font(global.smallfont)
		draw_set_halign(0)
		draw_set_valign(2)
		draw_text(16, roomname_textY, roomname_text)
		draw_set_valign(0)
	}
}
function scr_roomnameTTWOB_roomstart()
{
	roomname_textY = 540+32
	roomname_showbuffer = 180
}