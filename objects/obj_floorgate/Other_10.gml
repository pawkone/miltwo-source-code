if openned == 0
{
	FMODevent_oneshot("event:/Sfx/Player/slam", x, y);
	FMODevent_oneshot("event:/Sfx/Player/punch", x, y);
}
else
{
	FMODevent_oneshot("event:/Sfx/General/Level/breakblock", x, y)
	FMODevent_oneshot("event:/Sfx/General/Enemy/dart", x, y)
}