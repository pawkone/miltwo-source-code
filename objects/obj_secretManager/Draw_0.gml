draw_set_alpha(0.3);
for (var i = 0; i < array_length(collectables); i++)
{
    var q = collectables[i];
    if (!instance_exists(q.id))
        draw_sprite(q.sprite, q.index, q.x, q.y);
    q.index += 0.35;
}
draw_set_alpha(1);
