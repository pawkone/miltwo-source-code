FMODSet3dPos(mu, x, y);
scr_collision();

if (room != hotel_soundtest)
    fmod_studio_system_set_parameter_by_name("musicfade", 1, false);

if ((target.object_index == obj_onlinePlayer && !target.breakdance) || (target.object_index == obj_player && target.sprite_index != target.sprites.breakdance))
{
    create_particleStatic(spr_genericpoofeffect, x, y, 1, -10);
    instance_destroy();
    fmod_studio_event_instance_stop(mu, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    fmod_studio_event_instance_release(mu);
    fmod_studio_system_set_parameter_by_name("musicfade", 0, false);
    exit;
}
