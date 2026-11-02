canProgress = string_length(textVisual) >= string_length(dialogStuff[currentDialog][1])
if !canProgress
{
	var _l = string_char_at(dialogStuff[currentDialog][1], textLetter)
	textVisual += _l
	textLetter++
	alarm[0] = array_contains([".",",","!","?"], _l) ? 6 : ((_l == string_upper(_l) && _l != string_lower(_l)) ? 1 : 2)
    FMODevent_oneshot("event:/Sfx/UI/Pause/step")
}