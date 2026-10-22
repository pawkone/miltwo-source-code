bgs =
[
	[bg_yardAForestTop3, bg_yardAForestTop2, bg_yardAForestTop1],
	[bg_shellA3,bg_shellA2,bg_shellA1],
	[bg_beach1,bg_beach2,bg_beach3,bg_beach4,bg_beach5],
	[bg_beach1,bg_beach2,bg_beach3,bg_beach4,bg_beach5],
	[bg_beaker4_1,bg_beaker3_1,bg_beaker2_1,bg_beaker1_1,fg_beaker1_1],
]
bgssel = irandom(array_length(bgs)-1)
bgsfade = 0.1
bgsfadebuffer = floor(random_range(5, 10)*60)
menus =
[
	[-4, "Back", function() {
		with obj_music
			stop_music()
		generalReset()
		movespeed = 0
		vsp = 0
		hsp = 0
		state = -4
		door = "A"
		room_goto(Mainmenu)
		with instance_create(0,0,obj_option)
		{
			currentmenu = 11
			selected = 3
		}
	}],
	[-4, "Make Lobby", function() {
	    menu = 2
	    creating = true
	}],
	[-4, "Join Lobby", function() {
	    menu = 1
	    creating = false
	}],
	[-4, "Change User Info", function() {
	    menu = 3
	}],
];
selected = 0
selectedlrp = selected
menu = 0
bgx = 0
textInput = ""
creating = false
connectIP = ""