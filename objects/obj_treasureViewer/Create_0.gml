treasureIndex = 0;
depth = 50;

xdata_open(global.saveFile)
hasTreasure = xdata_read(level, "Treasure", 0)
xdata_close()