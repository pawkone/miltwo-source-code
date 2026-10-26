visible = !(global.escapePartyOver && global.escapeActive)
if !visible
	hud_alpha = 0
else
{
	var _visible = !instance_exists(obj_uncleflo) && !instance_exists(obj_titlecard) && !roomthing
	hud_alpha = approach(hud_alpha, _visible, 0.1)
}

with (kettle)
{
	if obj_player.character == chars.bacon_crash
		x = (271-147) + 26
	else
		x = 124
    kx = lerp(kx, x, 0.2) + irandom_range(shake, -shake);
    ky = lerp(ky, y, 0.05) + irandom_range(shake, -shake);
    shake = approach(shake, 0, 1);
    rankScale = approach(rankScale, 1, 0.2);
    cloudIndex += 0.15;
}

sprites = global.PlayerCharacters[obj_player.character].sprites.tv;
var _sprites = sprites
with (tv)
{
    var isSecret = string_pos("secret", string_letters(room_get_name(room))) > 0;
    var _idleSprite = _sprites.idle;
    
    if (isSecret)
        _idleSprite = _sprites.secret;
    
    if (global.escapeActive && !isSecret)
        _idleSprite = _sprites.escape;
    
    if (global.combo.amt >= 15 && !isSecret)
        _idleSprite = _sprites.combo;
    
    if (obj_player.state == states.ski)
        _idleSprite = _sprites.ski;
    
    if (!other.visible)
    {
        state = states.normal;
        sprite_index = _sprites.off;
    }
    
    image_index += image_speed;
    
    switch (state)
    {
        case states.normal:
            switch (sprite_index)
            {
                case _sprites.off:
                    image_index = 0;
                    sprite_index = _sprites.turnon;
                    break;
                
                case _sprites.turnon:
                    if (image_index >= sprite_get_number(sprite_index))
                    {
                        image_index = 0;
                        sprite_index = _idleSprite;
                    }
                    
                    break;
                
                case _sprites.happy:
                    expressionTimer--;
                    
                    if (expressionTimer <= 0)
                        tv_anim(_idleSprite);
                    
                    break;
                
                case _sprites.crazyrun:
                case _sprites.mach:
                    if (obj_player.state != states.mach3 && obj_player.state != states.climbwall && obj_player.state != states.buzzsaw)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.mach4mode && expressionSprite == _sprites.mach)
                        tv_anim(_sprites.crazyrun);
                    
                    if (!obj_player.mach4mode && expressionSprite == _sprites.crazyrun)
                        tv_anim(_sprites.mach);
                    
                    break;
                
                case _sprites.secret:
                case _sprites.escape:
                case _sprites.idle:
                case _sprites.combo:
                case _sprites.ski:
                    roomname = room_get_name(room);
                    roomname = string_letters(roomname);
                    isSecret = string_pos("secret", roomname) > 0;
                    
                    if (expressionSprite != _idleSprite)
                        tv_anim(_idleSprite);
                    
                    if (obj_player.state == states.mach3)
                        tv_anim(_sprites.mach);
                    
                    break;
            }
            
            break;
        
        case states.move:
            switchindex = approach(switchindex, sprite_get_number(_sprites.trans) - 1, 0.35);
            
            if (switchindex >= (sprite_get_number(_sprites.trans) - 1))
            {
                sprite_index = expressionSprite;
                switchindex = 0;
                state = states.normal;
                image_speed = 0.35;
            }
            
            break;
    }
}

var roomname = string_letters(room_get_name(room));
var _secret = string_pos("secret", roomname) > 0;
var _escape = global.escapeActive == true;

if (!_secret)
    global.escapeTimer = approach(global.escapeTimer, 0, 1);

if (global.escapeTimer == 0 && !instance_exists(obj_hipnatuese) && !_secret && global.level != "tutorial" && _escape)
    instance_create(obj_player.x, obj_player.y, obj_hipnatuese);

if (!ds_list_empty(collectVis))
{
    for (var i = 0; i < ds_list_size(collectVis); i++)
    {
        var q = ds_list_find_value(collectVis, i);
        
        with (q)
        {
            var targetxx = other.kettle.x;
            var targetyy = other.kettle.y;
            var point = point_direction(x, y, targetxx, targetyy);
            hsp = lengthdir_x(24, point);
            vsp = lengthdir_y(24, point);
            x += hsp;
            y += vsp;
            
            if (point_distance(x, y, targetxx, targetyy) <= 25)
            {
                with (other)
                {
                    kettle.shake = 5;
                    q = undefined;
                    ds_list_delete(collectVis, i);
                    i--;
                }
            }
        }
    }
}