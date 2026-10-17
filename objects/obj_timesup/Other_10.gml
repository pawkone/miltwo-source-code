ds_list_clear(global.saveroom)
ds_list_copy(global.saveroom, global.lap3checkpoint.saveroom)
ds_list_clear(global.escaperoom)
ds_list_copy(global.escaperoom, global.lap3checkpoint.escaperoom)
global.combo.amt = global.lap3checkpoint.combo_amt
global.combo.dropped = global.lap3checkpoint.combo_dropped
global.toppins = global.lap3checkpoint.toppins
global.collect = global.lap3checkpoint.collect
global.secretCount = global.lap3checkpoint.secret
global.escapeActive = 1
global.escapeTimer = 36
global.escapeLap = 3
with obj_player
{
	targetRoom = global.lap3checkpoint.roomsaved
	door = global.lap3checkpoint.doorsaved
	room_goto(targetRoom)
}