if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y);
	if instance_exists(obj_player) && obj_player.character == chars.milton
	{
		with obj_player
		{
			if irandom(100) <= 25
				plrsnds_play(sfx.voice_laugh,x,y)
			FMODevent_oneshot("event:/Sfx/Player/punch", x, y)
		}
		FMODevent_oneshot("event:/Sfx/General/Enemy/dart", x, y)
		create_particleStatic(spr_miltonEffect,(obj_player.x+x+image_xscale*48)/2, (obj_player.y+y+image_yscale*32)/2, 1, depth+1);
		create_particleStatic(spr_parryeffect,x+image_xscale*48, y+image_yscale*32, 1, depth+1)
		repeat 8
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
	        sprite_index = other.sprite_index;
	        image_speed = 0;
	        image_index = other.image_index;
	    }
		shake_camera(max(2,abs(obj_player.hsp)), 20)
		//too much? yeah. do i care? no. is it fucking rad lookin'? HELL YEAH, MILTON RULES!!
	}
	else
	{
	    with (instance_create(x, y, obj_baddiedead))
	    {
	        sprite_index = other.sprite_index;
	        image_speed = 0;
	        image_index = other.image_index;
	    }
	}
}
