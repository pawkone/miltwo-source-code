if (fadeout == false)
    blackAlpha = approach(blackAlpha, 0, 0.01);
else if (fadeout == true)
    blackAlpha = approach(blackAlpha, 1, 0.01);

switch (scene)
{
    case 0:
        if (blackAlpha == 0 && alarm[1] <= 0 && !fadeout)
            alarm[1] = 120;
        
        if ((fadeout && blackAlpha == 1) || mky_jump2)
        {
			showMiltu = false;
            showFmod = false;
            showHeart = true;
            scene++
            fadeout = false;
        }
        
        break;
		
    case 1:
        if (blackAlpha == 0 && alarm[1] <= 0 && !fadeout)
            alarm[1] = 120;
        
        if ((fadeout && blackAlpha == 1) || mky_jump2)
        {
            showFmod = true;
            showHeart = false;
            scene++
            fadeout = false;
        }
        
        break;
    
    case 2:
        if (blackAlpha == 0 && alarm[1] <= 0 && !fadeout)
            alarm[1] = 120;
        
        if ((fadeout && blackAlpha == 1) || mky_jump2)
            room_goto(Mainmenu);
        
        break;
}
