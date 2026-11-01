count = 0
with obj_destructibles {if place_meeting(x,y,other) other.count++}
with obj_metalblock {if place_meeting(x,y,other) other.count++}