function scr_player_finishingblow()
{
    image_speed = 0.4;
    hsp = movespeed * xscale;
    
    if (floor(image_index) < 4 && sprite_index != spr_player_swingadingend)
        movespeed = approach(movespeed, 0, 1);
    
    if (instance_exists(enemyID) && (floor(image_index) > 4 || sprite_index == spr_player_swingadingend) && enemyID.state == "grab")
    {
        movespeed = -5;
        vsp = -5;
        FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
        
        repeat (8)
        {
            create_particleDebri(spr_baddie_gibs, irandom_range(0, sprite_get_number(spr_baddie_gibs)), x, y, 1, -5);
            create_particleDebri(spr_slapstar, irandom_range(0, sprite_get_number(spr_slapstar)), x, y, 1, -5);
        }
        
        create_particleStatic(spr_kungfueffect, x, y, 1, 2);
        
        if (sprite_index == spr_player_finisheruppercut)
        {
            with (enemyID)
            {
                hitHsp = 0;
                hitVsp = -25;
                state = "thrown";
            }
        }
        else
        {
            with (enemyID)
            {
                hitHsp = 25 * other.xscale;
                hitVsp = 0;
                state = "thrown";
            }
        }
        
        enemyID = -4;
    }
    
    if (animation_end())
    {
        slapBuffer = false;
        state = scr_player_jump;
        sprite_index = sprites.fall;
        jumpstop = true;
    }
    
    buffers.afterimageMach = approach(buffers.afterimageMach, 0, 1);
    
    if (buffers.afterimageMach == 0)
    {
        buffers.afterimageMach = 4;
        create_machEffect(sprite_index, image_index, x, y, xscale, 1);
    }
}