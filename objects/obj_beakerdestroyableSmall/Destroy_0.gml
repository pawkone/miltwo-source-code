if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    repeat (8)
    {
        create_particleDebri(spr_monolithDebris, random_range(0, sprite_get_number(spr_monolithDebris)), x + 16, y + 16, 1, -1);
        create_particleStatic(spr_monolithSmoke, x + 16 + irandom_range(16, -16), y + 16 + irandom_range(16, -16), 1, 10);
    }
    scr_soundeffect(choose(sfx_monolithdestroy1,sfx_monolithdestroy2))
}