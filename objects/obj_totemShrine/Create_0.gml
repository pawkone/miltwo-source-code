depth = 20
image_speed = 0.001

arr = [0, 12]
xdata_open(global.saveFile)
for (var i = 0; i < arr[1]; i++)
	arr[0] += xdata_read("General", $"Totem{i}", false) == true
xdata_close()