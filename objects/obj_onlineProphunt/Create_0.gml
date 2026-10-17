if instance_number(object_index) > 1 || !global.connected
{
	instance_destroy()
	exit
}
win = 0
obj_shell.whitelist = ["toggle_collisions", "toggle_debug"]