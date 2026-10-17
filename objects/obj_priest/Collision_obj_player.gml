var _transfoPass = [states.snowball, states.snowball_jump, states.snowball_wall, states.skateboard, states.skateboardAim, states.skateboardhitwall, states.skateboardramp, states.skateboardwall, states.skateboardmove, states.coconut_gun, states.coconut_shoot];

if (!array_contains(_transfoPass, other.state))
    exit;

other.flash = true

if (pky_run)
{
    other.state = states.mach2;
    other.sprite = other.sprites.mach2;
}
else
{
    other.state = states.normal;
    other.sprite_index = other.sprites.idle;
}

sprite_index = spr_priest_pray;
alarm[0] = 250;
