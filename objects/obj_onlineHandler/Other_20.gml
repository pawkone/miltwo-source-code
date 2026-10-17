///@description hunt mode - activate
if idds == 0 && !global.racemode.active
{
	if instance_exists(obj_onlineLevelSelect)
	{
		instance_destroy(obj_onlineLevelSelect)
		exit
	}
	if global.prophuntmode.active
	{
		global.prophuntmode.active = 0
		generalReset()
		instance_destroy(obj_onlineProphunt)
		with obj_player
			image_alpha = 1
		room_goto(Mainmenu)
		create_notifAsync("Server : " + lang_get_phrase("online_prophunt_ended"))
		exit
	}

	with instance_create(0,0,obj_onlineLevelSelect)
	{
		text = "Select a level for prop hunt"
		selectfunc = function(arg0, arg1)
		{
			with obj_onlineHandler
			{
				var _arr = [0]
				var sockets = ds_map_keys_to_array(plrsconnected)
				array_copy(_arr,1,sockets,0,array_length(sockets))
				var idd = prophunt_oldidd
				while prophunt_oldidd == idd
					idd = _arr[irandom(array_length(_arr)-1)]
				prophunt_oldidd = idd
				
				global.prophuntmode.pickedhunter = idd
				global.prophuntmode.room = arg0
				global.prophuntmode.ran = prophunt_ranid
				while global.prophuntmode.ran == prophunt_ranid
					global.prophuntmode.ran = irandom(255)
				prophunt_ranid = global.prophuntmode.ran
				global.prophuntmode.timer = 25
				global.prophuntmode.waitphase = 1
				global.prophuntmode.active = true
				global.prophuntmode.select = global.prophuntmode.pickedhunter == idds ? -4 : irandom(array_length(global.prophuntmode.sprites)-1)
				
				with (obj_player)
				{
					generalReset();
					room_goto(global.prophuntmode.room)
					state = states.enterdoor
					sprite_index = sprites.walkfront
					targetRoom = global.prophuntmode.room
					door = "A"
					global.level = string("prophunt{0}", global.prophuntmode.ran)
					backtohubRoom = Mainmenu;
					backtohubX = 0;
					backtohubY = 0;
					global.resetRoom = global.prophuntmode.room;
				}
				instance_destroy(obj_onlineProphunt)
				instance_create(0,0,obj_onlineProphunt)
			}
		}
	}
}