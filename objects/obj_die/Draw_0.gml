x = obj_player.x-50
y = obj_player.y-50

if multdelay == 8 && sprite == -4
{
	var _surf = surface_create(100,100), _ox = 0, _oy = 0
	surface_set_target(_surf)
	draw_clear(c_fuchsia)
	with obj_player
	{
		_ox = x
		_oy = y
		x = 50
		y = 50
		flash = false
		event_perform(ev_draw, 0)
	}
	surface_reset_target()
	
	var _surf2 = surface_create(100,100)
	surface_set_target(_surf2)
	with obj_player
	{
		event_perform(ev_draw, 0)
		x = _ox
		y = _oy
		visible = false
		state = function(){hsp=0 vsp=0}
		hsp = 0
		vsp = 0
		movespeed = 0
	}
	surface_reset_target()
	
	sprite = sprite_create_from_surface(_surf2,0,0,100,100,false,false,0,0)
	surface_free(_surf2)
	for (var i = 0; i < 100; i += 2)
	{
		for (var j = 0; j < 100; j += 2)
		{
			if !(
				surface_getpixel(_surf,i,j) == c_fuchsia
				&& surface_getpixel(_surf,i+1,j) == c_fuchsia
				&& surface_getpixel(_surf,i,j+1) == c_fuchsia
				&& surface_getpixel(_surf,i+1,j+1) == c_fuchsia
			)
				array_push(pixels, [i,j,i+x,j+y,random_range(-96,96),-random(96)])
		}
	}
	surface_free(_surf)
}
if multdelay < 7
{
	if spd < 0.3
	{
		draw_clear(c_black)
		gpu_set_fog(true,c_white,0,1)
	}
	spd = approach(spd, 1, 0.005+spd/5)
	game_set_speed(56*spd+4,gamespeed_fps)
}
var _obj = [obj_solid, obj_slope]
for (var i = 0; i < array_length(pixels); i++)
{
	var _p = pixels[i]
	if multdelay < 7
	{
		pixels[i][4] *= 1-random(5)/100
		pixels[i][5] += random(5)/10
	
		var _ob = instance_position(_p[2]+1,_p[3]+4, obj_slope)
		if _ob
			pixels[i][4] -= sign(_ob.image_xscale)
		
		var _touchnox = true, _touchnoy = true
		for (var j = 0; j < array_length(_obj); j++)
		{
			if position_meeting(_p[2]+_p[4]+1,_p[3]+1,_obj[j])
			{
				with create_particleStatic(choose(spr_cloudeffect,spr_hurteffect),_p[2],_p[3],1,depth+1)
				{
					image_speed = 1
					image_xscale = 0.25
					image_yscale = 0.25
				}
				pixels[i][4] *= -random_range(0.5,0.8)
				_touchnox = false
			}
			if position_meeting(_p[2]+1,_p[3]+_p[5]+1,_obj[j])
			{
				with create_particleStatic(choose(spr_cloudeffect,spr_hurteffect),_p[2],_p[3],1,depth+1)
				{
					image_speed = 1
					image_xscale = 0.25
					image_yscale = 0.25
				}
				pixels[i][5] *= -random_range(0.5,0.8)
				_touchnoy = false
			}
		}
	
		if _touchnoy pixels[i][3] += _p[5]*spd
		if _touchnox pixels[i][2] += _p[4]*spd
	}
	draw_sprite_part(sprite,0,_p[0]-1,_p[1]-1,4,4,_p[2],_p[3])
}
gpu_set_fog(false,c_white,0,1)
if multdelay > 0
{
	game_set_speed(56*(multdelay/74)+4,gamespeed_fps)
	multdelay -= 2
	if multdelay == 0
	{
		shake_camera(24, 450)
		create_particleStatic(spr_hurteffect,x+50,y+50,1,depth-1)
		repeat 32
		{
			with create_particleStatic(choose(spr_supertaunteffect1,spr_supertaunteffect2,spr_supertaunteffect3,spr_supertaunteffect4),x+50,y+50,1,depth+1)
			{
				hsp = random_range(-20,20)
				vsp = random_range(-20,20)
			}
		}
	}
	if multdelay == 16
		obj_camera.cameraShakeArray = []
	else if multdelay > 16
		shake_camera(300/multdelay)
}