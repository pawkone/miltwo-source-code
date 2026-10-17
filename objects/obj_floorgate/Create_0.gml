depth = layer_get_depth("Tiles_1")+1;
slam = false
slow = false
entering = false
image_index = 0
image_speed = 0
timer = 0
shake = 0
openned = 0
openamount = 0
openspd = 0
y += 2
enterfunc = function()
{
	scr_fadeout(slow ? 0.005 : 0.0175)
}