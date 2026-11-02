if (active)
{
    if (mky_jump2 && canProgress)
    {
		if is_callable(dialogStuff[currentDialog][2])
			dialogStuff[currentDialog][2]()
        currentDialog++
        textVisual = ""
        textLetter = 1
        alarm[0] = 1
    }
    else if (mky_jump2 && !canProgress)
    {
		canProgress = true
		textVisual = dialogStuff[currentDialog][1]
		alarm[0] = -1
	    FMODevent_oneshot("event:/Sfx/UI/Pause/step")
    }
    if (currentDialog > (array_length(dialogStuff) - 1))
        instance_destroy();
}
