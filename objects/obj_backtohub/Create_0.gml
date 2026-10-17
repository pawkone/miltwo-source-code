start = 0;
alpha = 1.1;
fakeVsp = 5;
spd = 0

with obj_onlineHandler
	create_notifAsync(string(global.username) + " went back to the hotel");

depth = -600;

with obj_camera
{
	state = -4
	camera.zoom = 2
	camera.x = obj_player.backtohubX
	camera.y = obj_player.backtohubY
}