if is_string(titlecardinfo[3])
	snd = FMODcreate_event(titlecardinfo[3]);
else
{
	snd = scr_music(titlecardinfo[3]);
	audio_sound_loop(snd, false)
}
titlecardSprite = titlecardinfo[0];
titlecardName.sprite = titlecardinfo[1];