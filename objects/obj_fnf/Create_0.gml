keys = [ord("A"), ord("S"), ord("K"), ord("L")]
name = "still"
offset = 8.64


global.resetRoom = room
global.level = $"fnf{name}"
y = 500-16
x = 280
colour1 = #00B000
colour2 = #E03000
text_imagescale = 1
iconZoom = 1
collect = 0
collectOld = 0
hp = 1
hpOld = hp
misses = 0
scrollspeed = 1.5
songended = false
gameX = 0
gameY = 0
gameZoom = 1
misses = 0
curTime = 0
curBeat = 0
beat = false
bpm = 100
beatoffset = -4
beatsoffset = -4

scr_music(-4)

var _jsondata = - 4
var parsedJson = loadString($"gameData/misc/chart_{name}.json")
if parsedJson == ""
	parsedJson = [100, [], [[0, 0]], -4, []]
else
{
	parsedJson = json_parse(parsedJson)
	if !variable_struct_exists(parsedJson, "arrows")
	{
		if variable_struct_exists(parsedJson, "format") && (parsedJson.format == "psych_v1" || parsedJson.format == "psych_v1_convert")
		{
			var nt = [], switchcams = [], bpmc = [], curBpm = parsedJson.bpm, time = 0
			for (var i = 0; i < array_length(parsedJson.notes); i++)
			{
			    var note = parsedJson.notes[i]
			    var mustHitSection = note.mustHitSection
			    var sectionNotes = note.sectionNotes
				var sectionBeats = note.sectionBeats
				if variable_struct_exists(note, "changeBPM") && note.changeBPM
				{
					array_push(bpmc, [time, note.bpm])
					curBpm = note.bpm
				}
				array_push(switchcams, [time, mustHitSection])
				time += (time_bpm_to_seconds(curBpm)*1000)*sectionBeats
			    for (var j = 0; j < array_length(sectionNotes); j++)
				{
			        var sectionNote = sectionNotes[j]
					if sectionNote[1] <= 3
						sectionNote[1] += 4
					else if sectionNote[1] >= 4
						sectionNote[1] -= 4
					array_push(nt, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
			    }
			}
			parsedJson = [parsedJson.bpm, nt, switchcams, -4, bpmc]
		}
		else
		{
			var nt = [], switchcams = [], bpmc = [], curBpm = parsedJson.song.bpm, time = 0
			for (var i = 0; i < array_length(parsedJson.song.notes); i++)
			{
			    var note = parsedJson.song.notes[i]
			    var mustHitSection = note.mustHitSection
			    var sectionNotes = note.sectionNotes
				var lengthInSteps = 16
				if variable_struct_exists(note, "lengthInSteps")
					lengthInSteps = note.lengthInSteps
				if variable_struct_exists(note, "changeBPM") && note.changeBPM
				{
					array_push(bpmc, [time, note.bpm])
					curBpm = note.bpm
				}
				array_push(switchcams, [time, mustHitSection])
				time += ((time_bpm_to_seconds(curBpm)*1000)*(lengthInSteps/4))
			    for (var j = 0; j < array_length(sectionNotes); j++)
				{
			        var sectionNote = sectionNotes[j]
					if struct_get(parsedJson.song, "format") == "psych_v1" || mustHitSection
					{
						if sectionNote[1] <= 3
							sectionNote[1] += 4
						else if sectionNote[1] >= 4
							sectionNote[1] -= 4
					}
					array_push(nt, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
			    }
			}
			_jsondata = [parsedJson.song.bpm, nt, switchcams, -4, bpmc]
		}
	}
	else
	{
		var nt = [], switchcams = []
		for (var i = 0; i < array_length(parsedJson.arrows); i++)
		{
		    var sectionNote = parsedJson.arrows[i]
			if array_length(sectionNote) == 1
				array_push(nt, [round(sectionNote[0]), 0, 0])
			else if array_length(sectionNote) == 2
				array_push(nt, [round(sectionNote[0]), sectionNote[1], 0])
			else
				array_push(nt, [round(sectionNote[0]), sectionNote[1], sectionNote[2]])
		}
		for (var i = 0; i < array_length(parsedJson.switchCams); i++)
		{
		    var sectionCam = parsedJson.switchCams[i]
			array_push(switchcams, [sectionCam[0], sectionCam[1]])
		}
		_jsondata = [parsedJson.bpm, nt, switchcams, -4, []]
	}
}
bpm = _jsondata[0]
curBeat = 0
oldCurBeat = -1

notes = _jsondata[1]
triggered = []
for (var i = 0; i < array_length(notes); i++)
	triggered[i] = false

bpmchanges = _jsondata[4]
bpmchangestri = []
for (var i = 0; i < array_length(bpmchanges); i++)
	bpmchangestri[i] = false

instance_create_depth(900,400,0,obj_fnf_charbf)
//instance_create_depth(700,430,0,obj_fnf_chargf)
instance_create_depth(600,400,0,obj_fnf_chardad)

inst = audio_play_sound(asset_get_index($"mu_fnf_{name}_inst"),10,false,,offset)
vocals = audio_play_sound(asset_get_index($"mu_fnf_{name}_vocals"),10,false,,offset)

timer = time_bpm_to_seconds(bpm)*4
audio_pause_sound(inst)
audio_pause_sound(vocals)
countdownspr = -4
countdownalpha = 1
countdowntime = 0

sturmtimer = array_create(8, 0)
sturmpal = array_create(8, 0)

epichitnoteee = function(dirNote, holdNote, distanceToPerfect = 0, endpart = false)
{
	if dirNote >= 4
	{
		obj_fnf.hp += !holdNote ? 0.023 : (0.023/20)
		if !holdNote
		{
			if distanceToPerfect <= 33
				obj_fnf.collect += 350
			else if  distanceToPerfect <= 92
				obj_fnf.collect += 200
			else if distanceToPerfect <= 133
				obj_fnf.collect += 100
			else
				obj_fnf.collect += 50
			with instance_create_depth(0,0,-1000,obj_fnf_rating)
			{
				if distanceToPerfect <= 33
					image_index = 0
				else if  distanceToPerfect <= 92
					image_index = 1
				else if distanceToPerfect <= 133
					image_index = 2
				else
					image_index = 3
			}
		}
		else 
			obj_fnf.collect += 2
	}
	if !holdNote && dirNote >= 4 && distanceToPerfect <= 33
	{
		with instance_create_depth(0,0,0,obj_fnf_arrowspla)
		{
			x = (dirNote>3 ? 288 : 0) + (96+((dirNote mod 4>0)*8 + (dirNote mod 4>2)*8)+dirNote*64)
			y = 64
			pal = 2+dirNote mod 4
		}
	}
	else if holdNote //also for daddy queerest hahahaha!
	{
		with instance_create_depth(0,0,0,obj_fnf_arrowspla)
		{
			x = (dirNote>3 ? 288 : 0) + (96+((dirNote mod 4>0)*8 + (dirNote mod 4>2)*8)+dirNote*64)
			y = 64
			sprite_index = spr_fnf_arrowspla2
			pal = 2+dirNote mod 4
			if !endpart
			{
				var _del = false
				with obj_fnf_arrowspla
				{
					if id != other.id && sprite_index == spr_fnf_arrowspla2 && x == other.x
					{
						_del = true
						if image_index > 3
							image_index = 0
					}
				}
				if _del
					instance_destroy()
			}
			else
			{
				with obj_fnf_arrowspla
				{
					if id != other.id && sprite_index == spr_fnf_arrowspla2 && x == other.x
						instance_destroy()
				}
			}
		}
	}
}