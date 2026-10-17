if (global.escapeActive == true)
{
    instance_destroy();
    
    with (obj_player)
    {
        vsp = 0;
        state = -4;
        sprite_index = sprites.lookdoor;
        image_index = 0;
        FMODstopAll();
        instance_create(0, 0, obj_rank);
    }
}
