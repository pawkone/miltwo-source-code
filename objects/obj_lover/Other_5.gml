if (active)
{
    for (var i = 0; i < points; i++)
    {
        global.collect += 1;
        create_collect(get_baconera(asset_get_index(string("spr_collect{0}", irandom(4)+1)), obj_player.character), x + irandom_range(-50, 50), y + irandom_range(-50, 50));
    }
}
