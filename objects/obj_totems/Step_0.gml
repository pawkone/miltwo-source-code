FMODSet3dPos(snd, x, y)
y = wave(ystart - 5, ystart + 5, 5, 5)
if place_meeting(x, y, obj_player)
{
	global.combo.timer = 60
	xdata_open(global.saveFile)
	xdata_write("General", $"Totem{totem}", true)
	with instance_create(0,0,obj_totemViewer)
		index = other.totem
	with obj_handlerGameUI saveiconTimer = 60
	xdata_close()
	instance_destroy()
    create_particleStatic(spr_genericpoofeffect, x, y, 1);
}
image_index = totem
