if (hitstun.is == false)
{
    event_inherited();
    
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
            attackTimer--;
            image_speed = 0.35;
            hsp = movespeed * xscale;
            movespeed = 1;
            
            if (buffers.step <= 0)
            {
                buffers.step = 45;
                create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
            }
            
            buffers.step--;
            
            if (sprite_index != spr_tiki_kick)
                sprite_index = spr_move;
            
            if (animation_end() && sprite_index == spr_tiki_kick)
                sprite_index = spr_move;
            
            if (place_meeting(x + xscale, y, obj_solid) || place_meeting(x + xscale, y, obj_hallway) || (!(place_meeting(x + (xscale * 15), y + 31, obj_solid) || place_meeting(x + (xscale * 15), y + 31, obj_slope) || place_meeting(x + (xscale * 15), y + 31, obj_platform)) && grounded))
            {
                image_speed = 0.35;
                xscale *= -1;
            }
            
            if (point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 160 && (obj_player.state == scr_player_mach3 || obj_player.state == scr_player_buzzsaw))
            {
                vsp = -5;
                
                if (obj_player.x != x)
                    xscale = sign(obj_player.x - x);
                
                sprite_index = spr_scared;
                scared = 120;
                state = "stun";
            }
            
            break;
        
        case "grab":
            scr_enemy_grabbed();
            break;
        
        case "thrown":
            scr_enemy_thrown();
            break;
        
        case "buzzsaw":
            hsp = 0;
            
            if (animation_end())
            {
                sprite_index = spr_move;
                image_index = 0;
                state = "move";
            }
            
            break;
        
        case "uppercut":
            hsp = 0;
            image_speed = 0.2;
            
            if (floor(image_index) == 7)
            {
                with (instance_create(x, y, obj_tiki_ball))
                {
                    vsp = -8;
                    hsp = 8 * other.xscale;
                }
                
                state = "buzzsaw";
            }
            
            break;
    }
    
    if (attackTimer <= 0 && point_distance(x, 0, obj_player.x, 0) <= 320 && point_distance(0, y, 0, obj_player.y) <= 42 && state == "move")
    {
        attackTimer = 120;
        state = "uppercut";
        sprite_index = spr_tiki_spit;
        image_index = 0;
        
        if (obj_player.x != x)
            xscale = sign(obj_player.x - x);
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
