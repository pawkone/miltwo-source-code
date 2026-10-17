FMODSet3dPos(moveSnd, x, y);
eyecolor += 0.5;

if (eyecolor > 255)
    eyecolor = 0;

if (image_alpha == 1)
{
	if global.escapeLap == 3
	{
		var _dir = point_direction(x,y,obj_player.x,obj_player.y)
		hsp = lerp(hsp, lengthdir_x(13, _dir), 0.03)
		vsp = lerp(vsp, lengthdir_y(13, _dir), 0.03)
		mask_index = spr_player_mask
	}
	else
	{
	    if (obj_player.x < x)
	        hsp -= 0.5;
	    else
	        hsp += 0.5;
    
	    if (obj_player.y < y)
	        vsp -= 0.5;
	    else
	        vsp += 0.5;
		vsp = clamp(vsp, -12, 12);
		hsp = clamp(hsp, -12, 12);
	}
    if (place_meeting(x, y, obj_player))
        room_goto(timesup_room);
}
else
{
    image_alpha = approach(image_alpha, 1, 0.01);
    hsp = 0;
    vsp = 0;
}

if (obj_player.state == states.enterdoor || obj_player.state == states.walkfront || instance_exists(obj_fadeout) || obj_player.state == -4)
    image_alpha = 0;
x += hsp;
y += vsp;
locatorIndex += 0.1;
