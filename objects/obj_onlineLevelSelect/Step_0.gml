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

selectedWorld = clamp(selectedWorld, 0, array_length(global.levels_worldNames) - 1);
potableIndex += 0.35;

if (mky_jump2)
{
    var _levelDeets = global.levels_arr[selectedWorld][selectedLevel];
    script_execute(selectfunc, _levelDeets[0], _levelDeets[1])
	instance_destroy()
}
