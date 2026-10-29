buffer = 5

select = obj_player.character

select_count = array_length(global.PlayerCharacters)
spr_pal = []
count_pal = []
select_pal = []
for (var i = 0; i < select_count; i++)
{
	spr_pal[i] = global.PlayerCharacters[i].sprites.player.palette
	count_pal[i] = sprite_get_width(spr_pal[i])
	select_pal[i] = i == select ? min(obj_player.palIndex,count_pal[i]-1) : 1
}

selectadd = 0
selectspd = 0
selectthing = 0
selectthinglrp = 0

closee = false
onlrp = 0
onlrpbe = 0

with obj_player
{
	image_speed = 0.35
	sprite_index = sprites.idle
	state = -4
	hsp = 0
	vsp = 0
	movespeed = 0
}

event_user(0)

image_speed = 0.35

oldSelect = select
oldoldSelect = select