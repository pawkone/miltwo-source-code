if instance_exists(obj_player)
{
	var _hud_postfix = hud_postfix
	scr_getera(false)
	
	if _hud_postfix != hud_postfix
	{
		if is_callable(hud_scr_clean)
		{
			var _s = hud_scr_clean
			with obj_hud
				_s()
		}
		event_user(0)
	}
	
	if is_callable(hud_scr_step)
	{
		var _s = hud_scr_step
		with obj_hud
			_s()
	}
}

if instance_exists(obj_option)
	exit

activelrp = lerp(activelrp, active, 0.1)
activelrp = approach(activelrp, active, 0.001)

var _nopauseRooms = room == timesup_room || room == Mainmenu || instance_exists(obj_fadeout) || instance_exists(obj_rank) || instance_exists(obj_technicaldifficulty) || instance_exists(obj_titlecard) || obj_shell.isOpen;

if !active
{
	if instance_exists(obj_player)
		character = obj_player.character;
	if pky_start2 && !_nopauseRooms && buffer == 0
	    doPause();
}
else if (active && !instance_exists(obj_option) && buffer == 0)
{
    graphBack.alpha = approach(graphBack.alpha, 0.55, 0.01);
    var move = mky_down2 - mky_up2;
    
    if (move != 0)
	{
		audio_play_sound(sfx_step, 1, false, 1, 0, random_range(0.95,1.05))
        selected += move;
	}
    
    selected = wrap(selected, 0, array_length(options) - 1);
    
    if (mky_slap2 || pky_start2)
        doUnpause();
    
    if (mky_jump2)
        options[selected].func();
    
    var _pos = fmod_studio_event_instance_get_timeline_position(pauseMusic) * 0.01;
}

buffer = approach(buffer, 0, 1);
