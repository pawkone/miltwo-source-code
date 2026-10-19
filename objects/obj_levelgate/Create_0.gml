image_speed = 0;
depth = 50;

gateinfo = [];

distance = 100
surf = -4
cancel = false
notext = false

function create_gate_layer(sprite, index, bgx_offest, bgy_offest, bgx_sp, bgy_sp, bg_parallax = false)
{
    array_push(gateinfo, [sprite, index, bgx_offest, bgy_offest, bgx_sp, bgy_sp, bg_parallax])
}

levelname = ""
titlecard = [spr_titlecardYard,
spr_titlecardYardTitle1,
spr_titlecardYardTitle2,
"event:/Music/W1/Monolith Mangrove/titlecard"]

alarm[0] = 1
bgalpha = 1;
visibleradius = 250;
textalpha = 0;
drawing = 0;
scoreViewer = -4;
