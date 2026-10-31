var _a = clamp(1-abs((obj_player.y-402)/350), 0, 1)
draw_sprite_ext(spr_playerShadow,0,obj_player.x,445,_a,_a,0,c_white,_a*0.4)