patternPos += 0.1;
stateTimer--;
patternAlpha = approach(patternAlpha, fadein ? 1 : 0, 1/30);

if (stateTimer <= 0)
{
    stateTimer = fadein ? 60 : 180;
    fadein = !fadein;
    if (fadein)
	{
		var _old_pi = patternIndex
		while _old_pi == patternIndex
			patternIndex = irandom_range(0, sprite_get_number(spr_tileDoodles));
	}
}
