if !gone && !instance_exists(metal)
{
	gone = true
	event_user(0)
}
if gone
{
	active = obj_player.x > 3348 && !instance_exists(metal)
	activeLrp = lerp(activeLrp, active*clamp((obj_player.x-3348)/1140,0,1), 0.075)
	audio_sound_pitch(global.music, 1-activeLrp*0.4)
	var lay_id = layer_get_id("Backgrounds_still1")
	var back_id = layer_background_get_id(lay_id)
	layer_background_blend(back_id, merge_colour(c_white, c_black, activeLrp*0.9))
}