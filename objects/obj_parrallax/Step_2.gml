if escapeactiveold != global.escapeActive
{
	escapeactiveold = global.escapeActive
	event_user(0)
}
var camx = (camera_get_view_x(view_camera[0])+camera_get_view_width(view_camera[0])/2)-480;
var camy = (camera_get_view_y(view_camera[0])+camera_get_view_height(view_camera[0])/2)-270;
for (var i = 0; i < array_length(layers); i++)
{
	var lay = layers[i]
    switch (layers_name[i])
    {
        case "Foregrounds_1":
            layer_x(lay, camx * -0.15);
            layer_y(lay, camy * -0.15);
            break;
        
        case "Backgrounds_1":
            layer_x(lay, camx * 0.15);
            layer_y(lay, camy * 0.15);
            break;
        
        case "Backgrounds_2":
            layer_x(lay, camx * 0.25);
            layer_y(lay, camy * 0.25);
            break;
        
        case "Backgrounds_3":
            layer_x(lay, camx * 0.35);
            layer_y(lay, camy * 0.35);
            break;
        
        case "Backgrounds_4":
            layer_x(lay, camx * 0.45);
            layer_y(lay, camy * 0.45);
            break;
        
        case "Backgrounds_still1":
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_width(layer_background_get_sprite(back_id)) > 960)
            {
                var amt = sprite_get_width(layer_background_get_sprite(back_id)) - 960;
                layer_x(lay, camx - ((camx / room_width) * amt));
            }
            else
            {
                layer_x(lay, camx);
            }
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_still2":
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_width(layer_background_get_sprite(back_id)) > 960)
            {
                var amt = sprite_get_width(layer_background_get_sprite(back_id)) - 960;
                layer_x(lay, camx - ((camx / room_width) * amt));
            }
            else
            {
                layer_x(lay, camx);
            }
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_stillH1":
            layer_x(lay, camx * 0.15);
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_stillH2":
            layer_x(lay, camx * 0.25);
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_stillH3":
            layer_x(lay, camx * 0.35);
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_stillH4":
            layer_x(lay, camx * 0.45);
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Backgrounds_stillH5":
            layer_x(lay, camx * 0.55);
            var back_id = layer_background_get_id(lay);
            
            if (sprite_get_height(layer_background_get_sprite(back_id)) > 540)
            {
                var amt = sprite_get_height(layer_background_get_sprite(back_id)) - 540;
                layer_y(lay, camy - ((camy / room_height) * amt));
            }
            else
            {
                layer_y(lay, camy);
            }
            
            break;
        
        case "Foregrounds_ground1":
            layer_x(lay, camx * -0.25);
            layer_y(lay, room_height - 540);
            break;
        
        case "Backgrounds_groundscroll1":
            layer_x(lay, (camx * -0.15) + ((layer_get_hspeed(lay) * current_time) / 30));
            layer_y(lay, room_height - 540);
            break;
        
        case "Backgrounds_stillscroll1":
            layer_x(lay, camx + ((layer_get_hspeed(lay) * current_time) / 30));
            layer_y(lay, camy + ((layer_get_vspeed(lay) * current_time) / 30));
            break;
        
        case "Backgrounds_stillscroll2":
            layer_x(lay, camx + ((layer_get_hspeed(lay) * current_time) / 30));
            layer_y(lay, camy + ((layer_get_vspeed(lay) * current_time) / 30));
            break;
        
        case "Assets_bg1":
            layer_x(lay, camx * 0.15);
            layer_y(lay, camy * 0.15);
            break;
        
        case "Backgrounds_waveH1":
            layer_x(lay, wave(0, 50, 4, 10) + (((layer_get_hspeed(lay) * current_time) / 5) * 0.15));
            layer_y(lay, ((layer_get_vspeed(lay) * current_time) / 5) * 0.15);
            break;
        
        case "Backgrounds_waveV1":
            layer_x(lay, ((layer_get_hspeed(lay) * current_time) / 5) * 0.15);
            layer_y(lay, wave(0, 50, 4, 10) + (((layer_get_vspeed(lay) * current_time) / 5) * 0.15));
            break;
        
        case "Backgrounds_zigzag1":
            layer_x(lay, ((layer_get_hspeed(lay) * current_time) / 5) * 0.15);
            layer_y(lay, wave(0, 50, 8, 10) + (((layer_get_vspeed(lay) * current_time) / 5) * 0.15));
            break;
    }
}
