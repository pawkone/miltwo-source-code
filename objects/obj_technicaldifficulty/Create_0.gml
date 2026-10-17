depth = obj_hud.depth - 25;
FMODevent_oneshot("event:/Sfx/UI/Oops!/transition");
with obj_player
	plrsnds_play(sfx.slam, x, y);
staticIndex = 0;
showStatic = true;
showTechnical = false;
technicalIndex = irandom_range(0, 2);
langasset = lang_get_asset("spr_pleasestandbyBackground")