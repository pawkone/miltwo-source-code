xdata_open(game_save_id + "notepad.xda")
for (var i = 0; i <= 18; i++)
{
	strings[i] = xdata_read("notepad", string(i), "")
	done[i] = xdata_read("notepad", "d" + string(i), false)
}
xdata_close()
select = -1