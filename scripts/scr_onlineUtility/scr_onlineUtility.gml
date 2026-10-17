function send_data(arg0)
{
    var _buff = buffer_create(12, buffer_grow, 1);
    buffer_seek(_buff, buffer_seek_start, 0);
    var q = json_stringify(arg0, true);
    buffer_write(_buff, buffer_string, q);
    obj_onlineHandler.network_send_packetServ(_buff, buffer_tell(_buff));
    buffer_delete(_buff);
}

function instance_create_online(arg0, arg1, arg2, arg3, arg4 = {})
{
	/*
	if instance_exists(obj_onlineHandler)
	{
	    var struct = {};
	    struct.x = arg0;
	    struct.y = arg1;
	    struct.depth = arg2;
	    struct.obj = arg3;
	    struct.room = room;
	    struct.onlineID = obj_onlineHandler.onlineID;
	    struct.type = networkpacket.instance;
	    struct.vars = arg4;
	    send_data(struct);
	}
	*/
}

function FMODevent_oneshot_online(arg0, arg1 = "", arg2 = "")
{
	/*
	if instance_exists(obj_onlineHandler)
	{
	    var struct = {};
	    struct.arg0 = arg0;
	    struct.arg1 = arg1;
	    struct.arg2 = arg2;
	    struct.room = room;
	    struct.onlineID = obj_onlineHandler.onlineID;
	    struct.type = networkpacket.sound;
		struct.fmod = true
	    send_data(struct);
	}
	*/
}

function scr_soundeffect_online(arg0, arg1 = 1, arg2 = true)
{
	/*
	if instance_exists(obj_onlineHandler)
	{
	    var struct = {};
	    struct.arg0 = arg0;
	    struct.arg1 = arg1;
	    struct.arg2 = arg2;
	    struct.room = room;
	    struct.onlineID = obj_onlineHandler.onlineID;
	    struct.type = networkpacket.sound;
		struct.fmod = false
	    send_data(struct);
	}
	*/
}

