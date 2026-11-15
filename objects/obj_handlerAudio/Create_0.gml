fadee = 1
unfoxusvol = 0

fmod_studio_system_create()
fmod_studio_system_init(512, FMOD_STUDIO_INIT.LIVEUPDATE, FMOD_INIT.NORMAL)

fmod_main_system = fmod_studio_system_get_core_system()
banks = ["Master.bank", "Master.strings.bank", "Music.bank", "Sfx.bank"]
for (var i = 0; i < array_length(banks); i++)
    fmod_studio_system_load_bank_file("gameData/fmodBanks/" + banks[i], FMOD_STUDIO_LOAD_BANK.NORMAL)