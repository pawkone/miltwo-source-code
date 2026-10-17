image_speed = 0.35;
visible = true
with obj_onlineTauntEffect
{
	if onlineID == other.onlineID && id != other.id
		instance_destroy()
}