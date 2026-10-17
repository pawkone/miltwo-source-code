draw_set_alpha(0.75)
draw_set_colour(c_black)
draw_rectangle(0,0,960,540,false)
draw_set_alpha(1)
draw_set_colour(c_white)
draw_set_font(global.creditsfont);
draw_set_halign(fa_center);
draw_text(960 / 2, 32, text);
draw_text(960 / 2, (540 / 2) - 64, global.levels_worldNames[selectedWorld]);
draw_text(960 / 2, (540 / 2) + 64, string(selectedLevel+1) + ": " + global.levels_arr[selectedWorld][selectedLevel][2]);
