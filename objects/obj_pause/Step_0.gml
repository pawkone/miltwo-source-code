if instance_exists(obj_option)
	exit

activelrp = lerp(activelrp, active, 0.1)
activelrp = approach(activelrp, active, 0.001)

var _nopauseRooms = room == timesup_room || room == Mainmenu || instance_exists(obj_fadeout) || instance_exists(obj_rank) || instance_exists(obj_technicaldifficulty) || instance_exists(obj_titlecard) || obj_shell.isOpen;

if (!active && pky_start2 && !_nopauseRooms && buffer == 0)
{
    doPause();
}
else if (active && !instance_exists(obj_option) && buffer == 0)
{
    graphBack.alpha = approach(graphBack.alpha, 0.55, 0.01);
    var move = mky_down2 - mky_up2;
    
    if (move != 0)
        selected += move;
    
    selected = clamp(selected, 0, array_length(options) - 1);
    
    if (mky_slap2 || pky_start2)
        doUnpause();
    
    if (mky_jump2)
        options[selected].func();
    
    var _pos = fmod_studio_event_instance_get_timeline_position(pauseMusic) * 0.01;
}

buffer = approach(buffer, 0, 1);
