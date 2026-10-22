event_inherited()

for (var _y = 0; _y < abs(sprite_height / 32); _y++)
{
    for (var _x = 0; _x < abs(sprite_width / 32); _x++)
        tile_delete(x + (_x * 32), y + (_y * 32));
}

scr_cutoff();