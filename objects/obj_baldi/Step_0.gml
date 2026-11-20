if global.level == -4 || room == timesup_room
{
	alarm[0] = 60
	image_xscale = 0.65
	image_yscale = 0.65
	sprite_index = spr_baldi_intro
	image_speed = 0
	mad = false
	madtimer = 0
	madtimermax = 65
	exit
}
else
	visible = true
if animation_end()
	image_speed = 0
direction = point_direction(x,y,obj_player.x,obj_player.y)
if mad
{
	sprite_index = spr_baldi_slap
	madtimer--
	var _max = 4
	if madtimer <= _max
	{
		if madtimer == _max
		{
			audio_play_sound(sfx_baldi_slap, 1, false)
			image_speed = 33/60
			image_index = 0
		}
		speed = 24
		if madtimer <= 0
		{
			madtimer = floor(madtimermax)
			madtimermax = max(madtimermax-0.3, 10)
		}
	}
	else
		speed = 0
	alarm[0] = -1
	if image_alpha < 1
		image_alpha += 0.01
	else if place_meeting(x,y,obj_player)
		room_goto(timesup_room)
}
else
{
	speed = distance_to_object(obj_player)/18
	if image_alpha < 1
		image_alpha += 0.01
}