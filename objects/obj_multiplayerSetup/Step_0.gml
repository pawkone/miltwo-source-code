if !instance_exists(obj_player)
	exit

obj_player.state = -4;
obj_player.x = -100;
obj_player.y = -100;

selectedlrp = lerp(selectedlrp, selected, 0.1)

if bgsfadebuffer-- < 0
{
	bgsfade = approach(bgsfade, 1, 1/60)
	if bgsfade >= 1
	{
		bgsfadebuffer = floor(random_range(5, 10)*60)
		var bgsselold = bgssel
		while bgssel == bgsselold
			bgssel = irandom(array_length(bgs)-1)
	}
}
else
	bgsfade = approach(bgsfade, 0.25, 1/60)
bgx = bgx+1 mod 3840;

if (menu == 0)
{
	if (mky_slap2)
		menus[0][2]()
    var m = mky_down2 - mky_up2;
    if (m != 0)
    {
        selected += m;
        selected = clamp(selected, 0, array_length(menus) - 1);
    }
    if (mky_jump2)
        menus[selected][2]();
}
else
{
    if keyboard_check_pressed(vk_escape)
    {
        menu = 0;
		exit
    }
	if menu == 3 //change player info menu tuff
		exit
	if menu == 2
	{
		room_goto(Mainmenu)
		instance_destroy(obj_multiplayerHandler)
		with instance_create(0,0,obj_multiplayerHandler)
		{
			ip = other.connectIP
			isHost = other.creating
		}
		exit
	}
	if keyboard_check(vk_control) && keyboard_check(ord("V"))
	{
		keyboard_string = clipboard_get_text();
		textInput = keyboard_string;
	}
    if keyboard_check_pressed(vk_enter)
    {
        connectIP = textInput
        menu = 2
    }
	else
		textInput = keyboard_string;
}
