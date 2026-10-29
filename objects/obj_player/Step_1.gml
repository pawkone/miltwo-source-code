isMildred = character == chars.mildred || character == chars.valentia || character == chars.soda

if (pky_jump2)
    jumpBuffer = 15;
if (pky_grab2)
    slapBuffer = 15;
jumpBuffer = approach(jumpBuffer, 0, 1);
slapBuffer = approach(slapBuffer, 0, 1);
playerSounds();

if (supertaunt >= 10 && !canSupertaunt)
{
    canSupertaunt = true;
    flash = true;
    FMODevent_oneshot("event:/Sfx/Player/gotsupertaunt", x, y);
}
else if (supertaunt < 10 && canSupertaunt)
    canSupertaunt = false;

if (characterOld != character)
	event_user(0)
