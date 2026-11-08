with (obj_player)
{
	instance_destroy(other);
	state = scr_player_normal;
	obj_camera.state = "normal";
	sprite_index = sprites.idle;
	image_index = 0;
}