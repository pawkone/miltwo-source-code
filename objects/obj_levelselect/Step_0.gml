obj_player.state = -4;
obj_player.x = -100;
obj_player.y = -100;

if (mky_down2)
    selectedLevel++;
else if (mky_up2)
    selectedLevel--;

selectedLevel = clamp(selectedLevel, 0, array_length(global.levels_arr[selectedWorld]) - 1);

if (mky_right2)
{
    selectedLevel = 0;
    selectedWorld++;
}
else if (-mky_left2)
{
    selectedLevel = 0;
    selectedWorld--;
}

selectedWorld = clamp(selectedWorld, 0, array_length(global.levels_arr) - 1);
potableIndex += 0.35;

if (mky_jump2)
{
    var _levelDeets = global.levels_arr[selectedWorld][selectedLevel];
    
    with (obj_player)
    {
        generalReset();
        targetRoom = _levelDeets[0];
        door = "A";
        global.level = _levelDeets[1];
        backtohubRoom = room;
        backtohubX = x;
        backtohubY = y;
        global.resetRoom = _levelDeets[0];
        scr_fadeout()
    }
}
