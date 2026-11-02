if (other.state != scr_player_surfing)
{
    other.state = scr_player_surfing;
    other.sprite_index = spr_player_surfing;
    scr_transfotip(lang_get_phrase("tip_surf"));
    other.movespeedSurfing = other.vsp;
}
