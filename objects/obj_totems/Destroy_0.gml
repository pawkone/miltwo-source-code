fmod_studio_event_instance_stop(snd, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
fmod_studio_event_instance_release(snd);
xdata_open(global.saveFile);

if (xdata_read("General", string("Totem{0}", totem), false) == false)
{
    obj_savesystem.saveiconTimer = 60;
    obj_totemViewer.goawayTimer = 180;
    obj_totemViewer.totemIndex = totem;
    xdata_write("General", string("Totem{0}", totem), true);
}

xdata_close();
