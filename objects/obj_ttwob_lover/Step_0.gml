if !active
{
	scr_collision()
	if grounded
	{
		vsp = -4
		//FMODevent_oneshot("event:/Sfx/General/Level/Doodles/doodlejump", x, y)
	}
	if place_meeting(x, y, obj_player)
	{
		ds_list_add(global.saveroom, id)
		active = true
		alarm[0] = 1
		create_smalltext(string(points), x + 16, y - 200)
		if global.level != "dudles"
			scr_transfotip(string(lang_get_phrase("tip_get_ttwob_secret"), global.secretCount))
		//FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y)
		//FMODevent_oneshot("event:/Sfx/General/Level/Doodles/doodleget", x, y)
		with obj_handlerGameUI tv_anim(sprites.happy, 180)
		with obj_player
		{
		    if character == chars.soda || (irandom(100) <= 25)
				plrsnds_play(sfx.voice_laugh,x,y)
		}
	}
}
image_index = active ? 2 : (((current_time/1000)*3) mod 2)