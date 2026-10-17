image_speed = 0.35;
vsp = 0;
hsp = 15;
locatorIndex = 0;
image_alpha = 0;
FMODevent_oneshot("event:/Sfx/General/Level/Hipnatuese/spawn", x, y);
moveSnd = FMODcreate_event("event:/Sfx/General/Level/Hipnatuese/move");

if (!FMODevent_isplaying(moveSnd))
    fmod_studio_event_instance_start(moveSnd);
