sprite_index = sprite_getera(asset_get_index($"spr_collect{irandom(4)+1}"))
image_speed = 0.35;
canmove = place_empty(xstart, ystart, obj_solid);
gotoplayer = false;
movespeed = 8;
super = false;
randomwaveNum = random_range(1, 1667);
depth = 50;
