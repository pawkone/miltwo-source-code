if (obj_player.state != scr_player_taunt)
    instance_destroy();

image_xscale = obj_player.xscale;
x = obj_player.x;
y = obj_player.y;

if (place_meeting(x, y, obj_ttwob_beantProjectile))
{
    with (instance_place(x, y, obj_ttwob_beantProjectile))
    {
		instance_destroy()
    }
    event_user(0);
}

if (place_meeting(x, y, obj_forkbox))
{
    with (instance_place(x, y, obj_forkbox))
    {
        with (enemy_inst)
        {
            hitHsp = 25 * obj_player.xscale;
            hitVsp = 0;
            state = "thrown";
        }
    }
    
    event_user(0);
}

if (place_meeting(x, y, obj_dart))
{
    with (instance_place(x, y, obj_dart))
    {
        image_xscale *= -1;
        hurtenemy = true;
    }
    
    event_user(0);
}
