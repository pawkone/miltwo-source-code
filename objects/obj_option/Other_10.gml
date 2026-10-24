if !variable_instance_exists(id,"miltwocredits_ready")
	miltwocredits_ready = true
else
	exit
miltwocredits_credits = 
[
	["Back", "note : press confirm on any person to see all\nsprites they did or view music tracks they composed..."],
	[
		"Pawkone",
		"director : coder : artist : ideas : etc",
		spr_milton_rollstart, spr_baconsmacon_deadlintro, spr_baconsmacon_deadloop,
		spr_bacadmadLocate, spr_minilogo, spr_menunew, spr_menunew_tvhint,
		spr_gate_shell, spr_floorgate, spr_floorgate_over, spr_uparrow,
		spr_titlecardShell, spr_titlecardShellTitle1, tilespr_fruitcup,
	],
	[
		"Targetbuldoser (Ex Miltu Member)",
		"artist : composer : ideas",
		spr_pepperni_idle, spr_milton_mach1, spr_milton_mach2, spr_milton_mach3turn,
		spr_milton_wallslide, spr_player0_groundpoundstart, spr_player0_groundpound,
		spr_player0_groundpoundbump, spr_soda, spr_tv_soda, spr_titlecardFrontyard,
		spr_titlecardFrontyardTitle1
	],
	[
		"MrAlt- (Ex Miltu Member)",
		"former co director : coder : level designer",
		tilespr_frontyard, tilespr_outbreak, tilespr_hotel2
	],
	[
		"Polyg0n5",
		"volunteered artist : artist for og miltu",
		spr_butterAir, spr_butterGround, spr_pepperni_mach1, spr_pepperni_mach3,
		spr_pepperni_taunt, spr_milton_jump, spr_milton_fall, spr_milton_land,
		spr_milton_land2, spr_titlecardFruitcup, spr_titlecardFruitcupTitle1,
		spr_titlecardFruitcupTitle2, spr_tv_idleanim1T, spr_tv_idleanim2T,
		spr_tv_idleP, spr_tv_machP, spr_tv_crazyrunP, spr_tv_happyT,
		spr_tv_escapeP, spr_pepperni_mach3turn
	],
	[
		"Toasty64 (Ex Miltu Member)",
		"coder : artist : ideas",
		spr_player_chat
	],
	[
		"PaintlesNoise (Ex Miltu Member)",
		"artist",
		spr_milton_mach3turnfall
	],
	[
		"ElCacas.XD.RenovadoXD",
		"volunteered artist",
		spr_pepperni_idleanim1, spr_pepperni_crazyrun
	],
	[
		"Bobbers6921",
		"volunteered artist",
		spr_pepperni_mach2
	],
	[
		"CoolGuy_The_Guy",
		"volunteered composer",
		mu_peppernilap2
	],
]
miltwocredits_creditsshow = []
miltwocredits_selected = 0
miltwocredits_yoffset = 0
miltwocredits_starty = []
miltwocredits_startoffset = []
miltwocredits_extendview_enabled = false
miltwocredits_extendview_selected = 0
miltwocredits_extendview_music = -4

var _yy = 0, kl = array_length(miltwocredits_credits)
draw_set_font(global.creditsfont)
for (var k = 0; k < kl; k++)
{
	miltwocredits_starty[k] = _yy
	var ki = miltwocredits_credits[k]
	var kil = array_length(ki)
	miltwocredits_creditsshow[k] = [ki[0], ki[1]]
	_yy += string_height(ki[0])
	var _yoffset = 0
	for (var j = 2; j < kil; j++)
	{
		if sprite_exists(ki[j])
		{
			var _h = sprite_get_height(ki[j])
			if _h < 200
			{
				array_push(miltwocredits_creditsshow[k], ki[j])
				_yoffset = max(_yoffset, _h)
			}
		}
	}
	_yy += _yoffset+48
	if k == 0
		_yy += 72
	miltwocredits_startoffset[k] = _yoffset+48
}