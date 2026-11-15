var s = 1 / 60; //gamespeed dependent is more accurate
if (global.level != -4 && !obj_handlerPause.active && !instance_exists(obj_rank))
    global.level_timer += 1 / 60;
