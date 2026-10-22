if potableIndex > -1 && potableIndex < 5
	global.toppins[potableIndex] = true
instance_destroy()

var _t = global.toppins[0]+global.toppins[1]+global.toppins[2]+global.toppins[3]+global.toppins[4]
if _t >= 5
	scr_transfotip(lang_get_phrase("tip_pickup_potablesall"))
else
	scr_transfotip(string(lang_get_phrase(_t > 1 ? "tip_pickup_potables" : "tip_pickup_potable"), _t))

repeat (4)
    create_particleDebri(spr_juiceboxcage_debri, irandom_range(0, sprite_get_number(spr_juiceboxcage_debri)), x, y, 1);

ds_list_add(global.saveroom, id);

with (obj_player)
{
	if (irandom(100) <= 25)
		plrsnds_play(sfx.laugh,x,y);
}
