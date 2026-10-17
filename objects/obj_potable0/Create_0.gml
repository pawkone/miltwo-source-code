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

sprite_index = spr_intro;
image_index = 0;
