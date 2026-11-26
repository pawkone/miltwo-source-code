//endsong system
if timer > 0
{
	var _oldtimer = timer
	timer -= 1/60
	
	audio_pause_sound(inst)
	audio_pause_sound(vocals)
	
	beat = false
	
	var _o = time_bpm_to_seconds(bpm), _asts = [sfx_fnf_countdown1, sfx_fnf_countdown2, sfx_fnf_countdown3, sfx_fnf_countdown4]
	for (var i = 1; i <= 4; i++)
	{
		if _oldtimer >= _o*i && timer < _o*i
		{
			if i < 4
			{
				countdownspr = i-1
				countdownalpha = 1
				countdowntime = 1
			}
			oldCurBeat = -i
			curBeat = oldCurBeat
			beat = true
			audio_play_sound(_asts[i-1],1,false,0.5,0,1)
			break
		}
	}

	countdownalpha = countdowntime-(power(countdowntime,10)/100)
	countdowntime -= 1/60/_o
	curTime = (timer*-1000)
	if timer <= 0
	{
		timer = 0
		curTime = 0
		audio_resume_sound(inst)
		audio_resume_sound(vocals)
	}
}
else
{
	if !audio_is_playing(inst)
	{
		if !songended
		{
			songended = true
			instance_destroy(all)
		}
		exit
	}
	
	curTime = lerp(curTime, audio_sound_get_track_position(inst)*1000, curTime <= 0 ? 1 : 0.5)
	
	if name == "still" && curTime > 127.3*1000
	{
		with obj_fnf_chardad
		{
			depth = -100
			if sprite_index != spr_fnf_dadidle2
			{
				image_index = 0
				sprite_index = spr_fnf_dadidle2
			}
		}
		exit
	}
	
	//bpm system
	for (var i = 0; i < array_length(bpmchanges); i++)
	{
		var bpmcha = bpmchanges[i]
		if !bpmchangestri[i] && curTime >= bpmcha[0]
		{
			bpmchangestri[i] = true
			beatoffset = bpmcha[0]/1000
			beatsoffset = floor((curTime/1000) / (60 / bpm))
			bpm = bpmcha[1]
		}
	}
	if beatoffset != -4
		curBeat = beatsoffset + floor(((curTime/1000)-beatoffset) / (60 / bpm))
	else
		curBeat = floor((curTime/1000) / (60 / bpm))
	if curBeat != oldCurBeat
	{
		oldCurBeat = curBeat
		beat = true
	}
	else
		beat = false
}

//bopppp canmeraa and icons
if beat
{
	iconZoom += 0.08 * ((curBeat mod 2 == 0) + 1)
	gameZoom += 0.025 * ((curBeat mod 2 == 0) + 1)
}
iconZoom = approach(lerp(iconZoom, 1, 0.1), 1, 0.0025)

//HOLD NOTES
with (obj_fnf_arrowhold)
{
    var key = noone
	if dir >= 4 && dir <= 7
		key = other.keys[dir-4]
	var dist = abs(other.curTime - note_time)
	if dist <= 35
	{
	    if keyboard_check(key)
		{
			if audio_exists(obj_fnf.vocals)
				audio_sound_gain(obj_fnf.vocals, 1, 0)
			other.epichitnoteee(dir, true, dist, endpart)
			if obj_fnf.sturmtimer[dir] < 0.5
			{
			    with (obj_fnf_charbf)
			    {
			        singtime = 0.9
					image_index = 0
					switch other.dir
			        {
			            case 0: sprite_index = spr_left break
						case 1: sprite_index = spr_down break
						case 2: sprite_index = spr_up break
						case 3: sprite_index = spr_right break
					}
			    }
				obj_fnf.sturmtimer[dir] = 1
			}
		    instance_destroy()
		}
	}
}

