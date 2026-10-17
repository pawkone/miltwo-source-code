randomize()

alarm[0] = 1

langstuff = lang_init();
langstuff_names = variable_struct_get_names(langstuff);

textures = texturegroup_get_textures("texturegroup_game")

texturesMax = array_length(textures) + array_length(langstuff_names);

// -- LOAD AUDIO --
audio_group_load(audioGroupMusic)
audio_group_load(audioGroupSfx)

// -- FONTS (W/ MISC) --
global.fnt_kettle = []
global.comboFont = font_add_sprite_ext(font_combo, "1234567890", 1, 0);
global.percentageFont = font_add_sprite_ext(font_percentage, "0123456789%", 1, 0);
global.creditsfont = font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,:;!?%()1234567890/", 1, 2);
global.bigfont = font_add_sprite_ext(spr_bigfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡¿?.1234567890:ÁÄÃÀÂÉÈÊËÍÌÎÏÓÖÕÔÒÚÙÛÜÇ+", true, 0);
global.smallfont = font_add_sprite_ext(spr_smallfont, "abcdefghijklmnopqrstuvwxyz1234567890.:!?", 1, 0);
global.npcfont = font_add_sprite_ext(spr_npcfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz!¡,.:0123456789'?¿-áäãàâæéèêëíîïóöõôúùûüÿŸÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇç", true, 2);
global.smallnumberfnt = font_add_sprite_ext(spr_smallnumber, "1234567890-+", 1, 0);
global.showcollisions = false;
global.saveFile = wsbMOmInfo.dir + "/default0.xda";

// -- CHARACTERS --

var _ac = function(enu, title = enu){var _sprites=playerUtil_spr(enu);global.PlayerCharacters[enu]={name: title,sprites: _sprites};global.PlayerCharacters[enu].patColors=_sprites.player.patcolours;global.PlayerCharacters[enu].patternSpr=_sprites.player.pattern}

enum chars
{
	mildred,
	valentia,
	milton,
	pepperni,
	bacon_crash,
	bacon_dream,
	bacon_redem,
	bacon_twist,
	soda,
	preoutman,
}

global.PlayerCharacters = [];

_ac(chars.mildred, "Mildred")
_ac(chars.valentia, "Valentino")
_ac(chars.milton, "Milton")
_ac(chars.pepperni, "Pepperni")
_ac(chars.bacon_crash, "Bacon (Crashout)")
_ac(chars.bacon_dream, "Bacon (Dream)")
_ac(chars.bacon_redem, "Bacon (Redemption)")
_ac(chars.bacon_twist, "Bacon (Twisted)")
_ac(chars.soda, "SODA")
_ac(chars.preoutman, "Preout Man")

for (var i = 0; i < array_length(global.PlayerCharacters); i++)
{
	var _spr = get_baconera(font_kettle, i)
	if i == 0 || _spr != font_kettle
		global.fnt_kettle[i] = font_add_sprite_ext(_spr, "0123456789", 1, 0)
	else
		global.fnt_kettle[i] = global.fnt_kettle[0]
}

// -- PROP HUNT MODE --
global.prophuntmode =
{
	room: -4,
	pickedhunter: -4,
	ran: -4,
	active: 0,
	timer: 25,
	waitphase: 1,
	select: -1,
	sprites: [],
}
global.prophuntmode.sprites = [
	[spr_destroyablecrate, spr_destroyablecrate, -32, -18, false],
	[spr_destroyablecrate_small, spr_destroyablecrate_small, -16, -18+32, false],
	[spr_destroyabledonut, spr_destroyabledonut, -32, -18, false],
	[spr_destroyabledonut_small, spr_destroyabledonut_small, -16, -18+32, false],
	[spr_onewayman, spr_onewayman, -32, -18, false],
	[spr_metalblock, spr_metalblock, -32, -18, false],
	[spr_collect1, spr_collect1, -16, -18, false],
	[spr_collect2, spr_collect2, -16, -18, false],
	[spr_collect3, spr_collect3, -16, -18, false],
	[spr_collect4, spr_collect4, -16, -18, false],
	[spr_collect5, spr_collect5, -16, -18, false],
	[spr_bigcollect1, spr_bigcollect1, 0, -18+32, false],
	[spr_bigcollect2, spr_bigcollect2, 0, -18+32, false],
	[spr_bigcollect3, spr_bigcollect3, 0, -18+32, false],
	[spr_bigcollect4, spr_bigcollect4, 0, -18+32, false],
	[spr_bigcollect5, spr_bigcollect5, 0, -18+32, false],
	[spr_key, spr_key, 0, 0, false],
	[spr_door, spr_door, -50, -50, false],
	[spr_sunnyboy, spr_sunnyboy, 0, 0, true],
	[spr_biggiebag_scared, spr_biggiebag, 0, 0, true],
	[spr_doug_scared, spr_doug_walk, 0, 0, true],
	[spr_cocoant_scared, spr_cocoant_walk, 0, 0, true],
	[spr_magician_idle, spr_magician_move, 0, 0, true],
	[spr_cabbit, spr_cabbit, -32, -18-32, false],
	[spr_butterGround, spr_butterGround, 0, 0, true],
	[spr_priest_idle, spr_priest_idle, 0, 0, true],
	[spr_stickcollect_billlargestack, spr_stickcollect_billlargestack, -32, -18, false],
]

// -- RACE MODE --
global.racemode = {
	ran: 0,
	room: -4,
	active: false,
	timer: 15,
}

// -- LEVEL SELECT --
global.levels_worldNames = ["Lunch Hour", "Happy Holidays", "Custom"];
global.levels_arr = [];
var _world1 = [[tutorial_1, "tutorial", "Tutorial"], [yard_1, "yard", "Waybackyard"], [shell_1, "shell", "Shell City"], [beach_1, "beach", "Fruitcup Coast"]];
var _world2 = [[castle_1, "castle", "Castle Pumpkinstein"], [kingdom_1, "kingdom", "Snowcone Kingdom"]];
var _world3 = [[crashout_1, "crashout", "Crashout City"], [rockbottom_1, "rockbottom", "Rock Bottom (Dream Era)"], [frontyard_1, "frontyard", "Frontyard"], [beaker_intro, "beaker", "Beaker Backyard"]];
array_push(global.levels_arr, _world1);array_push(global.levels_arr, _world2);array_push(global.levels_arr, _world3)

// -- ONLINE --
global.server = -4;
global.client = -4;
global.connected = false;

// -- the rest ahahah --
generalReset()