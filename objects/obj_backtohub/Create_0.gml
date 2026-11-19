start = 0;
alpha = 1.1;
fakeVsp = 5;
spd = 0

with obj_onlineHandler
{
	lastestMessageNum = wrap(lastestMessageNum+1, 123, 233)
	lastestMessage = lang_get_phrase("online_level_exit")
}

depth = -600