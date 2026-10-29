global.music = -4
global.music_old = -4
global.music_mult = -4
global.music_multold = -4
global.music_fade = 1
function scr_soundeffect(_sfx, _pitch = 1, _loop = false)
{
	if premode return -4
	var _id = audio_play_sound(_sfx, 1, _loop)
	audio_sound_pitch(_id, _pitch)
	return _id
}
function scr_music(_sfx, fadein = false, _savepos = false)
{
	if premode return -4
	global.music_fade = 1
	var _pos = 0
	if fadein
	{
		global.music_fade = 0
		if audio_is_playing(global.music_old)
			audio_stop_sound(global.music_old)
		if audio_is_playing(global.music)
			global.music_old = global.music
		else
			global.music_old = -4
		global.music_multold = global.music_mult
		_pos = _savepos ? audio_sound_get_track_position(global.music) : 0
		global.music = -4
	}
	else if audio_is_playing(global.music)
	{
		_pos = _savepos ? audio_sound_get_track_position(global.music) : 0
		audio_stop_sound(global.music)
	}
	if audio_exists(_sfx)
	{
		global.music_mult = audio_sound_get_gain(_sfx)
		global.music = audio_play_sound(_sfx, 10, 1, 0, _pos, 1)
	}
	else
	{
		global.music_mult = 1
		global.music = -4
	}
	return global.music
}