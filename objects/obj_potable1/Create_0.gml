event_inherited();
global.collect += 1000;
global.combo.timer = 60;
create_smalltext(1000);
FMODevent_oneshot("event:/Sfx/General/Collects/toppinget", x, y);
with obj_hud tv_anim(sprites.happy, 180);

with (obj_player)
{
    if (irandom(100) <= 25)
		plrsnds_play(sfx.laugh,x,y);
}

spr_idle = spr_potablecup_idle;
spr_walk = spr_potablecup_move;
spr_panicidle = spr_potablecup_idlepanic;
spr_intro = spr_potablecup_intro;
spr_taunt = spr_potablecup_taunt;
sprite_index = spr_intro;
image_index = 0;
