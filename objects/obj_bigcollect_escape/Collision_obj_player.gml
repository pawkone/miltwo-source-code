if (global.escapeActive)
{
    var __val = super ? 200 : 100;
    global.collect += __val;
    global.combo.timer = 60;
    create_smalltext(__val);
    create_collect(sprite_index, x, y);
    ds_list_add(global.escaperoom, id);
    instance_destroy();
    FMODevent_oneshot("event:/Sfx/General/Collects/escapecollectBig", x, y);
    with obj_hud tv_anim(sprites.happy, 180);
    
	with (obj_player)
	{
	    if (irandom(100) <= 25)
			plrsnds_play(sfx.laugh,x,y);
	}
}
