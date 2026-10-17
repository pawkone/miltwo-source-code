menus = [];
currentmenu = 1;
selected = 1;
move = 0;
menu = 0;
array_push(menus, []);
array_push(menus, []);
var _create = [-4, "CREATE SERVER", function()
{
    menu = 2;
    creating = true;
    keyboard_string = "";
    textInput = "2222";
}];
var _join = [-4, "JOIN SERVER", function()
{
    menu = 1;
    creating = false;
    keyboard_string = "";
    textInput = "";
}];
array_push(menus[1], _create);
array_push(menus[1], _join);
bgx = 0;
textInput = "";
creating = false;
connectIP = "";
connectPort = "";