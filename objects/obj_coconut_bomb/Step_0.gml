scr_collision();

movespeed = approach(movespeed, 0, 0.25)

hsp = movespeed * xscale;
var _objKillshit = [obj_baddie, obj_stupidcabbit, obj_destructibles];

for (var i = 0; i < array_length(_objKillshit); i++)
{
    var _killThing = _objKillshit[i];
    
    if (place_meeting(x + hsp, y + vsp, _killThing))
    {
        instance_destroy(instance_place(x + hsp, y + vsp, _killThing));
        instance_destroy();
		exit
    }
}

if (place_meeting(x + hsp, y, obj_solid))
{
	movespeed *= 0.75
    xscale *= -1;
}

if (grounded)
    instance_destroy();
