if is_callable(hud_scr_step)
	hud_scr_step()
if global.level != -4 && !instance_exists(obj_rank)
    global.level_timer += 1 / 60