fadee = 1

unfoxusvol = 0
focus = window_has_focus()
alarm[0] = 5

if premode exit

fmod_studio_system_create()
fmod_studio_system_init(1024, FMOD_STUDIO_INIT.LIVEUPDATE, FMOD_INIT.NORMAL)

fmod_main_system = fmod_studio_system_get_core_system()
banks = ["Master.bank", "Master.strings.bank", "Music.bank", "Sfx.bank"]
for (var i = 0; i < array_length(banks); i++)
{
	if !file_exists("gameData/fmodBanks/" + banks[i])
	{
		show_message("fmod bank is missing or invaild")
		game_end()
		exit
	}
    fmod_studio_system_load_bank_file("gameData/fmodBanks/" + banks[i], FMOD_STUDIO_LOAD_BANK.NORMAL)
}