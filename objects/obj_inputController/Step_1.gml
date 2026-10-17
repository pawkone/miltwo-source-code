var _Deadzone = global.gamepadDeadzones.general + global.gamepadDeadzones.press;
_Deadzone = clamp(_Deadzone, 0, 0.99);
if (global.gamepadConnected && !gamepad_is_connected(global.gamepadCurrent))
{
    global.gamepadConnected = false;
    global.gamepadCurrent = -4;
}
if (global.gamepadConnected)
{
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axislh)) < _Deadzone)
        horizontalStickPressed = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axislv)) < _Deadzone)
        verticalStickPressed = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axisrh)) < _Deadzone)
        horizontalStickPressedR = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axisrv)) < _Deadzone)
        verticalStickPressedR = false;
}


mky_left = -read_input("menu_left");
mky_left2 = -read_input("menu_left", true);
mky_right = read_input("menu_right");
mky_right2 = read_input("menu_right", true);
mky_up = read_input("menu_up");
mky_up2 = read_input("menu_up", true);
mky_down = read_input("menu_down");
mky_down2 = read_input("menu_down", true);
mky_jump = read_input("menu_confirm");
mky_jump2 = read_input("menu_confirm", true);
mky_slap = read_input("menu_back");
mky_slap2 = read_input("menu_back", true);
mky_taunt = read_input("menu_clear");
mky_taunt2 = read_input("menu_clear", true);

pky_left = -read_input(global.modifiers.flipped ? "right" : "left");
pky_left2 = -read_input(global.modifiers.flipped ? "right" : "left", true);
pky_right = read_input(global.modifiers.flipped ? "left" : "right");
pky_right2 = read_input(global.modifiers.flipped ? "left" : "right", true);
pky_up = read_input("up");
pky_up2 = read_input("up", true);
pky_down = read_input("down");
pky_down2 = read_input("down", true);
pky_jump = read_input("jump");
pky_jump2 = read_input("jump", true);
pky_grab = read_input("slap");
pky_grab2 = read_input("slap", true);
pky_taunt = read_input("taunt");
pky_taunt2 = read_input("taunt", true);
pky_run = read_input("attack");
pky_run2 = read_input("attack", true);
pky_start = read_input("start");
pky_start2 = read_input("start", true);
pky_superjump = read_input("superjump");
pky_superjump2 = read_input("superjump", true);
pky_groundpound = read_input("groundpound");
pky_groundpound2 = read_input("groundpound", true);
