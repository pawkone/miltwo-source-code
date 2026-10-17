sprite_index = get_baconera(asset_get_index(string("spr_bigcollect{0}", irandom(4)+1)), obj_player.character)
image_speed = 0.35;
canmove = place_empty(x, y, obj_solid);
gotoplayer = false;
movespeed = 8;
super = false;
randomwaveNum = random_range(1, 1667);
depth = 50;
