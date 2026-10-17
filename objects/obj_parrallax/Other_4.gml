layers = layer_get_all();
for (var i = 0; i < array_length(layers); i++)
    layers_name[i] = layer_get_name(layers[i])
event_user(0)