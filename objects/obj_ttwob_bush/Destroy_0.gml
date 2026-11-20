if ds_list_find_index(global.saveroom, id) == -1
{
	ds_list_add(global.saveroom, id)
	if instance_exists(obj_player) && obj_player.character == chars.milton && obj_player.state != scr_player_beakerintro
	{
		create_particleStatic(spr_parryeffect,x+49, y+53, 1, depth+1)
		repeat 2
			scr_soundeffect(sfx_ttwob_bushbreak,random_range(1.2,1.5))
		repeat 8
		{
			with create_particleDebri(spr_ttwob_bushDebri, irandom(sprite_get_number(spr_ttwob_bushDebri)-1), x + 49, y + 53, 1, -1)
			{
				hsp = obj_player.xscale*max(2,abs(obj_player.hsp))*random_range(2,3)
				vsp = random_range(-12,-2)
			}
		}
		shake_camera(max(2,abs(obj_player.hsp))*0.8, 20)
	}
	else
	{
		scr_soundeffect(sfx_ttwob_bushbreak,random_range(0.9,1.1))
		repeat 8
			create_particleDebri(spr_ttwob_bushDebri, irandom(sprite_get_number(spr_ttwob_bushDebri)-1), x + 49, y + 53, 1, -1)
	}
}
