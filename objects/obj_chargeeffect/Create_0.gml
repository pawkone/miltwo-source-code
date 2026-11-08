target = obj_player;
image_speed = 0.35;

if (target.state == scr_player_mach3)
{
    x = target.x + (16 * image_xscale);
    y = target.y + 5;
    image_angle = 0;
    image_xscale = target.xscale;
}
else if (target.state == scr_player_groundpound || target.state == scr_player_twistedWallbounce)
{
    x = target.x;
    y = target.y + 32;
    image_angle = -90;
    image_xscale = 1;
}
