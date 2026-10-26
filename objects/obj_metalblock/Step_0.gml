with (obj_player)
{
    var _block = other;
    var _milton = (((state == states.tumble && sprite_index != sprites.dive && movespeed >= 12 && (character == chars.milton)) || (state == states.tumble && sprite_index == sprites.dive && (character == chars.milton)) || state == states.hammerattack || state == states.hammerwirl))
    if (_milton || state == states.mach3 || state == states.buzzsaw || state == states.groundpound)
    {
        var _y = y;
        var _x = x + (xscale * 5);
        
        if (_milton)
        {
            _y = y + vsp;
            _x = x + hsp;
        }
		
        if (state == states.groundpound)
        {
            _y = y + vsp;
            _x = x;
        }
        
        if (state == states.buzzsaw)
        {
            _y = y + vsp;
            _x = x + (xscale * 5);
        }
        
        if (place_meeting(_x, _y, _block))
		|| (state == states.groundpound && place_meeting(_x, y+1, _block))
		|| (state == states.superjump && place_meeting(_x, y-1, _block))
        {
            with (_block)
                instance_destroy();
            
            if (state == states.groundpound)
            {
                sprite_index = sprites.groundpoundland;
                image_index = 0;
                vsp = 0;
                hsp = 0;
                state = states.freefallland;
                movespeed = abs(hsp);
                plrsnds_play(sfx.slam, x, y);
            }
        }
    }
}
