goawayTimer = max(goawayTimer-1, 0);
totemAlpha = approach(totemAlpha, (goawayTimer > 0) ? 1 : 0, 0.01);
