if (other.state == states.grab || other.state == states.hammerattack)
{
    with (other)
    {
        x = other.x;
        y = other.y;
        state = states.coconut_intro;
        sprite_index = spr_player_coconut_intro;
        image_index = 0;
		scr_transfotip("[wave][G] Shoot [J] Jump");
    }
    
    instance_destroy();
}
