itemsMax = 12
xdata_open(global.saveFile)
itemsCur = 0
for (var i = 0; i < itemsMax; i++)
	itemsCur += xdata_read("General", $"Totem{i}", false) == true
xdata_close()