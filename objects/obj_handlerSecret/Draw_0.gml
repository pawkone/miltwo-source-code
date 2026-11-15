draw_set_alpha(0.3+sin(current_time/500)*0.1)
for (var i = 0; i < array_length(collectables); i++)
{
    var q = collectables[i]
    if !instance_exists(q[4])
        draw_sprite(q[0], q[1], q[2], q[3])
    collectables[i][1] += 0.35
}
draw_set_alpha(1)
