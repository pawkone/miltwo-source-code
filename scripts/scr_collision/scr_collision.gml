function scr_collision_init()
{
    vsp = 0
    hsp = 0
    grav = 0
    grounded = false
}
function scr_collision()
{
    var o_x = x, o_y = y
    var finalHsp = hsp, finalVsp = vsp
    repeat round(abs(finalVsp))
    {
        o_y = y
        y += abs(finalVsp) != 0 ? sign(finalVsp) : finalVsp
        if scr_solid(x, y)
        {
            y = o_y
            vsp = 0
            finalVsp = 0
        }
    }
    repeat round(abs(finalHsp))
    {
        o_x = x
		x += abs(finalHsp) != 0 ? sign(finalHsp) : finalHsp
        if vsp >= -1
        {
            for (var i = 0; i < 4; i++)
            {
                if !scr_solid(x, y - i)
                {
                    while scr_solid(x, y)
                        y--
                }
                if scr_solid(x, y + i + 1) && scr_solid(x - sign(finalHsp), y + i)
                {
                    while !scr_solid(x, y + 1)
                        y++
                }
            }
        }
        if scr_solid(x, y)
        {
            x = o_x
            hsp = 0
            finalHsp = 0
        }
    }
    grounded = scr_solid(x, y + 1)
    if vsp < 20
        vsp += !place_meeting(x, y, obj_waterNew) ? grav : (grav / 3);
}

function scr_slope(arg0, arg1)
{
    with (instance_place(arg0, arg1, obj_slope))
        return scr_slope_collideCheck(other.id, arg0, arg1);
    return false
}

function scr_solid(arg0, arg1)
{
    var _id = id, _collisionArray = [obj_solid, obj_slope, obj_platform];
    for (var i = 0; i < array_length(_collisionArray); i++)
    {
        var _obj = _collisionArray[i]
        with instance_place(arg0, arg1, _obj)
        {
            switch (_obj)
            {
                case obj_slope:
                    return scr_slope_collideCheck(_id, arg0, arg1)
                    break
                case obj_platform:
                    if ((_id.bbox_bottom - 1) <= (bbox_top + 1) && _id.vsp >= 0) && !(_id.object_index == obj_player && _id.state == scr_player_ladder)
                        return true
                    break
                default: //no obj_solid case cuz its auto true this way :) less code!!!
                    return true
                    break
            }
        }
    }
    return false
}

function scr_slope_collideCheck(arg0, arg1, arg2)
{
    var _height = arg0.bbox_bottom - arg0.y;
    var _slope = (bbox_bottom - bbox_top) / (bbox_right - bbox_left);
    var _side = arg1 + (arg0.bbox_left - arg0.x);
    var _slopeFinal = bbox_bottom + ((_side - bbox_right) * _slope);
    
    if (image_xscale > 0)
    {
        _side = arg1 + (arg0.bbox_right - arg0.x);
        _slopeFinal = bbox_bottom - ((_side - bbox_left) * _slope);
    }
    
    if (image_yscale < 0)
    {
        _height = arg0.y - arg0.bbox_top;
        return (arg2 + _height) < (bbox_top + (bbox_bottom - _slopeFinal));
    }
    
    return (arg2 + _height) > _slopeFinal;
}