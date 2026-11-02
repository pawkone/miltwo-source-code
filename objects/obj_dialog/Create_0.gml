dialogStuff = [];
currentDialog = 0;
active = false;
addDialog = function(spr, img, text, func = -4){array_push(dialogStuff, [spr,text,func,img])}
textVisual = "";
textLetter = 1;
canProgress = false;
