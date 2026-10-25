var s = 1 / 60; //gamespeed dependent is more accurate
if (global.level != -4 && !obj_pause.active && !instance_exists(obj_rank))
    global.level_timer += s;
