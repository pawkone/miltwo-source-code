visible = global.connected
if !global.connected
	on = false
else if !on
{
	if x == -100 && y == -100
		instance_destroy()
	stophostingwarning = false
	select = 4
	if place_meeting(x,y,obj_player) && pky_up2
		on = true
}
else
{
	if instance_exists(obj_onlineLevelSelect) exit
	if stophostingwarning
	{
		if mky_jump2 || mky_slap2
		{
			stophostingwarning = false
			select = 4
		}
		else if mky_taunt2
		{
			global.connected = false
			if global.server == -4 //client
				network_destroy(global.client)
			else
				network_destroy(global.server)
			instance_destroy(obj_onlineHandler)
			instance_destroy(obj_onlinePlayer)
			instance_destroy(obj_onlineTauntEffect)
			instance_destroy(obj_onlineRace)
			instance_destroy(obj_onlineProphunt)
			on = false
		}
		exit
	}
	select += mky_down2-mky_up2
	select = clamp(select, global.server == -4 ? 2 : 0, 4)
	if mky_slap2
		on = false
	else if mky_jump2
	{
		switch select
		{
			case 0:
				with obj_onlineHandler
					event_user(10)
			break
			case 1:
				with obj_onlineHandler
					event_user(11)
			break
			case 2:
				stophostingwarning = true
			break
			case 4:
				on = false
			break
		}
	}
}