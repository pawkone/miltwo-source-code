FMODSet3dPos(snd, x, y);
y = wave(ystart - 5, ystart + 5, 5, 5);

if (place_meeting(x, y, obj_player))
{
	global.combo.timer = 60
	
	xdata_open(global.saveFile)
	xdata_write("General", $"Totem{totem}", true)
	obj_savesystem.saveiconTimer = 60
	obj_totemViewer.goawayTimer = 180
	obj_totemViewer.totemIndex = totem
	with obj_totemViewer
		event_user(0)
	xdata_close()
	
	instance_destroy()
    create_particleStatic(spr_genericpoofeffect, x, y, 1);
}

image_index = totem;
