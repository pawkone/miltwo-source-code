globalvar states;
states =
{
	normal: 0,
	crouch: 1,
	jump: 2,
	mach2: 3,
	mach3: 4,
	machslide: 5,
	machturn: 6,
	hitwall: 7,
	turn: 8,
	move: 9,
	hit: 10,
	stun: 11,
	superjumpprep: 12,
	superjump: 13,
	freefallland: 14,
	taunt: 15,
	tumble: 16,
	climbwall: 17,
	groundpoundstart: 18,
	groundpound: 19,
	enterdoor: 20,
	walkfront: 21,
	grab: 22,
	hauling: 23,
	finishingblow: 24,
	thrown: 25,
	uppercut: 26,
	hurt: 27,
	ladder: 28,
	buzzsaw: 29,
	parry: 30,
	surfing: 31,
	diveboard: 32,
	ski: 33,
	skibounce: 34,
	skirow: 35,
	hammerattack: 36,
	hammerwirl: 37,
	snowball: 38,
	snowball_jump: 39,
	snowball_wall: 40,
	skateboardIntro: 41,
	skateboard: 42,
	skateboardmove: 43,
	skateboardhitwall: 44,
	skateboardramp: 45,
	skateboardwall: 46,
	skateboardAim: 47,
	slip: 48,
	scared: 49,
	coconut_gun: 50,
	coconut_intro: 51,
	coconut_shoot: 52,
	noclip: 53,
	burned: 54,
	crashoutbounce: 55,
	dreambounce: 56,
	dreamspin: 57,
	retwistedBuzzsaw: 58,
	water: 59,
}


















globalvar state_names; state_names = []
var keys = struct_get_names(states)
for (var i = 0; i < array_length(keys); i++)
{
	var key = keys[i]
	var value = variable_struct_get(states, key)
	state_names[value] = key
}