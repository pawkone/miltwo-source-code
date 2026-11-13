with (obj_player)
{
    var _block = other;
    var _milton = (((state == scr_player_tumble && sprite_index != sprites.dive && movespeed >= 12 && (character == chars.milton)) || (state == scr_player_tumble && sprite_index == sprites.dive && (character == chars.milton)) || state == scr_player_hammerattack || state == scr_player_hammerwirl))
    if _milton || (state == scr_player_twistedWallbounce && sprite_index == spr_player3_spinnygroundpound) || state == scr_player_dreamcrusher || state == scr_player_mach3 || state == scr_player_buzzsaw || state == scr_player_groundpound
    {
        var _y = y;
        var _x = x + (xscale * 5);
        
        if (_milton)
        {
            _y = y + vsp;
            _x = x + hsp;
        }
		
        if (state == scr_player_twistedWallbounce || state == scr_player_dreamcrusher || state == scr_player_groundpound)
        {
            _y = y + vsp;
            _x = x;
        }
        
        if (state == scr_player_buzzsaw)
        {
            _y = y + vsp;
            _x = x + (xscale * 5);
        }
        
        if (place_meeting(_x, _y, _block))
		|| ((state == scr_player_dreamcrusher || state == scr_player_groundpound) && place_meeting(_x, y+1, _block))
		|| (state == scr_player_superjump && place_meeting(_x, y-1, _block))
        {
            with (_block)
                instance_destroy();
            
            if (state == scr_player_dreamcrusher || state == scr_player_groundpound)
            {
                sprite_index = sprites.groundpoundland;
                image_index = 0;
                vsp = 0;
                hsp = 0;
                state = scr_player_freefallland;
                movespeed = abs(hsp);
                plrsnds_play(sfx.slam, x, y);
            }
        }
    }
}
