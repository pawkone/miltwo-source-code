enum afterimagetype
{
	normal,
	blur,
	buzzsaw,
	milton,
	selectcolor,
	mach,
	dreamAttack,
	dreamMach,
	twistMach1,
	twistMach2,
}

afterimages = ds_list_create();
depth = 45;
uniformLight = shader_get_uniform(shd_fullshade, "lightest");
uniformDark = shader_get_uniform(shd_fullshade, "darkest");
blink = true;
alarm[0] = 3;
