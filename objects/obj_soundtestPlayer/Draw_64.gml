draw_set_font(global.npcfont);
draw_set_alpha((alpha/2)-(sin(current_time/1000)+1)/20);
draw_set_colour(c_black);
draw_rectangle(32, 32, 960 - 32, 204, false);
draw_set_colour(c_white);
draw_set_halign(0);
draw_set_valign(1);
draw_set_alpha(alpha);
var _t = string_concat("Track Number: ", currentSong+1, " out of ", array_length(songs), "\n", songs[currentSong].text)
var _a = alpha*alpha*alpha*alpha
draw_text_color(65, 118, _t, 0,0,0,0, _a);
draw_text_color(63, 118, _t, 0,0,0,0, _a);
draw_text_color(64, 119, _t, 0,0,0,0, _a);
draw_text_color(64, 117, _t, 0,0,0,0, _a);
draw_text(64, 118, _t);
draw_set_valign(0);
draw_set_alpha(1);