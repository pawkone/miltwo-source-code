global.songCurInf = {};
pitchLrp = 1
musicDetails = ds_map_create();
music = 
{
    regular: "",
    secret: ""
};
isSecretStart = false
musicInst = -4;
secretInst = -4;
isSecret = false;
lock = false;
panicStart = false;
playingSecret = false;
monolith = FMODcreate_event("event:/Music/General/monolith");
escapeInst = FMODcreate_event("event:/Music/General/escape");
pillar = 0;
voices = 1;
savedMusicPosition = 0;
musicPos = 0;
currentMusic = "";
pauseMusic = false;

stop_music = function(externaltoo = true, _instant = false)
{
	with obj_music
	{
	    if (musicInst != -4)
		{
	        fmod_studio_event_instance_stop(musicInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
	        fmod_studio_event_instance_release(musicInst);
	    }
	    if (secretInst != -4)
	    {
	        fmod_studio_event_instance_stop(secretInst, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
	        fmod_studio_event_instance_release(secretInst);
	    }
		if externaltoo
			scr_music(-4, !_instant)
	
	    musicInst = -4;
	    secretInst = -4;
	    music = 
	    {
	        regular: "",
	        secret: ""
	    };
	    savedMusicPosition = 0;
	    isSecret = false;
	}
};

add_music = function(arg0, arg1, arg2, arg3 = function()
{
}) constructor
{
    music = arg0;
    secret = arg1;
    func = arg3;
};
ds_map_add(musicDetails, yard_1, new add_music("event:/Music/W1/Monolith Mangrove/mangrove", "event:/Music/W1/Monolith Mangrove/mangrovesecret", -4, function()
{
    var _s = 0;
    
    if (room == yard_9 || room == yard_10 || room == yard_11)
        _s = 1;
    
    fmod_studio_event_instance_set_parameter_by_name(musicInst, "state", _s);
}));
ds_map_add(musicDetails, hotel_start, new add_music("event:/Music/W1/hub", -4, -4));
ds_map_add(musicDetails, hotel_1, new add_music("event:/Music/W1/hub", -4, -4));
ds_map_add(musicDetails, tutorial_1, new add_music("event:/Music/W1/tutorial", -4, -4));
//ds_map_add(musicDetails, shell_1, new add_music("event:/Music/W1/Shell City/city", "event:/Music/W1/Shell City/citysecret", -4));
ds_map_add(musicDetails, beach_1, new add_music("event:/Music/W1/Berry Beach/shores", "event:/Music/W1/Berry Beach/shoressecret", -4));
ds_map_add(musicDetails, castle_1, new add_music("event:/Music/W2/Castle Pumpkinstein/castle", -4, -4));
ds_map_add(musicDetails, Levelselect, new add_music("event:/Music/Ost/mainmenu", -4, -4));
ds_map_add(musicDetails, Mainmenu, new add_music(-4, -4, -4));

captions = {}
captions.file = ""
captions.str = []
captions.timing = []
captions.toggle = 1
captions.vsp = 0
captions.y2 = 0
captions.yy = 0
captions.old = -1
captions.curtime = 0