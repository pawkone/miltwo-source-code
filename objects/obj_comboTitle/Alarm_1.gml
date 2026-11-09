points = approach(points, 0, 5)
create_collect(get_baconera(asset_get_index(string("spr_collect{0}", irandom(4)+1)), obj_player.character), x, y, true)
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y)
