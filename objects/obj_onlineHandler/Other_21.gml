///@description race mode - activate
if idds == 0 && !global.prophuntmode.active
{
	if instance_exists(obj_onlineLevelSelect)
	{
		instance_destroy(obj_onlineLevelSelect)
		exit
	}
	
	if global.racemode.active
	{
		global.racemode.active = 0
		generalReset()
		instance_destroy(obj_onlineRace)
		with obj_player
			image_alpha = 1
		room_goto(Mainmenu)
		with obj_onlineHandler
		{
			lastestMessageNum = wrap(lastestMessageNum+1, 234, 255)
			lastestMessage = "[Server] " + lang_get_phrase("online_racemode_ended")
		}
		exit
	}
	
	with instance_create(0,0,obj_onlineLevelSelect)
	{
		text = "Select a level for race mode"
		selectfunc = function(arg0, arg1)
		{
			with obj_onlineHandler
			{
				global.racemode.room = arg0
				global.racemode.ran = race_ranid
				while global.racemode.ran == race_ranid
					global.racemode.ran = irandom(255)
				race_ranid = global.racemode.ran
				global.racemode.timer = 9
				global.racemode.active = 1
				with obj_player
				{
					generalReset();
					room_goto(global.racemode.room)
					targetRoom = global.racemode.room;
					door = "A";
					global.level = string("race{0}", global.racemode.ran);
					backtohubRoom = Mainmenu;
					backtohubX = 0;
					backtohubY = 0;
					global.resetRoom = global.racemode.room;
					instance_destroy(obj_onlineRace)
					instance_create(0,0,obj_onlineRace)
				}
			}
		}
	}
}