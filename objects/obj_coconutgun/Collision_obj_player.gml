if (other.state == scr_player_grab || other.state == scr_player_hammerattack)
{
    with (other)
    {
        x = other.x;
        y = other.y;
        state = scr_player_coconut_intro;
        sprite_index = spr_player_coconut_intro;
        image_index = 0;
		scr_transfotip("[wave][G] Shoot [J] Jump");
    }
    
    instance_destroy();
}
