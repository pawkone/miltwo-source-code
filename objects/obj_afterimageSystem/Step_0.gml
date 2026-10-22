if premode
{
	ds_list_clear(afterimages)
	exit
}
if (!ds_list_empty(afterimages))
{
    for (var i = 0; i < ds_list_size(afterimages); i++)
    {
        var q = ds_list_find_value(afterimages, i);
        
        with (q)
        {
            switch (type)
            {   
                case afterimagetype.blur:
				case afterimagetype.dreamAttack:
					if type == afterimagetype.dreamAttack
						image_alpha -= 0.05;
					else
						image_alpha -= 0.15;
                    
                    if (image_alpha <= 0)
                    {
                        with (other)
                        {
                            q = undefined;
                            ds_list_delete(afterimages, i);
                            i--;
                        }
                    }
                    
                    break;
                
                case afterimagetype.selectcolor:
                    image_alpha -= 0.05;
                    
                    if (image_alpha <= 0)
                    {
                        with (other)
                        {
                            q = undefined;
                            ds_list_delete(afterimages, i);
                            i--;
                        }
                    }
                    
                    break;
					
                case afterimagetype.dreamMach:
				case afterimagetype.twistMach1:
				case afterimagetype.twistMach2:
                    for (var r = 0; r < array_length(alarm); r++)
                    {
                        if (alarm[r] >= 0)
                            alarm[r]--;
                    }
                    
                    if (alarm[1] == 0)
                    {
                        image_alpha = 0;
                        alarm[2] = 2;
                    }
                    
                    if (alarm[2] == 0)
                    {
                        image_alpha = 1;
                        alarm[2] = 2;
                    }
                    
                    if (alarm[0] == 0)
                    {
                        with (other)
                        {
                            q = undefined;
                            ds_list_delete(afterimages, i);
                            i--;
                        }
                    }
                    
                    break;
					
                default:
                    for (var r = 0; r < array_length(alarm); r++)
                    {
                        if (alarm[r] >= 0)
                            alarm[r]--;
                    }
                    
                    visible = other.blink;
                    
                    if (alarm[0] == 0)
                        fadeout = true;
                    
                    alpha = clamp(alpha, 0, 0.65);
                    
                    if (fadeout == true)
                    {
                        fadeoutAlpha = approach(fadeoutAlpha, 0, 0.15);
                        
                        if (fadeoutAlpha == 0)
                        {
                            with (other)
                            {
                                q = undefined;
                                ds_list_delete(afterimages, i);
                                i--;
                            }
                        }
                    }
                    
                    break;
            }
			if onlineDelay-- == 0
			{
				if instance_exists(obj_multiplayerHandler)
				{
					var _size = 32, _data = []
					array_push(_data, buffer_u8, multiplayerType.createAfterimage)
					array_push(_data, buffer_u16, room)
					array_push(_data, buffer_u8, obj_multiplayerHandler.plrId)
					array_push(_data, buffer_u8, image_alpha*255)
					array_push(_data, buffer_u8, fadeoutAlpha*255)
					array_push(_data, buffer_u8, alpha*255)
					array_push(_data, buffer_u8, type)
					array_push(_data, buffer_u32, image_blend)
					with obj_multiplayerHandler
					{
						if isHost
							sendDataHost(_data, _size)
						else
							sendDataClient(_data, _size)
					}
				}
			}
        }
    }
}
