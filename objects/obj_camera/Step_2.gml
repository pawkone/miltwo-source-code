switch (state)
{
    case "normal":
        if (camera.target.state == scr_player_mach2 || camera.target.state == scr_player_mach3 || camera.target.state == scr_player_tumble)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 0.3;
            
            if ((far > 0 && xOffset < 0) || (far < 0 && xOffset > 0))
                chargeSpd = 8;
            
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (camera.target.state == scr_player_surfing)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 4;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (abs(camera.target.hsp) >= 16)
        {
            var chargeSpd = 2.5;
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else
            xOffset = approach(xOffset, 0, 8);
        
        camera.x = camera.target.x + xOffset;
		camera.zoom = lerp(camera.zoom, 1, 0.2)
			
		var _t = camera.zoom
		_t = _t*_t
		
        camera.y = camera.target.y - 50*_t;
		
        break;
    
    case -4:
        if (obj_player.state != -4)
            state = "normal";
        
        break;
}

var _cameraShake = 0, _len = array_length(cameraShakeArray)
if _len > 0
{
	for (var i = _len-1; i >= 0; i--)
	{
		cameraShakeArray[i][0]--
		if cameraShakeArray[i][0] <= 0
			array_delete(cameraShakeArray, i, 1)
		else
		{
			var _per = (cameraShakeArray[i][0]/cameraShakeArray[i][1])
			_per = cameraShakeArray[i][2]*(_per+_per/10)
			if _cameraShake < _per
				_cameraShake = _per
		}
	}
}

camera.width = 960 * camera.zoom
camera.height = 540 * camera.zoom

var _realX = clamp(camera.x - camera.width/2, 0, room_width - camera.width)
var _realY = clamp(camera.y - camera.height/2, 0, room_height - camera.height)
_realX += irandom_range(_cameraShake, -_cameraShake) + (instance_exists(obj_secretManager) ? 0 : irandom_range(-global.escapeActive, global.escapeActive))
_realY += irandom_range(_cameraShake, -_cameraShake) + (instance_exists(obj_secretManager) ? 0 : irandom_range(-global.escapeActive, global.escapeActive))

camera_set_view_pos(view_camera[0], _realX, _realY)
camera_set_view_size(view_camera[0], camera.width, camera.height)

var _xc = _realX+camera.width/2, _yc = _realY+camera.height/2, _si = max(camera.width/1.23, 712) //< sweet spot
var _pad = [
	obj_levelgate, obj_uncleflo, obj_floorgate, obj_dresser, //hub shyte
	obj_secret, obj_secretStart, //playground secrets shyte
	obj_collect, obj_bigcollect, obj_collect_escape, obj_bigcollect_escape, //coalet shyte
	obj_destructibles, obj_metalblock, //destruction ables shyte
	obj_baddie //those bad bitches shyte
]
for (var i = 0; i < array_length(_pad); i++)
{
	instance_activate_object(_pad[i])
	with _pad[i]
	{
		if point_distance(_xc,_yc,x,y) > _si
			instance_deactivate_object(id)
	}
}
