if (obj_player.door == "DOODLE" || instance_exists(obj_secretManager))
{
	obj_player.state = -4;
    obj_player.x = x;
    obj_player.y = y;
	with obj_player
		sprite_index = sprites.groundpound;
    cutscene = true;
    sprite_index = spr_dudle_open;
    image_index = 0;
    FMODevent_oneshot("event:/Sfx/General/Level/Progression/exitpage", x, y);
}