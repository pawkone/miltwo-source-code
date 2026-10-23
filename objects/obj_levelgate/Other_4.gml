while (place_meeting(x, y, obj_solid)) y--;
while (place_meeting(x, y, obj_platform)) y--;
y += 2
depth = layer_get_depth("Tiles_1")+1

xdata_open(global.saveFile)

completed = xdata_read(level, "Rank", "NONE") != "NONE"
collect = xdata_read(level, "Highscore", 0)
rank = xdata_read(level, "Rank", "D")

xdata_close()

cancel = (level == "tutorial" || !completed)

if notext exit

var _t = levelgetname(level);
levelname = _t

_t = string_replace_all(_t, " ", "  ")

level_len = string_length(_t) - 1;
level_xpos = 480 - (level_len * 9);
level_ypos = array_create(string_length(_t), 800);
level_vsp = array_create(string_length(_t), 0);
level_text = [];

for (var i = 0; i < (level_len + 1); i++)
    level_text[i] = string_char_at(_t, i + 1);