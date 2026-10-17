enum XData_Type
{
    INT = 0,
    FLOAT = 1,
    STRING = 2,
	BOOL = 3,
}
globalvar ___tmpxdatafile, ___tmpxdatainf, ___tmpxdatachange;
___tmpxdatafile = -4
___tmpxdatainf = -4
___tmpxdatachange = false
function xdata_open(_file)
{
	___tmpxdatafile = _file
	___tmpxdatainf = ds_map_create()
	___tmpxdatachange = false
	xdata_load()
}
function xdata_close()
{
	if ___tmpxdatafile == -4 exit
	if ___tmpxdatachange xdata_save()
	___tmpxdatafile = -4
	var sections = ds_map_keys_to_array(___tmpxdatainf)
	for (var i = 0; i < array_length(sections); i++)
	{
		var sec = sections[i]
		var sec_map = ___tmpxdatainf[? sec]
		ds_map_destroy(sec_map)
	}
	ds_map_destroy(___tmpxdatainf)
	___tmpxdatainf = -4
	___tmpxdatachange = false
}
function xdata_write(_sec, _key, _val, _type = -4)
{
	if ___tmpxdatafile == -4 exit
    if !ds_map_exists(___tmpxdatainf, _sec) ds_map_add(___tmpxdatainf, _sec, ds_map_create())
	if _type == -4 && is_int32(_val)
		_type = XData_Type.INT
	if _type == -4 && is_bool(_val)
		_type = XData_Type.BOOL
	if _type == -4 && is_real(_val)
		_type = XData_Type.FLOAT
	if _type == -4 && is_string(_val)
		_type = XData_Type.STRING
	if _type == -4
	{
		_type = XData_Type.FLOAT
		_val = real(_val)
	}
	___tmpxdatachange = true
    ___tmpxdatainf[? _sec][? _key] = [_type, _val]
}
function xdata_save()
{
	if ___tmpxdatafile == -4
		exit
	var buf = buffer_create(1024, buffer_grow, 1)
	buffer_write(buf, buffer_u32, ord("X") | (ord("D")<<8) | (ord("A")<<16) | (ord("T")<<24))
	buffer_write(buf, buffer_u32, 1)
	var sections = ds_map_keys_to_array(___tmpxdatainf)
	for (var i = 0; i < array_length(sections); i++)
	{
		var sec = sections[i]
		var sec_map = ___tmpxdatainf[? sec]
		var sec_len = string_length(sec)
		buffer_write(buf, buffer_u8, sec_len)
		for (var k = 1; k <= sec_len; k++)
			buffer_write(buf, buffer_u8, ord(string_char_at(sec, k)))
		buffer_write(buf, buffer_u16, ds_map_size(sec_map))
		var keys = ds_map_keys_to_array(sec_map)
		for (var j = 0; j < array_length(keys); j++)
		{
			var key = keys[j]
			var entry = sec_map[? key]
			var key_len = string_length(key)
			buffer_write(buf, buffer_u8, key_len)
			for (var k = 1; k <= key_len; k++)
				buffer_write(buf, buffer_u8, ord(string_char_at(key, k)))
			buffer_write(buf, buffer_u8, entry[0])
			switch (entry[0])
			{
				case XData_Type.INT:
					buffer_write(buf, buffer_s32, entry[1])
					break
				case XData_Type.FLOAT:
					buffer_write(buf, buffer_f32, entry[1])
					break
				case XData_Type.STRING:
					var slen = string_length(entry[1])
					buffer_write(buf, buffer_u16, slen)
					for (var k = 1; k <= slen; k++)
						buffer_write(buf, buffer_u8, ord(string_char_at(entry[1], k)))
					break
				case XData_Type.BOOL:
					buffer_write(buf, buffer_bool, entry[1])
					break
			}
		}
	}
	var comp_buf = buffer_compress(buf, 0, buffer_tell(buf))
	buffer_save(comp_buf, ___tmpxdatafile)
	buffer_delete(comp_buf)
	buffer_delete(buf)
}
function xdata_load()
{
	if !file_exists(___tmpxdatafile)
		return 0
	try
	{
		var buf = buffer_load(___tmpxdatafile)
		buf = buffer_decompress(buf)
		___tmpxdatainf = ds_map_create()
		var magic = buffer_read(buf, buffer_u32)
		var version = buffer_read(buf, buffer_u32)
		if magic != (ord("X") | (ord("D")<<8) | (ord("A")<<16) | (ord("T")<<24))
		{
			buffer_delete(buf)
			return 0
		}
		while (buffer_tell(buf) < buffer_get_size(buf))
		{
			var sec_len = buffer_read(buf, buffer_u8)
			if sec_len <= 0
				break
			var sec_name = ""
			for (var i = 1; i <= sec_len; i++)
				sec_name += chr(buffer_read(buf, buffer_u8))
			var key_count = buffer_read(buf, buffer_u16)
			var sec_map = ds_map_create()
			for (var k = 0; k < key_count; k++)
			{
				var key_len = buffer_read(buf, buffer_u8)
				var key = ""
				for (var i = 1; i <= key_len; i++)
					key += chr(buffer_read(buf, buffer_u8))
				var type = buffer_read(buf, buffer_u8)
				var val
				switch (type)
				{
					case XData_Type.INT:
						val = buffer_read(buf, buffer_s32)
						break
					case XData_Type.FLOAT:
						val = buffer_read(buf, buffer_f32)
						break
					case XData_Type.STRING:
						var slen = buffer_read(buf, buffer_u16)
						val = ""
						for (var i = 1; i <= slen; i++)
							val += chr(buffer_read(buf, buffer_u8))
						break
					case XData_Type.BOOL:
						val = buffer_read(buf, buffer_bool)
						break
					default:
						val = 0
						break
				}
				sec_map[? key] = [type, val]
			}
			___tmpxdatainf[? sec_name] = sec_map
		}
		buffer_delete(buf)
		return 1
	}
	catch (e)
	{
		show_debug_message("xdata_load failed: " + string(e))
		return 0
	}
}
function xdata_read(_sec, _key, _default)
{
	if ___tmpxdatafile == -4
		return -4
	if ds_map_exists(___tmpxdatainf, _sec) && ds_map_exists(___tmpxdatainf[? _sec], _key)
		return ___tmpxdatainf[? _sec][? _key][1]
	return _default
}
function xdata_section_exists(_sec)
{
	if ___tmpxdatafile == -4
		return 0
	return ds_map_exists(___tmpxdatainf, _sec)
}
function xdata_key_exists(_sec, _key)
{
	if ___tmpxdatafile == -4 || !ds_map_exists(___tmpxdatainf, _sec)
		return 0
	return ds_map_exists(___tmpxdatainf[? _sec], _key)
}