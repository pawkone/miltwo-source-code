if (place_meeting(x, y, obj_player))
{
    if (pky_down2 || pky_up2)
    {
		saved = false
		alarm[0] = 120
		
        selected += pky_up2 - pky_down2;
        selected = wrap(selected, 0, array_length(palettes) - 1);
        
        with (obj_player)
        {
            with (instance_create(x, y, obj_baddiedead))
            {
				image_speed = 0
				image_index = irandom(image_number-1)
                sprite_index = obj_player.sprites.clothes;
                usePalette = true;
                spr_palette = obj_player.sprites.palette;
                paletteIndex = other.palIndex;
                spr_pattern = global.patternSpr;
                patColors = global.PlayerCharacters[other.character].patColors;
                hsp = random_range(-7, 7);
                vsp = random_range(-10, -14);
            }
            
            palIndex = other.palettes[other.selected].index;
            create_particleStatic(spr_genericpoofeffect, x, y, 1, -1);
            FMODevent_oneshot("event:/Sfx/General/dresser", x, y);
        }
    }
}

textAlpha = approach(textAlpha, place_meeting(x, y, obj_player), 0.1);
indicatorAlpha = approach(indicatorAlpha, indicator, 0.1);
