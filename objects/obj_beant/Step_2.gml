if (hitstun.is == false)
{
    event_inherited();
	
	var _plrid = instance_nearest(x,y,obj_player)
	
    switch (state)
    {
        case states.stun:
            scr_enemy_stun();
            break;
        
        case states.hit:
            invincable = true;
            
            if (hitstun.is == false)
            {
                xscale = obj_player.xscale;
                state = states.tumble;
                sprite_index = spr_crab_roll;
                vsp = -6;
                movespeed = 16;
            }
            
            break;
        
        case states.turn:
            scr_enemy_turn();
            break;
        
        case states.normal:
            image_speed = 0.35;
            hsp = 0;
            sprite_index = spr_idle;
			if distance_to_object(_plrid) < 200 //in range type shit
			{
				var _xscale = sign(_plrid.x - x)
				if _xscale != 0
					xscale = _xscale
				throwTimer--
				if throwTimer <= 0
				{
					state = states.tumble
					image_index = 0
					sprite_index = spr_beant_throw_start
					throwTimer = 120
				}
			}
			else
				throwTimer = approach(throwTimer, 120, 4)
            break;
			
        case states.tumble:
            image_speed = 0.35
			if animation_end()
			{
				if sprite_index == spr_beant_throw_start
				{
					image_index = 0
					sprite_index = spr_beant_throw_end
					projectile = instance_create(x,y,obj_beantProjectile)
				}
				else if sprite_index == spr_beant_throw_end
				{
					image_index = 0
					sprite_index = spr_beant_throw_wait
				}
			}
			if sprite_index == spr_beant_throw_wait && !instance_exists(projectile)
			{
				projectile = -4
				throwTimer = 120
				state = states.normal
			}
            break;
			
        case states.grab:
            scr_enemy_grabbed();
            break;
        
        case states.thrown:
            invincable = true;
            state = states.tumble;
            sprite_index = spr_crab_roll;
            vsp = -2;
            movespeed = 16;
            break;
    }
}
else if (hitstun.time >= 0)
{
    image_speed = 0;
    x = hitstun.x + irandom_range(-5, 5);
    y = hitstun.y + irandom_range(-5, 5);
    hitstun.time--;
}
else
{
    x = hitstun.x;
    y = hitstun.y;
    hitstun.is = false;
}
