if (hitstun.is == false)
{
    event_inherited();
	
	var _plrid = instance_nearest(x,y,obj_player)
	
    switch (state)
    {
        case "stun":
            scr_enemy_stun();
            break;
        
        case "hit":
            scr_enemy_hit();
            break;
        
        case "turn":
            scr_enemy_turn();
            break;
        
        case "move":
            image_speed = 0.35;
            hsp = 0;
            sprite_index = spr_idle;
			if distance_to_object(_plrid) < 400 //in range type shit
			{
				var _xscale = sign(_plrid.x - x)
				if _xscale != 0
					xscale = _xscale
				throwTimer--
				if throwTimer <= 0
				{
					state = "tumble"
					image_index = 0
					sprite_index = spr_beant_throw_start
				}
			}
			else
				throwTimer = approach(throwTimer, 50, 4)
            break;
			
        case "tumble":
            image_speed = 0.35
			if animation_end()
			{
				if sprite_index == spr_beant_throw_start
				{
					image_index = 0
					sprite_index = spr_beant_throw_end
					projectile = instance_create(x,y,obj_beantProjectile)
					projectile.target = id
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
				throwTimer = 50
				state = "move"
			}
            break;
			
        case "grab":
            scr_enemy_grabbed();
            break;
        
        case "thrown":
            scr_enemy_thrown()
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
