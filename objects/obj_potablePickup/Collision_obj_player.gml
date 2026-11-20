if potableIndex > -1 && potableIndex < 5
	global.toppins[potableIndex] = true
instance_destroy()

global.collect += 1000;
global.combo.timer = 60;
create_smalltext(1000);
with obj_handlerGameUI tv_anim(sprites.happy, 180);
with (obj_player)
{
    if character == chars.soda || (irandom(100) <= 25)
		plrsnds_play(sfx.voice_laugh,x,y);
}

var _t = global.toppins[0]+global.toppins[1]+global.toppins[2]+global.toppins[3]+global.toppins[4]
if _t >= 5
	scr_transfotip(lang_get_phrase("tip_get_potablesall"))
else
	scr_transfotip(string(lang_get_phrase("tip_get_potable" + (_t > 1 ? "s" : "")), _t))

if instance_exists(obj_player) && obj_player.character == chars.milton
{
	plrsnds_play(sfx_playerT_toppinget,x,y)
	with obj_player
		FMODevent_oneshot("event:/Sfx/Player/punch", x, y)
	FMODevent_oneshot("event:/Sfx/General/Enemy/dart", x, y)
	create_particleStatic(spr_miltonEffect,(obj_player.x+x+image_xscale*48)/2, (obj_player.y+y+image_yscale*32)/2, 1, depth+1);
	create_particleStatic(spr_parryeffect,x+image_xscale*48, y+image_yscale*32, 1, depth+1)
	repeat 4
	{
		with create_particleStatic(choose(spr_supertaunteffect1, spr_supertaunteffect2, spr_supertaunteffect3, spr_supertaunteffect4), x+image_xscale*48 + irandom_range(24, -24), y+image_yscale*32 + irandom_range(16, -16), 1, depth+1)
		{
			image_speed = random_range(0.1,0.4)
			hsp = random_range(-8,8)
			vsp = random_range(-8,8)
		}
	}
	with (instance_create(x, y, obj_baddiedead))
	{
		hsp = obj_player.xscale*max(2,abs(obj_player.hsp))*1.5
	    sprite_index = spr_juiceboxcage_dead;
	    image_speed = 0;
	}
	shake_camera(max(2,abs(obj_player.hsp)), 20)
}
else
{
	FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y);
	var _s = sprite_getera(spr_juiceboxcage_debri)
	var _sn = sprite_get_number(_s)
	repeat (4)
	    create_particleDebri(_s, irandom_range(0, _sn), x, y, 1);
}
ds_list_add(global.saveroom, id);