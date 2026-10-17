dark = false;
fadeSurface = surface_create(960, 540);
depth = -250;
circleSize = 0;
circleSizeLrp = circleSize;
darkTimer = 0
darkTimer2 = 0
circlePre = choose(8, 12, 16, 24)
circleRan = [irandom_range(-2,2), irandom_range(-2,2), irandom_range(-2,2), irandom_range(-2,2)]

event_perform(ev_other, ev_room_start)