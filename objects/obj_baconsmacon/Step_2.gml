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
            image_speed = 0.35;
            hsp = 0;
            break;
        
        case "grab":
            scr_enemy_grabbed();
            break;
        
        case "thrown":
            scr_enemy_thrown();
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
