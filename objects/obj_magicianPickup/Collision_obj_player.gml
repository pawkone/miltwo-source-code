with obj_handlerGameUI tv_anim(sprites.happy, 180);
global.combo.timer = 60;

with (obj_player)
{
	if character == chars.soda || (irandom(100) <= 25)
		plrsnds_play(sfx.voice_laugh,x,y);
}

instance_create(x, y, obj_magician);
scr_transfotip(lang_get_phrase("tip_get_magician"))
global.magician = true;
FMODevent_oneshot("event:/Sfx/General/Level/Gerome/collect", x, y);
instance_destroy();
ds_list_add(global.saveroom, id);
