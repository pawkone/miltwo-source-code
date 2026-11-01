event_inherited();

spr_idle = spr_beant_idle;
spr_move = spr_idle;
spr_turn = spr_idle;
spr_stun = spr_beant_stun;
spr_scared = spr_beant_scared;
spr_dead = spr_beant_dead;
state = states.move;
sprite_index = spr_idle;

throwTimer = 50
projectile = -4