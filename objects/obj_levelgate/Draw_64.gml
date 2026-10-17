if notext exit

var _plr = obj_player.id
if distance >= 500 exit

draw_set_alpha(1-clamp(distance/500,0,1));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_colour(c_white);
draw_set_font(global.creditsfont);

var _fall = _plr.state == states.enterdoor
var _active = distance <= 0
for (var i = 0; i < (level_len + 1); i++)
{
    if (level_text[i] != " ")
    {
		if (_active && !_fall)
            level_vsp[i] = (level_vsp[i] + (((440 - level_ypos[i]) * (0.06 + (0.04 * (i / level_len)))))/2.5) * 0.85;
        else
        {
            level_vsp[i] += (0.3 + (0.04 * (i / level_len)))/2.5;
            
            if (level_ypos[i] > 799)
            {
                level_ypos[i] = 800;
                level_vsp[i] = 0;
            }
            else if (level_ypos[i] < 0)
                level_vsp[i] = -level_vsp[i];
        }
        
        level_ypos[i] += level_vsp[i];
        draw_text(level_xpos + (i * 18) + (sin((current_time - (i * 200)) / 600) * 8), level_ypos[i] + (sin((current_time - (i * 125)) / 300) * 8) + ((level_text[i] == "'") ? -16 : 0), (level_text[i] == "'") ? "," : level_text[i]);
    }
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);
