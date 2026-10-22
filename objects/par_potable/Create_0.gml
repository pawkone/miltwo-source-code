state = states.normal;
og_x = x;
og_y = y;
event_inherited();
spr_idle = spr_potablebean_idle;
spr_walk = spr_potablebean_move;
spr_panicidle = spr_potablebean_idlepanic;
spr_intro = spr_potablebean_intro;
spr_taunt = spr_potablebean_taunt;
tauntInst = -4;
sprite_index = spr_intro;
depth = 15;

//intro effect?
create_particleStatic(spr_parryeffect,x,y,1,depth+1)
create_particleStatic(spr_kungfueffect,x,y,1,depth+1)
repeat 8
{
	with create_particleStatic(choose(spr_supertaunteffect1, spr_supertaunteffect2, spr_supertaunteffect3, spr_supertaunteffect4), x + irandom_range(-50, 50), y + irandom_range(50, -50), 1, depth+2)
	{
		image_speed = random_range(0.1,0.4)
		hsp = random_range(-8,8)
		vsp = random_range(-8,8)
	}
}
repeat 4
{
	with create_particleStatic(choose(spr_supertaunteffect1, spr_supertaunteffect2, spr_supertaunteffect3, spr_supertaunteffect4), x + irandom_range(-50, 50), y + irandom_range(50, -50), 1, -5)
	{
		image_speed = random_range(0.1,0.4)
		hsp = random_range(-8,8)
		vsp = random_range(-8,8)
	}
}