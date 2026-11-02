if distance_to_object(obj_player) < 300 && state == -1
{
	state = 0
	with obj_player
	{
		image_speed = 0.35
		sprite_index = sprites.idle
		state = -4
		movespeed = 0
		hsp = 0
		vsp = 0
	}
	with instance_create(0,0,obj_dialog)
	{
		target = other.id
		
		addDialog(spr_dialogP_mildre,	0, "What is going on, why are you even here Milton?", function(){target.change = 1; scr_music(mu_milton, false)})
		addDialog(spr_dialogP_milton,	0, "AH HA! YOU FINALLY NOTICED ME,#YOU MUST HAVEA BLIND EYE.. HMM?")
		addDialog(spr_dialogP_mildre,	0,  "You sure did hide well.. Within plain sight, pal.")
		addDialog(spr_dialogP_milton,	2,  "... *cough*.. Uhm..")
		addDialog(spr_dialogP_milton,	1,  "WELLLL? I CAN DO MY EVIL TRAP NOW, AHAHAHAAHAAAAA!")
		addDialog(spr_dialogP_mildre,	0,  "Yeah.. Mhm.", function(){audio_sound_pitch(global.music,0.98)})
		addDialog(spr_dialogP_milton,	0,  "39.187.238.148", function(){audio_sound_pitch(global.music,0.87)})
		addDialog(spr_dialogP_mildre,	2,  "...", function(){audio_sound_pitch(global.music,0.76)})
		addDialog(spr_dialogP_mildre,	3,  "What..", function(){audio_sound_pitch(global.music,0.65)})
		addDialog(spr_dialogP_mildre,	1,  "Is that my fucking home address?", function(){audio_sound_pitch(global.music,1.2)})
		addDialog(spr_dialogP_milton,	0,  "OHHH NO NO NO NO... MY.. Heh.. 'non-amigo', YOU..", function(){audio_sound_pitch(global.music,1.05)})
		addDialog(spr_dialogP_milton,	2,  "Wow, uh.. You are.. STUPID AS FUCK HAAHAHA!#Ahem.. *cough*..", function(){audio_sound_pitch(global.music,1)})
		addDialog(spr_dialogP_milton,	1,  "HOW'D YOU FORGET MY BEST OLD FRIENEMY?")
		addDialog(spr_dialogP_mildre,	3,  "...")
		addDialog(spr_dialogP_mildre,	2,  "Ehh?")
		addDialog(spr_dialogP_milton,	0,  "DON'T 'Ehh?' ME HAHAHA... ha..")
		addDialog(spr_dialogP_milton,	2,  "...")
		addDialog(spr_dialogP_mildre,	1,  "...?", function(){scr_music(-4, false)})
		addDialog(spr_dialogP_milton,	4,  "...")
		addDialog(spr_dialogP_milton,	3,  "Did..")
		addDialog(spr_dialogP_milton,	4,  "DID YOU REALLY FORGET?")
		addDialog(spr_dialogP_mildre,	0,  "I don't get the meaning of this random address.. Milton..")
		addDialog(spr_dialogP_milton,	3,  "Wow.. you really.. uhm..", function(){scr_music(mu_milton, false) audio_sound_set_track_position(global.music, 20.45)})
		addDialog(spr_dialogP_milton,	0,  "AHEM.. DON'T YOU KNOW? THAT'S MY...", function(){audio_sound_pitch(global.music,0.98)})
		addDialog(spr_dialogP_milton,	2,  "My...", function(){scr_music(-4, false)})
		addDialog(spr_dialogP_milton,	3,  "Favourite... coffee shop's router ip address..", function(){scr_music(mu_milton, false) audio_sound_pitch(global.music,0.2) audio_sound_set_track_position(global.music, 20.45)})
		addDialog(spr_dialogP_milton,	4,  "*sniff*.. aw, fuck man.")
		addDialog(spr_dialogP_milton,	3,  "I'm gonna cry.. You.. *sniff*.. You really#forgot it, Mildred?")
		addDialog(spr_dialogP_mildre,	2,  "...")
		addDialog(spr_dialogP_mildre,	0,  "Huh?", function(){audio_sound_pitch(global.music,0.16)})
		addDialog(spr_dialogP_milton,	3,  "How... *sniff*.. sarcastic can you be Mildred.")
		addDialog(spr_dialogP_milton,	5,  "CAN'T YOU SEE WHAT I FEEL? YOU ALWAYS STEP OVER ME!!!!")
		addDialog(spr_dialogP_mildre,	0,  "What is happening.. Is this a confession of some sorts?", function(){audio_sound_pitch(global.music,0.3)})
		addDialog(spr_dialogP_milton,	7,  "WWAHHHHHHHHHHHHHHHHHHHHHHH!!!", function(){audio_sound_pitch(global.music,0.35)})
		addDialog(spr_dialogP_mildre,	3,  "No no no, wait... Okay, look..", function(){audio_sound_pitch(global.music,0.4)})
		addDialog(spr_dialogP_milton,	7,  "WAAAAAAAAHHHHHHHHHHHHHHHAHHAHAHAHHHHHH!!!!!", function(){audio_sound_pitch(global.music,0.45)})
		addDialog(spr_dialogP_mildre,	0,  "Hey, stop... Don't..")
		addDialog(spr_dialogP_milton,	5,  "YOU NEVER TAKE ME SERIOUSLY MILDRED!")
		addDialog(spr_dialogP_milton,	1,  "REMEMBER THE GOOD OLD DAYS?")
		addDialog(spr_dialogP_milton,	6,  "WHERE ME AND YOU FOUGHT LIKE PROPER FOES..?")
		addDialog(spr_dialogP_milton,	3,  "... *sniff sniff*..")
		addDialog(spr_dialogP_milton,	5,  "YOU FOUGHT ME LIKE I MEANT SOMETHING.")
		addDialog(spr_dialogP_milton,	4,  "LIKE... LIKE..... LIKE!", function(){target.change = 1})
		addDialog(spr_dialogP_milton,	6,  "WHAT AM I NOW MILDRED? WHAT AM I?", function(){scr_music(-4, false)})
		addDialog(spr_dialogP_mildre,	1,  "Your voice is straining bud.")
		addDialog(spr_dialogP_milton,	4,  "....")
		addDialog(spr_dialogP_milton,	3,  "w.. what..?", function(){scr_music(mu_milton, false) audio_sound_pitch(global.music,0.97) audio_sound_set_track_position(global.music, 51) target.change = 1})
		addDialog(spr_dialogP_milton,	0,  "*cough*.. OH, OH *cough*.. Ye.. YEAH RIGHT!", function(){audio_sound_pitch(global.music,1)})
		addDialog(spr_dialogP_milton,	2,  "YOU THINK YOUR TOUGH.. but...")
		addDialog(spr_dialogP_milton,	1,  "BUT YOUR BUILT LIKE A STICK MILDRED, AHAHAHAAHAAAAA!")
		addDialog(spr_dialogP_milton,	2,  "Heh.. Mmm. Aidos, 'hermano.. de otra madre'.", function(){target.change = 1})
		addDialog(spr_dialogP_milton,	0,  "HAHAHAAH-", function(){target.change = 1})
		addDialog(spr_dialogP_milton,	3,  "Ow. fuck..", function(){target.change = 1})
		addDialog(spr_dialogP_milton,	0,  "HAHAHAHAHAHAAAaa-..", function(){scr_music(-4, true)})
		addDialog(-4, 0,					"*He laughs manically as he runs away*")
		addDialog(spr_dialogP_mildre,	0,  "...")
		addDialog(spr_dialogP_mildre,	0,  "What..")
		addDialog(spr_dialogP_mildre,	0,  "The fuck..")
		addDialog(spr_dialogP_mildre,	0,  "'de otra madre'..?", function(){game_end()})
		
		active = true
		alarm[0] = 2
	}
}

