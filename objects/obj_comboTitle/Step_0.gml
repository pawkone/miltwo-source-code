scale = lerp(scale, 1, 0.2);

if fade
{
    image_alpha = lerp(image_alpha, 0, 0.2);
    if (image_alpha < 0.1)
        instance_destroy();
}

image_index += 0.25;
combo = wrap(combo, 0, 14);
frame = combo*2;
maxframe = frame + 1;

if (image_index >= (maxframe + 1))
    image_index = frame;

if (lostcombo && points > 0 && alarm[1] <= 0)
    alarm[1] = 2;
