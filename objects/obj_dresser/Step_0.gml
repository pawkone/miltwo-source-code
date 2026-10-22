if (place_meeting(x, y, obj_player))
{
    if (pky_down2 || pky_up2)
    {
		saved = false
		alarm[0] = 120
		
        with (obj_player)
        {
            with (instance_create(x, y, obj_baddiedead))
            {
				image_speed = 0
				image_index = irandom(image_number-1)
                sprite_index = other.sprites.clothes;
                usePalette = true;
                spr_palette = other.sprites.palette;
                paletteIndex = other.palIndex;
                spr_pattern = global.patternSpr;
                patColors = global.PlayerCharacters[other.character].patColors;
                hsp = random_range(-7, 7);
                vsp = random_range(-10, -14);
            }
            
            palIndex += pky_up2 - pky_down2;
			palIndex = wrap(palIndex, 0, sprite_get_width(sprites.palette))
            create_particleStatic(spr_genericpoofeffect, x, y, 1, -1);
            FMODevent_oneshot("event:/Sfx/General/dresser", x, y);
        }
    }
}

textAlpha = approach(textAlpha, place_meeting(x, y, obj_player), 0.1);
indicatorAlpha = approach(indicatorAlpha, indicator, 0.1);
