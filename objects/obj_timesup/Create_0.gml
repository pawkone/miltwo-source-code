x = 960 / 2;
y = -200;
snd = FMODcreate_event("event:/Music/General/timesup");
fmod_studio_event_instance_start(snd)
alarm[0] = 174;
alarm[1] = 360;
vsp = 0;
falling = false;
depth = 15;

global.escapeActive = 0
global.escapeTimer = 0
instance_destroy(obj_hipnatuese)
instance_destroy(obj_lap2visual)

with (obj_music)
    stop_music();

with (obj_player)
{
	state = -4
	xscale = 1
	x = 960 / 2;
	y = 540 / 2;
	sprite_index = sprites.gateslam;
	image_index = 0;
	image_speed = 0.35;
	visible = true
	xscaleMulti = 1
	yscaleMulti = 1
	squashY = 1
	squashX = 1
    hsp = 0;
    vsp = 0;
}
