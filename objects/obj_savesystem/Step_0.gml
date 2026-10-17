saveiconTimer = approach(saveiconTimer,0,1)
saveiconIndex += 0.35
if saveiconIndex > saveiconMax
	saveiconIndex = saveiconIndex mod saveiconMax
saveiconAlpha = approach(saveiconAlpha, (saveiconTimer > 0) ? 1 : 0, 0.1);
