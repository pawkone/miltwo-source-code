switch (state)
{
    case states.normal:
        if (camera.target.state == states.mach2 || camera.target.state == states.mach3 || camera.target.state == states.tumble)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 0.3;
            
            if ((far > 0 && xOffset < 0) || (far < 0 && xOffset > 0))
                chargeSpd = 8;
            
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (camera.target.state == states.surfing)
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
			
		var _t = 1+(1-camera.zoom)
		_t = _t*_t
		
        camera.y = camera.target.y - 50*_t;
		
        break;
    
    case -4:
        if (obj_player.state != -4)
            state = states.normal;
        
        break;
}

if cameraShakeTimer <= 0
{
	cameraShake = 0
	cameraShakeTimerMax = 0
	cameraShakeMax = 0
}
else
{
	if cameraShakeTimerMax < cameraShakeTimer
	{
		cameraShakeMax = cameraShake
		cameraShakeTimerMax = cameraShakeTimer
	}
	cameraShakeTimer = approach(cameraShakeTimer, 0, 1)
	cameraShake = cameraShakeMax*(cameraShakeTimer/cameraShakeTimerMax)*1.5
}

camera.width = 960 * (1 + (1 - camera.zoom));
camera.height = 540 * (1 + (1 - camera.zoom));

var _realX = clamp(camera.x - camera.width/2, 0, room_width - camera.width)
var _realY = clamp(camera.y - camera.height/2, 0, room_height - camera.height)
camera_set_view_pos(view_camera[0], _realX + irandom_range(cameraShake, -cameraShake) + (instance_exists(obj_secretManager) ? 0 : irandom_range(-global.escapeActive, global.escapeActive)), _realY + irandom_range(cameraShake, -cameraShake) + (instance_exists(obj_secretManager) ? 0 : irandom_range(-global.escapeActive, global.escapeActive)));
camera_set_view_angle(view_camera[0], camera.angle);
camera_set_view_size(view_camera[0], camera.width, camera.height);

var _xc = other.camera.x
var _yc = other.camera.y
instance_activate_object(obj_baddie)
with obj_baddie
{
	var _e = escape
	if point_distance(_xc,_yc,x,y) > 1280 || (_e && spawnerId < 0) || (_e && !spawnerId.activated)
		instance_deactivate_object(id)
}
