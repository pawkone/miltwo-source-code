function scr_roomnameWSB_step()
{
	roomname_showbuffer = approach(roomname_showbuffer, 0, 1)
	roomname_textY = (roomname_showbuffer > 0) ? approach(roomname_textY, 27, 10) : approach(roomname_textY, -64, 2)
	if roomname_text != ""
	{
		var _xx = (960 / 2) + wave(-3, 3, 3, 0)
		draw_sprite(spr_roomname, 0, _xx, roomname_textY)
		draw_set_font(global.smallfont)
		draw_set_halign(fa_center)
		draw_text(_xx + 5, roomname_textY + 12, string_lower(roomname_text))
	}
}
function scr_roomnameWSB_roomstart()
{
	if !variable_instance_exists(id, "roomname_textY")
	{
		roomname_textY = -128
		roomname_showbuffer = 0
		roomname_text = ""
	}
	roomname_showbuffer = 180
}