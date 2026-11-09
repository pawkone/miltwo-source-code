global.collect += 5;
global.combo.timer = 60;
points -= 5;
create_collect(get_baconera(asset_get_index(string("spr_collect{0}", irandom(4)+1)), obj_player.character), x, y);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);

if (points > 0)
    alarm[0] = 4;
else
    alarm[1] = 25;
