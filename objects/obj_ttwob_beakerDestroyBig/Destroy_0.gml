if (ds_list_find_index(global.saveroom, id) == -1)
{
    ds_list_add(global.saveroom, id);
    repeat (8)
    {
        create_particleDebri(spr_ttwob_beakerDestroyDebris, random(sprite_get_number(spr_ttwob_beakerDestroyDebris)-1), x + 16, y + 16, 1, -1);
        create_particleStatic(spr_ttwob_beakerDestroySmoke, x + 16 + irandom_range(16, -16), y + 64 + irandom_range(16, -16), 1, 10);
    }
    scr_soundeffect(choose(sfx_ttwob_beakerdestroy1,sfx_ttwob_beakerdestroy2))
}