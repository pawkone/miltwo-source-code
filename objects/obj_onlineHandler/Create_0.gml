enum networkpacket
{
	notification,
	player,
	mode,
}

ip = "localhost"
port = 2222

playerupdate = 0

if global.server < 0
{
	idds = 0
	while idds == 0
		idds = irandom(4294967294)
}
else
{
	prophunt_oldidd = 0
	race_ranid = 0
	prophunt_ranid = 0
	idds = 0
}

plrs = ds_map_create()
plrsconnected = ds_map_create()

notifs = []
oldplayer = {
	x: 0,
	y: 0,
	sprite_index: -4,
	image_index: 0,
	xscale: 0,
	image_alpha: 0,
	image_blend: 0,
	flash: 0,
	state: 0,
	depth: 0,
	spr_palette: 0,
	palIndex: 0,
	breakdance: 0,
	npvariableindex: 0,
}

playerBuff = buffer_create(256, buffer_fixed, 1);

network_send_packetServ = function(buff, size)
{
	if global.server < 0 && global.client < 0 exit
	if global.server >= 0
	{
		var sockets = ds_map_keys_to_array(plrs)
		for (var i = 0; i < array_length(sockets); i++)
		{
			var _dsmap = ds_map_find_value(plrs, sockets[i])
			network_send_udp(global.server, _dsmap[0], _dsmap[1], buff, size)
		}
	}
	else if global.client >= 0
		network_send_udp(global.client, ip, port, buff, size)
};

create_notifAsync = function(arg0)
{
    var buff = buffer_create(192, buffer_fixed, 1)
    buffer_write(buff, buffer_u8, networkpacket.notification)
	buffer_write(buff, buffer_string, arg0)
    self.network_send_packetServ(buff, buffer_get_size(buff))
    buffer_delete(buff);
	
	scr_soundeffect(sfx_pop, random_range(0.98,1.02))
    array_push(notifs, [string_lower(arg0), 400])
};
