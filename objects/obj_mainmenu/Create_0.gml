roomPaletteIndex = 0;
scene = -2;
menuscale = 0;
moviefade = 255;
moviefadeC = make_color_rgb(moviefade, moviefade, moviefade);
dark = true;
saveFiles = [[],[]];

skip1 = false
skip2 = false
snd1 = FMODcreate_event("event:/Sfx/General/Collects/bigcollect");
snd2 = FMODcreate_event("event:/Sfx/UI/Mainmenu/selectmovie");
FMODSet3dPos(snd1, 960 / 2, 540 / 2)

createSave = function(arg0, arg1 = 0) constructor
{
    file = arg0;
	if arg1
		savePath = wsbMOmInfo.dir + string("sandbox{0}.xda", arg0 + 1);
	else
		savePath = wsbMOmInfo.dir + string("storymo{0}.xda", arg0 + 1);
    movie = {x: 341, y: 253, index: arg0, alpha: 1, scale: 1, scalevel: 0};
    switch (arg0)
    {
        default:
            movie.x = 374;
            movie.y = 232;
        break;
        case 1:
            movie.x = 272;
            movie.y = 239;
        break;
        case 2:
            movie.x = 168;
            movie.y = 246;
        break;
        case 3:
            movie.x = 60;
            movie.y = 253;
        break;
    }
    movie.saveX = movie.x;
    movie.saveY = movie.y;
    xdata_open(savePath);
    created = xdata_read("General", "created", false)
	
    var _current = 0, _levels = ["yard", "shell", "beach"]
	for (var i = 0; i <= 2; i++)
		_current += xdata_read("General", string("Totem{0}", i), false)
    for (var i = 0; i < array_length(_levels); i++)
    {
        var _n = 0
        switch (xdata_read(_levels[i], "Rank", "D"))
        {
            case "D": _current += 0 break
            case "C": _current += 1 break
            case "B": _current += 2 break
            case "A": _current += 3 break
            case "S": _current += 4 break
            case "P": _current += 5 break
        }
    }
    xdata_close()
	var _total = (array_length(_levels) * 5) + 3
    completion = (_current / _total) * 100
	
    faceIndex = (round(completion) / 100) * (sprite_get_number(spr_mainmenu_tomatoface) - 1)
};

selectedFile = -1;
selectedMode = 0;
array_push(saveFiles[0], new createSave(0, 1));
array_push(saveFiles[0], new createSave(1, 1));
array_push(saveFiles[0], new createSave(2, 1));
array_push(saveFiles[0], new createSave(3, 1));
array_push(saveFiles[1], new createSave(0));
array_push(saveFiles[1], new createSave(1));
array_push(saveFiles[1], new createSave(2));
array_push(saveFiles[1], new createSave(3));
hudAlpha = 0;
percentageReal = 0;
percentage = 0;
music = FMODcreate_event("event:/Music/General/mainmenu");
TVsprite = spr_mainmenu_tv;
TVindex = 0;
TVsnd = FMODcreate_event("event:/Sfx/UI/Mainmenu/static");
depth = -300;
created = false;

for (var i = 0; i < array_length(saveFiles[selectedMode]); i++)
{
    if (saveFiles[selectedMode][i].created)
        created = true;
}



hudAlpha = 1;
dark = false;
scene = 0;
selectedFile = 0;
TVsprite = spr_mainmenu_tvStatic;
if saveFiles[selectedMode][selectedFile].created TVsprite = spr_mainmenu_tv;
if created
{
    fmod_studio_event_instance_start(music);
    fmod_studio_event_instance_set_paused(music, false);
}
for (var i = 0; i < array_length(saveFiles[selectedMode]); i++)
{
	var q = saveFiles[selectedMode][i];
	q.faceAlpha = (selectedFile == q.file && q.created) ? 1 : 0
	q.movie.x = (selectedFile == q.file) ? (q.movie.saveX + 80) : q.movie.saveX
	q.movie.y = (selectedFile == q.file) ? (q.movie.saveY - 5) : q.movie.saveY
}