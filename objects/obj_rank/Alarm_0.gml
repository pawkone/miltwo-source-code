if (textPos < array_length(text))
{
    FMODevent_oneshot("event:/Sfx/Player/punch", 960 / 2, 540 / 2);
    shake = 15;
    text[textPos][0] = true;
    textPos++;
    alarm[0] = 40;
}
else
{
    canContinue = true;
}
