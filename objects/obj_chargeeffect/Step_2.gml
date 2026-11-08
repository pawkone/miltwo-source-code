depth = target.depth + 2;

if (target >= 0 && target.character == chars.bacon_dream)
	sprite_index = spr_player1chargeEffect
if (target >= 0 && target.character == chars.bacon_twist)
	sprite_index = spr_player3chargeEffect
if (target.state == scr_player_mach3)
{
    x = target.x + (12 * image_xscale);
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
else
{
    instance_destroy();
}
