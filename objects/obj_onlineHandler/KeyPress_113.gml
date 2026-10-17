var _found = -4
with obj_serverMenu
{
	if on
	{
		on = !on
		_found = true
	}
}
if !_found
{
	with instance_create(-100,-100,obj_serverMenu)
		on = true
}