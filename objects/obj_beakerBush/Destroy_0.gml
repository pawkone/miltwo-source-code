if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
	repeat 8
		create_particleDebri(spr_beakerBushDebri, random_range(0, sprite_get_number(spr_beakerBushDebri)), x + 49, y + 53, 1, -1)
	scr_soundeffect(sfx_bushbreak,random_range(0.9,1.1))
}
