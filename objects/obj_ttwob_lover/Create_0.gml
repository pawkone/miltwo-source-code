scr_collision_init()
grav = 0.1
image_speed = 0
depth = 25
active = false
points = 150
doodle = irandom_range(1, 15)
paper = {index: irandom_range(0, 2), scale: 1.5}
paperSurf = -4
sprite_index = asset_get_index($"spr_ttwob_lover{doodle}")