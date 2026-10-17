xdata_open(game_save_id + "notepad.xda")
for (var i = 0; i <= 18; i++)
{
	xdata_write("notepad", string(i), strings[i])
	xdata_write("notepad", "d"+string(i), done[i])
}
xdata_close()
if instance_exists(obj_player)
	obj_player.state = states.normal