fadee = 1
unfoxusvol = 0

fmod_studio_system_create()
fmod_studio_system_init(512, FMOD_STUDIO_INIT.LIVEUPDATE, FMOD_INIT.NORMAL)
fmod_studio_system_get_core_system()

var _fn = file_find_first("gameData/audio/*.bank", fa_none)
while _fn != ""
{
	fmod_studio_system_load_bank_file("gameData/audio/" + _fn, FMOD_STUDIO_LOAD_BANK.NORMAL)
    _fn = file_find_next()
}
file_find_close()