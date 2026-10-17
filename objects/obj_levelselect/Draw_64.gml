draw_set_font(global.creditsfont);
draw_set_halign(fa_center);
draw_text(960 / 2, (540 / 2) - 64, global.levels_worldNames[selectedWorld]);
draw_text(960 / 2, (540 / 2) + 64, string(selectedLevel+1) + ": " + global.levels_arr[selectedWorld][selectedLevel][2]);
