scr_collision();
sprite_index = grounded ? spr_butterGround : spr_butterAir;

if (grounded)
{
    slippery = true;
    hsp = approach(hsp, 0, 0.5);
}

with instance_place(x,y,obj_player)
{
    instance_destroy(other);
        
    if !is_transfo_all()
    {
		grounded = false
        state = states.slip;
        movespeed = 12;
        vsp = -15;
        sprite_index = spr_player_slipsyrup;
        image_index = 0;
        FMODevent_oneshot("event:/Sfx/Player/slip", x, y);
    }
}