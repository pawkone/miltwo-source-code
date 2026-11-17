event_inherited();
spr_move = sprite_getera(spr_biggiebag);
if scr_getera() == "TTWOB"
	spr_turn = -4
else
	spr_turn = sprite_getera(spr_biggiebag_turn);
spr_stun = sprite_getera(spr_biggiebag_stun);
spr_scared = sprite_getera(spr_biggiebag_scared);
spr_dead = sprite_getera(spr_biggiebag_dead);
spr_pal = sprite_getera(pal_biggiebag);
pal_index = irandom(sprite_get_width(spr_pal)-1)