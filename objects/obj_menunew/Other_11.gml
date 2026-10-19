if mousemoved
{
	hand_x = lerp(hand_x, clamp(mouse_x,0,960)-135, 0.5)
	hand_y = lerp(hand_y, clamp(clamp(mouse_y,0,540)-20,0,540), 0.5)
	mouse_xfake = mouse_x
	mouse_yfake = mouse_y
	if pky_right || -pky_left || pky_up || pky_down || pky_jump || pky_grab
		mousemoved = false
}
else
{
	hand_x = lerp(hand_x, clamp(mouse_xfake,0,960)-135, 0.5)
	hand_y = lerp(hand_y, clamp(mouse_yfake,0,540)-20, 0.5)
}

var mbleft = pky_jump || mouse_check_button(mb_left)
var mbright = !mbleft && (pky_grab || mouse_check_button(mb_right))

hand_hover = mbright ? 2 : (mbleft ? 4 : 1)

if pky_start2
{
	state = "files"
	if surface_exists(drawsurf) surface_free(drawsurf)
}