//SIGNLE NOTES
for (var d = 4; d <= 7; d++)
{
    var key = noone
	if d >= 4 && d <= 7
		key = keys[d-4]
    if keyboard_check_pressed(key)
    {
        var nearest_note = noone
        var nearest_dist = 999999
        with (obj_fnf_arrow)
        {
			if dir == d
			{
				var dist = abs(other.curTime - note_time)
				if dist <= 100 && dist < nearest_dist
	            {
	                nearest_note = id
	                nearest_dist = dist
	            }
			}
        }
        if nearest_note != noone // DIDN'T MISS
        {
			if audio_exists(vocals)
				audio_sound_gain(vocals, 1, 0)
			with nearest_note
            {
				other.epichitnoteee(d, false, abs(other.curTime - note_time))
                with obj_fnf_charbf
                {
                    singtime = 0.9
					image_index = 0
					switch d
			        {
			            case 0: sprite_index = spr_left break
						case 1: sprite_index = spr_down break
						case 2: sprite_index = spr_up break
						case 3: sprite_index = spr_right break
					}
                }
				other.sturmtimer[d] = 1
                instance_destroy()
            }
        }
    }
}
if hp < 0
{
	global.escapeLap = 3
	global.escapeTimer = 0
	ds_list_clear(global.lap3checkpoint.saveroom)
	ds_list_clear(global.lap3checkpoint.escaperoom)
	ds_list_copy(global.lap3checkpoint.saveroom, global.saveroom)
	ds_list_copy(global.lap3checkpoint.escaperoom, global.escaperoom)
	global.lap3checkpoint.collect = global.collect
	global.lap3checkpoint.combo_amt = global.combo.amt
	global.lap3checkpoint.combo_dropped = global.combo.dropped
	global.lap3checkpoint.secret = global.secretCount
	global.lap3checkpoint.roomsaved = room
	global.lap3checkpoint.doorsaved = obj_player.door
	global.lap3checkpoint.toppins = global.toppins
	room_goto(timesup_room)
}
if hp > 2
	hp = 2

//NOTE SPAWNING SYSTEM
for (var i = 0; i < array_length(notes); i++)
{
	var note = notes[i]
	if !triggered[i] && curTime >= note[0] - (2500 / scrollspeed) - 540
	{
		triggered[i] = true
		with(instance_create_depth(0, 0, -1000, obj_fnf_arrow))
		{
			scrollspeed = other.scrollspeed
			note_time = note[0]
			dir = note[1]
			pal = 2+dir mod 4
			x = (dir>3 ? 288 : 0) + (96+((dir mod 4>0)*8 + (dir mod 4>2)*8)+dir*64)
			y = 99999
			var _a = dir mod 4
			image_angle = _a == 0 ? 90 : (_a == 1 ? 180 : (_a == 2 ? 0 : 270))
			if note[2] == 0
				break
			for (var j = 60; round(note[2]) > j; j += 20)
			{
				with(instance_create_depth(0, 0, -999, obj_fnf_arrowhold))
				{
					scrollspeed = other.scrollspeed
					pal = other.pal
					note_time = note[0] + j
					dir = note[1]
					x = other.x
					y = 99999
					endpart = round(note[2]) < j + 11
					image_index = endpart ? 2 : 1
				}
			}
		}
	}
}

for (var i = 0; i < array_length(sturmtimer); i++)
{
	if sturmtimer[i] == 1
		sturmpal[i] = 2+(i mod 4)
	else if sturmtimer[i] <= 0
	{
		if i > 3
		{
			var _k = obj_fnf.keys[i-4]
			if keyboard_check_pressed(_k)
				sturmpal[i] = 1
			else if !keyboard_check(_k)
				sturmpal[i] = 0
		}
		else
			sturmpal[i] = 0
	}
	sturmtimer[i] = approach(sturmtimer[i], 0, 0.1)
}

//making camera acutltyasyaqyu do shit
var _mGP_gameX = 0, _mGP_gameY = 0, _obj = -4
if instance_exists(obj_fnf_chardad) && obj_fnf_chardad.singtime > 0 && !obj_fnf_charbf.singtime > 0
	_obj = obj_fnf_chardad
else if instance_exists(obj_fnf_charbf)
	_obj = obj_fnf_charbf
if instance_exists(_obj)
{
	with _obj
	{
		if sprite_index == spr_left
			_mGP_gameX -= 24
		else if sprite_index == spr_down
			_mGP_gameY += 24
		else if sprite_index == spr_up
			_mGP_gameY -= 24
		else if sprite_index == spr_right
			_mGP_gameX += 24
	}
	_mGP_gameX = _obj.x+_obj.camOffset[0]+_mGP_gameX
	_mGP_gameY = _obj.y+_obj.camOffset[1]+_mGP_gameY
	gameX = approach(lerp(gameX,_mGP_gameX,0.1),_mGP_gameX,0.01)
	gameY = approach(lerp(gameY,_mGP_gameY,0.1),_mGP_gameY,0.01)
}
gameZoom = approach(lerp(gameZoom, 1, 0.1), 1, 0.0025)
with obj_handlerCamera
{
	state = -4
	camera.zoom = clamp(2-other.gameZoom,0.01,10)
	camera.x = other.gameX
	camera.y = other.gameY
}