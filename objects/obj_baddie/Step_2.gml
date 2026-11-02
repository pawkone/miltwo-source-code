if (distance_to_object(obj_player) <= 200 && obj_player.super)
    state = "scared";

if (state == "scared")
{
    xoffset = irandom_range(-20, 25);
    yoffset = irandom_range(25, -25);
    fear++;
    xscaleMulti += 0.025;
    yscaleMulti += 0.025;
    sprite_index = spr_scared;
    
    if (fear >= 120)
        instance_destroy();
    
    exit;
}

scr_collision();
mask_index = spr_player_mask;

if (y > (room_height + 100) || y < -100)
    instance_destroy();

if ((x > (room_width + 100) || x < -100 || y < -100) && state == "thrown")
    instance_destroy();

if escape && spawnerId < 0
{
    spawnerId = instance_create(x, y, obj_escapespawn)
    spawnerId.content = id
    instance_deactivate_object(id)
	exit
}

with (obj_player)
{
    if (place_meeting(x, y + (vsp * 2), other) && y < other.y && vsp > 0 && !other.invincable)
    {
        if (state == scr_player_jump)
        {
            vsp = -10;
            
            if (pky_jump)
                vsp = -15;
            
            jumpstop = true;
            sprite_index = spr_player_bumpenemystart;
            image_index = 0;
            
            with (other)
            {
                FMODevent_oneshot("event:/Sfx/Player/mach2bump", x, y);
                xscaleMulti = 3;
                yscaleMulti = 0.5;
                vsp = -5;
                xscale = obj_player.xscale;
                scared = 120;
                state = "stun";
                movespeed = 5 * other.xscale;
                sprite_index = spr_stun;
            }
        }
        
        if (state == scr_player_hauling && enemyID != other && !other.invincable)
        {
            vsp = -10;
            
            if (pky_jump)
                vsp = -15;
            
            jumpstop = true;
            sprite_index = spr_player_haulingjump;
            image_index = 0;
            
            with (other)
            {
                FMODevent_oneshot("event:/Sfx/Player/mach2bump", x, y);
                xscaleMulti = 3;
                yscaleMulti = 0.5;
                vsp = -5;
                xscale = obj_player.xscale;
                scared = 120;
                state = "stun";
                movespeed = 5 * other.xscale;
                sprite_index = spr_stun;
            }
        }
    }
    
    if (place_meeting(x + (hsp * 2), y + vsp, other) && hitstun.is == false && other.state != "hit" && !other.invincable)
    {
        var _baddie = other;
        
        if (state == scr_player_mach2 || state == scr_player_tumble) && !other.unbumpable
        {
            with (_baddie)
            {
                FMODevent_oneshot("event:/Sfx/Player/mach2bump", x, y);
                xscaleMulti = 3;
                yscaleMulti = 0.5;
                vsp = -5;
                xscale = obj_player.xscale;
                scared = 120;
                state = "stun";
                movespeed = abs(8 + (other.movespeed / 2));
                sprite_index = spr_stun;
            }
        }
        
        if (state == scr_player_grab && !other.invincable)
        {
            state = scr_player_hauling;
            
            if (pky_run || movespeed > 10)
                sprite_index = spr_player_swingading;
            else
                sprite_index = spr_player_haulingland;
            
            image_index = 0;
            enemyID = _baddie;
            
            if (!grounded)
            {
                jumpstop = true;
                vsp = -6;
            }
            
            with (_baddie)
            {
                playerID = other;
                xscaleMulti = 3;
                yscaleMulti = 0.5;
                sprite_index = spr_stun;
                state = "grab";
            }
        }
        
        if (instakill && !other.invincable)
        {
            if (enemyID == _baddie)
                exit;
            
            FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
            
            if (state == scr_player_mach3 && sprite_index == sprites.mach3)
            {
                sprite_index = sprites.mach3hit;
                image_index = 0;
            }
            
            if (state == scr_player_hammerattack || sprite_index == spr_milton_dive)
            {
                movespeed = approach(movespeed, 30, 2);
                create_particleStatic(spr_miltonEffect, x, y, xscale, 1).image_speed = 0.5;
                squashX = 3;
                squashY = 0.5;
            }
            
			flash = true
            hitstun.x = x;
            hitstun.y = y;
            hitstun.time = 5;
            hitstun.is = true;
            create_particleStatic(spr_kungfueffect, x, y, 1, -5);
            
            if (pky_jump || state == scr_player_buzzsaw)
                vsp = min(vsp,-10);
            
            with (_baddie)
            {
                xscaleMulti = 3;
                yscaleMulti = 0.5;
                hitstun.x = x;
                hitstun.y = y;
                hitstun.time = 5;
                hitstun.is = true;
                sprite_index = spr_stun;
                state = "hit";
            }
        }
    }
}
