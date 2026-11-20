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

var _tvquestionmarrrkkk = hand_x > 428 && hand_x < 724 && hand_y < 96
var _drawingquestionmarrrkkk = hand_x > 7 && hand_x < 7+96 && hand_y < 96
var _hover = -1
for (var i = 0; i < array_length(items); i++)
{
	var _q = items[i]
	if _q.type == "drawer"
	{
		if abs(hand_x-_q.xdraw-40) < (mbright ? 150 : 48) && abs(hand_y-_q.y-210) < (mbright ? 1000 : 40)
			_hover = i
		if hand_grab == i
		{
			hand_x = lerp(hand_x, _q.xdraw+35, 0.95)
			_q.x = (hand_x-_q.xdraw-35)*0.5
	
			_q.y -= hand_y_old - hand_y
			_q.y = lerp(_q.y, clamp(_q.y, 0, 205), 0.8)
			hand_y = lerp(hand_y, _q.y+205, 0.8)
		}
		else
		{
			_q.y += _q.vsp
			_q.vsp = approach(_q.vsp, 0, 0.5)
			if _q.y < 0
			{
				if abs(_q.vsp) > 5
					FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
				_q.vsp *= -0.3
				_q.y = lerp(_q.y, 0, 0.1-_q.y/64)
			}
			else if _q.y > 205
			{
				if abs(_q.vsp) > 5
					FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
				_q.vsp *= -0.3
				_q.y = lerp(_q.y, 205, 0.1+(_q.y-205)/64)
			}
			_q.x = lerp(_q.x, 0, 0.25)
		}
	}
	else if _q.type == "disc"
	{
		var _q2 = items[_q.link]
		_q.x = _q2.x + _q2.xdraw
		_q.y = _q2.y
		if _q.y > 100 && abs(hand_x-_q.xdraw-_q.x-40) < 48 && abs(hand_y-_q.ydraw-_q.y-70) < 48
			_hover = i
	}
}
if mbright
{
	if hand_hover != 3
	{
		hand_x += random_range(-48,48)
		hand_y += random_range(-48,48)
		if hand_y > 170 && hand_y < 470 && _hover >= 0 && items[_hover].type == "drawer"
		{
			items[_hover].vsp = -random_range(20,100)
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
	{
		fadestage = 0
		fadestate = "tv"
	}
}
else if _drawingquestionmarrrkkk
{
	hand_hover = 4
	if mbleft
	{
		fadestage = 0
		fadestate = "draw"
	}
}
else if _hover >= 0
	hand_hover = items[_hover].type == "disc" ? 4 : 1
else
	hand_hover = 0

if hand_grab != -4
{
	mouse_xfake = lerp(mouse_xfake, hand_x+150, 0.1)
	mouse_yfake = lerp(mouse_yfake, hand_y, 0.1)
}

if mbleft
{
	if hand_grab == -4 && _hover >= 0
	{
		if items[_hover].type == "disc"
		{
			file = items[_hover].index-15
			fadestage = 0
			fadestate = "select"
		}
		else
		{
			FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
			FMODevent_oneshot("event:/Sfx/Player/bump", 960 / 2, 540 / 2)
			hand_grab = _hover
		}
	}
}
else
{
	if hand_grab != -4
	{
		mouse_xfake = hand_x+150
		mouse_yfake = hand_y
		if items[hand_grab].type == "drawer"
			items[hand_grab].vsp = (hand_y-hand_y_old)/1.2
		FMODevent_oneshot("event:/Sfx/Player/mach2bump", 960 / 2, 540 / 2)
		hand_grab = -4
	}
}

if pky_start2
	instance_create(0,0,obj_option)