uparrow = 0
angle = 0
ylerpname = 0
toppingstr = [obj_potable0, obj_potable1, obj_potable2, obj_potable3, obj_potable4]

character = chars.mildred;
isMildred = false
characterOld = character
event_user(0)
depth = 0;
image_speed = 0.35;
scr_collision_init();
grav = 0.5;
spr_palette = spr_playerPal;
palIndex = 1;
jumpstop = false;
door = "A";
state = states.normal;
movespeed = 0;
verticalMovespeed = 0;
xscale = 1;
xscaleMulti = 1;
yscaleMulti = 1;
poletreeID = -4;
chargeeffect = -4;
buffers = {};
buffers.step = 0;
buffers.bigdashcloud = 0;
buffers.idle = 180;
buffers.afterimageMach = 0;
buffers.afterimageBlur = 0;
buffers.dashcloud = 0;
buffers.crazyothereffect = 0;
buffers.breakdanceheld = 0;
buffers.notes = 0;
buffers.hammer = 0;
breakdancespeed = 0;
breakdanceID = -4;
jumpBuffer = false;
slapBuffer = false;
flash = false;
rainbow = 0;
super = false;
speedlineseffect = -4;
hitstun = {};
hitstun.x = x;
hitstun.y = y;
hitstun.time = 0;
hitstun.is = false;
roomstartX = x;
roomstartY = y;
hallway = false;
hallwayDirection = xscale;
instakill = false;
tauntVars = 
{
    sprite_index: sprite_index,
    image_index: image_index,
    state: state,
    vsp: vsp,
    hsp: hsp,
    movespeed: movespeed,
    image_speed: image_speed
};
tauntTimer = 0;
freefallsmash = -4;
crouchslip = 0;
wallgrab = 0;
enemyID = -4;
i_frame = 0;
coyote_time = 0;
mach4mode = false;
movespeedSurfing = 0;
diveboardSaved = {};
diveboardSaved.movespeed = movespeed;
diveboardSaved.state = state;
diveboardSaved.sprite_index = sprite_index;
diveboardSaved.image_index = image_index;
diveboardSaved.y = y;
backtohubRoom = room;
backtohubX = x;
backtohubY = y;
prevOnSlope = false;
onSlope = false;
slopeObj = -4;
wasRamp = false;
aimTime = 0;
canHit = true;
sprayCans = 4;
supertaunt = 0;
canSupertaunt = false;
squashX = 1;
squashY = 1;
freefalling = 0;
alarm[1] = irandom_range(5, 15);
