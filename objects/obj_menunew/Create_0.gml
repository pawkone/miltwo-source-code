var c = [ $000000, $000000, $1b110b, $3e1e3c, $0a3478, $2b1276, $283469, $0e601e, $28600e, $1a5773, $265443, $522b3a, $542d51, $5f2859, $527483, $aa6058, $c38377, $96ffd0, $ff9893 ]
shd1 = shader_get_uniform(shd_menunew, "u_count")
shd2 = shader_get_uniform(shd_menunew, "u_pal")
shdl = array_length(c)
shda = array_create(shdl * 3, 0.0)
for (var i = 0; i < shdl; i++)
{
	var q = c[i]
	shda[i*3] = (q&$FF)/255
	shda[i*3+1] = ((q>>8)&$FF)/255
	shda[i*3+2] = ((q>>16)&$FF)/255
}

surf = -4
state = "files"

drawsurf = -4

tv_file = ""
tv_nsbuffer = 0
tv_static = -1
tv_change = 0
tv_max = 7
tv_index = 0
tv_indexnext = tv_index

mousemoved = false

mouse_xspd = 0
mouse_yspd = 0
mouse_xfake = 480
mouse_yfake = 400

light_final = random_range(-0.01,0.01)+0.225
light_timer = 1

hand_grab = -4
hand_hover = 0
hand_x = mouse_xfake-150
hand_y = mouse_yfake
hand_x_old = hand_x
hand_y_old = hand_y

fadestage = -1
fadestate = ""

file = 0
file_txt = ""
file_select = 0
file_selectnew = 0

function menunew_item(ind = 0,typ = "none") constructor
{
	xdraw = 0
	ydraw = 0
	x = 0
	y = 0
	vsp = 0
	index = ind
	type = typ
}

items = []
var _t


_t = new menunew_item(3,"drawer")
_t.xdraw = 0
array_push(items, _t)

_t = new menunew_item(3,"drawer")
_t.xdraw = 300
array_push(items, _t)

_t = new menunew_item(3,"drawer")
_t.xdraw = 600
array_push(items, _t)


_t = new menunew_item(15,"disc")
_t.link = 0
array_push(items, _t)

_t = new menunew_item(16,"disc")
_t.link = 1
array_push(items, _t)

_t = new menunew_item(17,"disc")
_t.link = 2
array_push(items, _t)
