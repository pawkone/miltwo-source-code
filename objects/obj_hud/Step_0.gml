if hud_postfixOld != hud_postfix
{
	hud_postfixOld = hud_postfix
	if is_callable(hud_scr_clean)
		hud_scr_clean()
	event_user(0)
}
if is_callable(hud_scr_step)
	hud_scr_step()