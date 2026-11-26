global.escapeActive = false
with obj_player
{
	state = -4
	hsp = 0
	vsp = 0
	x = -200
	y = -200
}
with obj_handlerCamera
{
	state = -4
	camera.zoom = 1
	camera.x = 480
	camera.y = 270
}
if !ready
{
	if keyboard_check_pressed(vk_anykey) && !(keyboard_lastkey == vk_escape || keyboard_lastkey == vk_enter || keyboard_lastkey == vk_backspace)
	{
		keys[select] = keyboard_lastkey
		ready = true
	}
}
else
{
	if keyboard_check_pressed(vk_enter)
	{
		select++
		ready = false
		if select > 3
		{
			with instance_create_depth(0,0,-100,obj_fnf)
				keys = other.keys
			instance_destroy()
		}
	}
	else if keyboard_check_pressed(vk_backspace)
		ready = false
}