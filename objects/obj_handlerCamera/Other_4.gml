camera.zoom = 1

layers = layer_get_all()
for (var i = 0; i < array_length(layers); i++)
    layers_name[i] = layer_get_name(layers[i])

var _rmname = room_get_name(room)
if string_count("_secret", _rmname) > 0
	instance_create(0,0,obj_handlerSecret)
if global.modded_betterwaybackyard && string_starts_with(_rmname, "yard_")
	instance_create(0,0,obj_handlerYardDrops)

event_user(0)