if change
{
	change = false
	
	state++
	buffer = 0
	if state == 1
		image_xscale = -1
	else if state == 2
	{
		image_speed = 0.175
		image_xscale = 1
		image_index = 7
		sprite_index = spr_milton_gateslam
	}
	else if state == 3
	{
		image_xscale = -1
		sprite_index = spr_milton_idle
		image_speed = 0
	}
	else if state == 4
	{
		image_xscale = 1
		image_speed = 2
		image_index = 0
		sprite_index = spr_milton_mach1
	}
	else if state == 5
	{
		image_speed = 0
		sprite_index = spr_milton_mach1
	}
	else if state == 6
	{
		image_speed = 0.75
		sprite_index = spr_milton_mach2
	}
}

if state == 2
{
	if animation_end() && image_speed > 0
	{
		image_speed = 0
		image_index = image_number-1
	}
}
else if state == 3
	image_speed = approach(image_speed, 0.35, (1/60)*0.35)
else if state == 4
{
	x = lerp(x, xstart + sin(current_time/250)*16, 0.1)
	if buffer < 0
	{
		buffer = 4
		with create_particleStatic(choose(spr_supertaunteffect1,spr_supertaunteffect2,spr_supertaunteffect3,spr_supertaunteffect4),x,y+random_range(-30,30),1)
		{
			hsp = -random_range(7,10)
			vsp = random_range(-2,2)
		}
		with create_particleStatic(spr_dashcloud1,x,y,1)
			hsp = -random_range(2,10)
	}
	else
		buffer--
	if animation_end() && image_speed > 0
	{
		image_speed *= -1
		image_index = image_number-1
	}
	else if image_index < 1 + -image_speed && image_speed < 0
	{
		image_speed *= -1
		image_index = 1
	}
}
else if state == 5
{
	image_index = irandom(1)+8
	buffer++
	
	var _t = clamp(buffer / 18, 0, 1)
	_t += sin(_t * pi * 3) 
	
	image_angle = _t*-90
	x = lerp(x, lerp(xstart, xstart+50, _t), 0.5)
	y = lerp(y, lerp(ystart, ystart+50, _t), 0.5)
}
else if state == 6
{
	buffer++
	
	with create_particleStatic(choose(spr_supertaunteffect1,spr_supertaunteffect2,spr_supertaunteffect3,spr_supertaunteffect4),x,y+random_range(-30,30),1)
	{
		hsp = -random_range(7,10)
		vsp = random_range(-2,2)
	}
	with create_particleStatic(spr_dashcloud1,x,y,1)
		hsp = -random_range(2,20)
	
	image_angle = lerp(image_angle, 90 + buffer*-35, 0.4)
	y = lerp(y, ystart, 0.2)
	hspeed = buffer/3
	if x > 1000
	{
		state++
		hspeed = 0
	}
}

var obj = [obj_player, self]
for (var i = 0; i < array_length(obj); i++)
{
	with obj[i]
	{
		var _a = clamp(1-abs((y-402)/350), 0, 1)
		draw_sprite_ext(spr_playerShadow,0,x,445,_a,_a,0,c_white,_a*0.4)
	}
}
draw_self()