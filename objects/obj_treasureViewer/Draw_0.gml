draw_self();
if (hasTreasure)
{
    var _x = x + (sprite_width / 2);
    draw_sprite(spr_treasure, treasureIndex, _x, (y - 42) + wave(-5, 5, 2, 2));
}