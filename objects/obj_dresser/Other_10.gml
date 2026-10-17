if !saved
{
	saved = true
	xdata_open(global.saveFile)
	if xdata_read("Modded", "c_pal", -4) != obj_player.palIndex
	{
		xdata_write("Modded", "c_pal", obj_player.palIndex)
		obj_savesystem.saveiconTimer = 60
	}
	xdata_close()
}