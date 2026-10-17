function scr_player_ladder()
{
    movespeed = 0;
    image_speed = 0.35;
    hsp = 0;
    
    if (pky_up)
    {
        vsp = -6;
        sprite_index = spr_player_laddermove;
    }
    else if (pky_down)
    {
        vsp = 10;
        sprite_index = spr_player_ladderdown;
    }
    else
    {
        vsp = 0;
        sprite_index = spr_player_ladder;
    }
    
    var q = place_meeting(x, y, obj_ladder)
    if (q)
    {
        var _ladderInst = instance_place(x, y, obj_ladder)
        x = lerp(x, _ladderInst.x + (_ladderInst.sprite_width / 2), 0.25)
	}
    else
    {
        state = states.normal;
        vsp = 0;
    }
    
    if (pky_down && grounded && !place_meeting(x, y+vsp, obj_platform))
    {
        state = states.normal;
        vsp = 0;
    }
    
    buffers.step--;
    
    if (buffers.step <= 0 && (pky_up || pky_down))
    {
        buffers.step = 12;
        create_particleStatic(spr_cloudeffect, x, y + 42, 1, 1);
    }
    
    if (jumpBuffer)
    {
        jumpBuffer = false;
        create_particleStatic(spr_jumpeffect, x, y, 1, 1);
        image_index = 0;
        sprite_index = sprites.jump;
        state = states.jump;
        vsp = -12;
        jumpstop = false;
        plrsnds_play(sfx.jump, x, y);
    }
}
