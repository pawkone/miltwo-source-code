function scr_player_fries4wall()
{
	movespeed = 0
    hsp = 0
	vsp = 0
	
	var _targetdir = ""
	if -pky_left _targetdir = point_direction(0,0,-1,0)
	if pky_right _targetdir = point_direction(0,0,1,0)
	if pky_up _targetdir = point_direction(0,0,0,-1)
	if pky_down _targetdir = point_direction(0,0,0,1)
	if -pky_left&&pky_up _targetdir = point_direction(0,0,-1,-1)
	if pky_right&&pky_up _targetdir = point_direction(0,0,1,-1)
	if -pky_left&&pky_down _targetdir = point_direction(0,0,-1,1)
	if pky_right&&pky_down _targetdir = point_direction(0,0,1,1)
	if _targetdir != ""
		direction -= angle_difference(direction,_targetdir) * 0.25
	
	var _hspd = lengthdir_x(12, direction)
	if sign(_hspd) != 0
		xscale = sign(_hspd)
	x += _hspd
	y += lengthdir_y(12, direction)
	
	var lay_id = layer_tilemap_get_id(layer_get_id("Tiles_1"))
	if !scr_solid(x,y) && tilemap_get(lay_id,round(x/32),round(y/32)) == 0
	{
		vsp = lengthdir_y(12, direction)
		hsp = _hspd
        grounded = false
        jumpBuffer = false
        image_index = 0
        sprite_index = sprites.mach2jump
        jumpstop = true
		movespeed = abs(hsp)
		var _s = sign(hsp)
		if _s != 0
			xscale = _s
		state = states.mach2
	}
}
