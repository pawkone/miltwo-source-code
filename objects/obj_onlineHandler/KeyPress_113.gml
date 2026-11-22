
var _found = -4
with obj_onlineMenu
{
	if on
	{
		on = !on
		_found = true
	}
}
if !_found
{
	with instance_create(-100,-100,obj_onlineMenu)
		on = true
}