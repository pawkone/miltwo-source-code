xdata_open(global.saveFile)
image_index = totem
if xdata_read("General", $"Totem{totem}", false) == true
    instance_destroy()
xdata_close()