function scr_player_skateboardIntro()
{
    hsp = 0;
    vsp = 0;
    image_speed = 0.35;
    
    if (animation_end())
    {
        sprite_index = spr_player_skate_idle;
        state = scr_player_skateboard;
        prevOnSlope = false;
        onSlope = false;
        slopeObj = -4;
        wasRamp = false;
        sprayCans = 4;
		if !instance_exists(obj_skateboardViewer)
			instance_create(0, 0, obj_skateboardViewer);
    }
}