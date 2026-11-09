if (points == 5)
    instance_create(x + irandom_range(-70, 70), y + irandom_range(-70, 70), obj_notes).sprite_index = spr_heart_part;

global.collect += 2;
global.combo.timer = 60;
points--;
create_collect(get_baconera(asset_get_index(string("spr_collect{0}", irandom(4)+1)), obj_player.character), x, y);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);

if (points > 0)
    alarm[0] = 4;
else
    instance_destroy();
