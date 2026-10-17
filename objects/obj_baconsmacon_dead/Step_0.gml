var dir = point_direction(x, y, obj_player.x, obj_player.y);
var dirx = lengthdir_x(1, dir);
var diry = lengthdir_y(1, dir);
var i = 0;

if animation_end() && sprite_index = spr_baconsmacon_deadlintro
	sprite_index = spr_baconsmacon_deadloop;

if audio_is_playing(sfx)
	audio_sound_gain(sfx,global.SfxVolume);
	
while !in_camera()
{
	x += dirx;
	y += diry;
	i++
	
	if i > 64
		break;
}