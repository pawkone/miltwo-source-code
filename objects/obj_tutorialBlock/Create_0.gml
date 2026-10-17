event_inherited();
xdata_open(global.saveFile);

if (xdata_read("tutorial", "Rank", "NONE") != "NONE")
{
    if (xdata_read("Cutscenes", "TutorialBlock", false) == false)
    {
        alarm[0] = 90;
        xdata_write("Cutscenes", "TutorialBlock", true);
    }
    else
    {
        instance_destroy();
    }
}

xdata_close();
