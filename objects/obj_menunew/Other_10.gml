if mousemoved
{
	hand_x = lerp(hand_x, clamp(mouse_x,0,960)-150, 0.2)
	hand_y = lerp(hand_y, clamp(clamp(mouse_y,0,540)-50,0,540), 0.2)
	mouse_xfake = mouse_x
	mouse_yfake = mouse_y-50
	if pky_right || -pky_left || pky_up || pky_down || pky_jump || pky_grab
		mousemoved = false
}
else
{
	hand_x = lerp(hand_x, clamp(mouse_xfake,0,960)-150, 0.2)
	hand_y = lerp(hand_y, clamp(mouse_yfake,0,540), 0.2)
}

var mbleft = pky_jump || mouse_check_button(mb_left)
var mbright = !mbleft && (pky_grab || mouse_check_button(mb_right))

var _maxy = 205

var _rangex = mbright ? 150 : 48
var _rangey = mbright ? 1000 : 40

var _tvquestionmarrrkkk = hand_x > 428 && hand_x < 724 && hand_y < 96
var _drawingquestionmarrrkkk = hand_x > 7 && hand_x < 7+96 && hand_y < 96
var _drawer1_hover = abs(hand_x-40) < _rangex && abs(hand_y-drawer1_y-210) < _rangey
var _drawer2_hover = abs(hand_x-340) < _rangex && abs(hand_y-drawer2_y-210) < _rangey
var _drawer3_hover = abs(hand_x-640) < _rangex && abs(hand_y-drawer3_y-210) < _rangey
if mbright
{
	if hand_hover != 3
	{
		var _do = hand_y > 170 &&  hand_y < 470
		hand_x += random_range(-48,48)
		hand_y += random_range(-48,48)
		var _play = _do
		if _do
		{
			if _drawer1_hover drawer1_vsp = -random_range(20,100)
			else if _drawer2_hover drawer2_vsp = -random_range(20,100)
			else if _drawer3_hover drawer3_vsp = -random_range(20,100)
			else _play = false
		}
		if _play
		{
			FMODevent_oneshot("event:/Sfx/General/Enemy/killenemy", 960 / 2, 540 / 2)
			FMODevent_oneshot("event:/Sfx/Player/punch", 960 / 2, 540 / 2)
			create_particleStatic(spr_bangeffect,hand_x+150,hand_y+50, 1, depth-1)
		}
		create_particleStatic(spr_hurteffect,hand_x+150,hand_y+50, 1, depth-1)
		FMODevent_oneshot("event:/Sfx/Player/bump", 960 / 2, 540 / 2)
	}
	hand_x += random_range(-2,2)
	hand_y += random_range(-2,2)
	hand_hover = 3
}
else if _tvquestionmarrrkkk
{
	hand_hover = 4
	if mbleft
		state = "tv"
}
else if _drawingquestionmarrrkkk
{
	hand_hover = 4
	if mbleft
		state = "draw"
}
else hand_hover = _drawer1_hover || _drawer2_hover || _drawer3_hover

if hand_grab == 1
{
	hand_x = lerp(hand_x, 35, 0.95)
	drawer1_x = (hand_x-35)*0.5
	
	drawer1_y -= hand_y_old - hand_y
	drawer1_y = lerp(drawer1_y, clamp(drawer1_y, 0, _maxy), 0.8)
	hand_y = lerp(hand_y, drawer1_y+_maxy, 0.8)
}
else
{
	drawer1_y += drawer1_vsp
	drawer1_vsp = approach(drawer1_vsp, 0, 0.5)
	if drawer1_y < 0
	{
		if abs(drawer1_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer1_vsp *= -0.3
		drawer1_y = lerp(drawer1_y, 0, 0.1-drawer1_y/64)
	}
	else if drawer1_y > _maxy
	{
		if abs(drawer1_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer1_vsp *= -0.3
		drawer1_y = lerp(drawer1_y, _maxy, 0.1+(drawer1_y-_maxy)/64)
	}
	drawer1_x = lerp(drawer1_x, 0, 0.25)
}
if hand_grab == 2
{
	hand_x = lerp(hand_x, 335, 0.95)
	drawer2_x = (hand_x-335)*0.5
	
	drawer2_y -= hand_y_old - hand_y
	drawer2_y = lerp(drawer2_y, clamp(drawer2_y, 0, _maxy), 0.8)
	hand_y = lerp(hand_y, drawer2_y+_maxy, 0.8)
}
else
{
	drawer2_y += drawer2_vsp
	drawer2_vsp = approach(drawer2_vsp, 0, 0.5)
	if drawer2_y < 0
	{
		if abs(drawer2_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer2_vsp *= -0.3
		drawer2_y = lerp(drawer2_y, 0, 0.1-drawer2_y/64)
	}
	else if drawer2_y > _maxy
	{
		if abs(drawer2_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer2_vsp *= -0.3
		drawer2_y = lerp(drawer2_y, _maxy, 0.1+(drawer2_y-_maxy)/64)
	}
	drawer2_x = lerp(drawer2_x, 0, 0.25)
}
if hand_grab == 3
{
	hand_x = lerp(hand_x, 635, 0.95)
	drawer3_x = (hand_x-635)*0.5
	
	drawer3_y -= hand_y_old - hand_y
	drawer3_y = lerp(drawer3_y, clamp(drawer3_y, 0, _maxy), 0.8)
	hand_y = lerp(hand_y, drawer3_y+_maxy, 0.8)
}
else
{
	drawer3_y += drawer3_vsp
	drawer3_vsp = approach(drawer3_vsp, 0, 0.5)
	if drawer3_y < 0
	{
		if abs(drawer3_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer3_vsp *= -0.3
		drawer3_y = lerp(drawer3_y, 0, 0.1-drawer3_y/64)
	}
	else if drawer3_y > _maxy
	{
		if abs(drawer3_vsp) > 5 FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		drawer3_vsp *= -0.3
		drawer3_y = lerp(drawer3_y, _maxy, 0.1+(drawer3_y-_maxy)/64)
	}
	drawer3_x = lerp(drawer3_x, 0, 0.25)
}

if hand_grab != -4
{
	mouse_xfake = lerp(mouse_xfake, hand_x+150, 0.1)
	mouse_yfake = lerp(mouse_yfake, hand_y, 0.1)
}

if mbleft
{
	if hand_grab == -4
	{
		var _play = true
		if _drawer1_hover
			hand_grab = 1
		else if _drawer2_hover
			hand_grab = 2
		else if _drawer3_hover
			hand_grab = 3
		else
			_play = false
		if _play
		{
			FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
			FMODevent_oneshot("event:/Sfx/Player/bump", 960 / 2, 540 / 2)
		}
	}
}
else
{
	if hand_grab != -4
	{
		mouse_xfake = hand_x+150
		mouse_yfake = hand_y
		if hand_grab == 1
			drawer1_vsp = (hand_y-hand_y_old)/1.2
		if hand_grab == 2
			drawer2_vsp = (hand_y-hand_y_old)/1.2
		if hand_grab == 3
			drawer3_vsp = (hand_y-hand_y_old)/1.2
		FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		hand_grab = -4
	}
}

if pky_start2
	instance_create(0,0,obj_option)