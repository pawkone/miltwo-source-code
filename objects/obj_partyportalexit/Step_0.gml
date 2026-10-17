if (cutscene)
{
    visible = true;
    
    if (animation_end())
        instance_destroy();
    
    if (obj_player.state == -4)
    {
        obj_player.xscaleMulti = 0;
        obj_player.yscaleMulti = 0;
        
        with (obj_player)
        {
            x = other.xstart;
            y = other.ystart;
        }
        
        if (floor(image_index) == 7)
        {
            instance_create(x, y, obj_lap2visual);
			if global.escapeLap >= 2
			{
				global.escapeLap = 3
				global.escapeTimer = 0
				ds_list_clear(global.lap3checkpoint.saveroom)
				ds_list_clear(global.lap3checkpoint.escaperoom)
				ds_list_copy(global.lap3checkpoint.saveroom, global.saveroom)
				ds_list_copy(global.lap3checkpoint.escaperoom, global.escaperoom)
				global.lap3checkpoint.collect = global.collect
				global.lap3checkpoint.combo_amt = global.combo.amt
				global.lap3checkpoint.combo_dropped = global.combo.dropped
				global.lap3checkpoint.secret = global.secretCount
				global.lap3checkpoint.roomsaved = room
				global.lap3checkpoint.doorsaved = obj_player.door
				global.lap3checkpoint.toppins = global.toppins
			}
			else
				global.escapeLap = 2
            with (obj_player)
            {
                jumpstop = true;
                vsp = 5;
                sprite_index = sprites.fall;
                state = states.jump;
                xscaleMulti = 1;
                yscaleMulti = 1;
            }
        }
    }
}
