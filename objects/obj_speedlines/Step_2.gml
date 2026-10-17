depth = target.depth + 1;
if target >= 0 && target.character == chars.bacon_dream
	depth -= 2
if (target.state == states.mach3)
{
    x = target.x;
    y = target.y;
    image_angle = 0;
    image_xscale = target.xscale;
}
else
    instance_destroy();
