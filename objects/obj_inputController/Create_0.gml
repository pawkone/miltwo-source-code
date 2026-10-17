count = gamepad_get_device_count()
global.inputMap = {}
global.inputFile = wsbMOmInfo.dir + "input.json"
if !file_exists(global.inputFile)
	reset_input()
else
	global.inputMap = json_parse(loadString(global.inputFile))
global.gamepadConnected = false;
global.gamepadCurrent = -4;
global.gamepadDeadzones = {};
xdata_open(wsbMOmInfo.opt);
global.gamepadDeadzones.horizontal = xdata_read("Deadzones", "horiz", 0.1);
global.gamepadDeadzones.vertical = xdata_read("Deadzones", "verti", 0.2);
global.gamepadDeadzones.general = xdata_read("Deadzones", "general", 0.4);
global.gamepadDeadzones.press = xdata_read("Deadzones", "press", 0.4);
xdata_close();
global.buttonSpr = spr_gamepadbuttons_style1;
global.joystickSpr = spr_joystick_style1;
horizontalStickPressed = false;
verticalStickPressed = false;
horizontalStickPressedR = false;
verticalStickPressedR = false;
event_perform(75, 0);

alarm[0] = 1

globalvar mky_left; globalvar mky_left2;
globalvar mky_right; globalvar mky_right2;
globalvar mky_up; globalvar mky_up2;
globalvar mky_down; globalvar mky_down2;
globalvar mky_jump; globalvar mky_jump2;
globalvar mky_slap; globalvar mky_slap2;
globalvar mky_taunt; globalvar mky_taunt2;
globalvar pky_left; globalvar pky_left2;
globalvar pky_right; globalvar pky_right2;
globalvar pky_up; globalvar pky_up2;
globalvar pky_down; globalvar pky_down2;
globalvar pky_jump; globalvar pky_jump2;
globalvar pky_grab; globalvar pky_grab2;
globalvar pky_taunt; globalvar pky_taunt2;
globalvar pky_run; globalvar pky_run2;
globalvar pky_start; globalvar pky_start2;
globalvar pky_superjump; globalvar pky_superjump2;
globalvar pky_groundpound; globalvar pky_groundpound2;