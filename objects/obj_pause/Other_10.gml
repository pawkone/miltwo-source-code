if instance_exists(obj_option) exit
if active
{
	draw_sprite(screenSprite, 0, 0, 0)
	shader_reset()
}
if activelrp > 0
	draw_sprite_ext(spr_pauseNEW, 0, 479, 279, 1+((1-activelrp)*2), 1+((1-activelrp)*2), 0, c_white, 1)

for (var i = 0; i < array_length(options); i++)
{
	var q = options[i];
    var target = 0
	if (!active) target = -960
	else if (selected == i) target = 20
	q.offsetX = lerp(q.offsetX, target, 0.125)
	q.offsetX = approach(q.offsetX, target, 0.005)
	draw_sprite_ext(spr_pauseNEW, 1+i,479+q.offsetX, 279,1,1,0,c_white,1);
}