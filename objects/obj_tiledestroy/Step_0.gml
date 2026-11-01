var _count = 0
with obj_destructibles {if place_meeting(x,y,other) _count++}
with obj_metalblock {if place_meeting(x,y,other) _count++}
if _count != count
	instance_destroy()