leftright = 1
if grabbing
{
	obj_player.x = 736
	obj_player.y = 402
	obj_player.hsp = 0
	obj_player.vsp = 0
	obj_player.state = -4
	var _oldselect = select
	leftright += pky_right + pky_left
	select += pky_right2 + pky_left2
	select = clamp(select, 0, array_length(global.PlayerCharacters)-1)
	if select != _oldselect
		event_user(0)
	if pky_jump2 || pky_grab2
	{
		obj_player.state = states.normal
		grabbing = false
	}
}
else if rectangle_in_rectangle(704, 384, 704+64, 384+64, obj_player.bbox_left, obj_player.bbox_top, obj_player.bbox_right, obj_player.bbox_bottom) && (obj_player.state == states.grab || obj_player.state == states.hammerattack)
	grabbing = 1

if obj_player.y < 165 && obj_player.character != select
{
	obj_player.state = -4
	obj_player.vsp = -5
	obj_player.hsp = 0
	if obj_player.y <= 100
	{
		obj_player.character = select
		with obj_player
			event_user(0)
		obj_player.sprite_index = obj_player.sprites.groundpound
		obj_player.state = states.groundpound
		obj_player.vsp = 12
	}
}

obj_camera.state = -1
if obj_player.y <= 402
	obj_camera.camera.y = lerp(obj_camera.camera.y, 270, 0.1)
else
	obj_camera.camera.y = lerp(obj_camera.camera.y, 500, 0.1)

if animation_end()
{
	sprite_index = sprites[irandom(spriteslen-1)]
	image_index = 0
}