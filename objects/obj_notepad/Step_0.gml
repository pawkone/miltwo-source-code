var _oldselect = select
select += keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up)
select = clamp(select, 0, array_length(strings)-1)
if _oldselect != select
	keyboard_string = strings[select]
strings[select] = keyboard_string
if keyboard_check_pressed(vk_enter)
	done[select] = !done[select]
if instance_exists(obj_player)
{
	obj_player.state = -1
	obj_player.hsp = 0
	obj_player.vsp = 0
}