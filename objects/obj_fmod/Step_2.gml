if premode exit

var _paused = !instance_exists(obj_pause) || obj_pause.active

fmod_studio_system_set_parameter_by_name("SfxVolume", global.SfxVolume, true);
if (instance_exists(obj_monolith) && !_paused)
	fmod_studio_system_set_parameter_by_name("MusicVolume", (global.MusicVolume * 1) - obj_music.pillar, true);
else
	fmod_studio_system_set_parameter_by_name("MusicVolume", global.MusicVolume, true);
fmod_studio_system_set_parameter_by_name("MasterVolume", global.MasterVolume, true);

unfoxusvol = approach(unfoxusvol, !focus && global.unfocus_mute, 0.05)
fmod_studio_system_set_parameter_by_name("unfocusMute", unfoxusvol, true)
audio_master_gain((1-(unfoxusvol*unfoxusvol)) * (global.MasterVolume*global.MasterVolume) *1.2)
audio_group_set_gain(audioGroupSfx, global.SfxVolume * global.SfxVolume)
audio_group_set_gain(audioGroupMusic, global.MusicVolume * global.MusicVolume)

global.music_fade = approach(global.music_fade, 1, 1/90)
if audio_is_playing(global.music)
	audio_sound_gain(global.music, 1.5 * global.music_mult * global.music_fade, 0)
if audio_is_playing(global.music_old)
{
	audio_sound_gain(global.music_old, 1.5 * global.music_multold * (1-global.music_fade), 0)
	if global.music_fade >= 1
		audio_stop_sound(global.music_old)
}

if instance_exists(obj_player)
	fmod_studio_system_set_parameter_by_name("character", obj_player.character == chars.milton, true)
