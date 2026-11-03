function scr_playerSounds_data()
{
	switch character
	{
		case chars.valenta:
			sfx.step = sfx_valentia_step
			sfx.jump = sfx_valentia_jump
			sfx.taunt = sfx_valentia_taunt
		break
		case chars.milton:
			sfx.ok = [sfx_playerT_idle1, sfx_playerT_idle2, sfx_playerT_idle3, sfx_playerT_idle4]
			sfx.laugh = [sfx_playerT_happy1, sfx_playerT_happy2, sfx_playerT_happy3, sfx_playerT_happy4]
			sfx.gasp = sfx_playerT_fallingmach
			sfx.voice_hurt = [sfx_playerT_hurt1, sfx_playerT_hurt2, sfx_playerT_hurt3, sfx_playerT_hurt4, sfx_playerT_hurt5]
		break
		case chars.pepperni:
			sfx.step = sfx_playerP_step
			sfx.jump = sfx_playerP_jump
			//sfx.machturn = sfx_player_bc_machturn
			//sfx.machend = sfx_player_bc_machend
			//sfx.mach = "sfx_player_bc_mach"
			//sfx.grab = "sfx_player_bc_grab"
			sfx.gasp = -4
		break
		case chars.bacon_crash:
			sfx.step = -4
			sfx.jump = sfx_player_bc_jump
			sfx.machturn = sfx_player_bc_machturn
			sfx.machend = sfx_player_bc_machend
			sfx.mach = "sfx_player_bc_mach"
			sfx.grab = "sfx_player_bc_grab"
			sfx.gasp = -4
		break
		case chars.bacon_dream:
			sfx.step = sfx_player_bd_step
			sfx.jump = sfx_player_bd_jump
			sfx.machturn = sfx_player_bd_machturn
			sfx.machend = sfx_player_bd_machend
			sfx.mach = "sfx_player_bd_mach"
			sfx.grab = "sfx_player_bd_grab"
			sfx.gasp = -4
		break
		case chars.bacon_redem:
			sfx.step = sfx_player_br_step
			sfx.jump = sfx_player_br_jump
			sfx.machturn = sfx_player_br_machturn
			sfx.machend = sfx_player_br_machend
			sfx.mach = "sfx_player_br_mach"
			sfx.grab = "sfx_player_br_grab"
			sfx.gasp = -4
		break
		case chars.bacon_twist:
			sfx.step = sfx_player_br_step
			sfx.jump = sfx_player_br_jump
			sfx.machturn = sfx_player_bt_machturn
			sfx.machend = sfx_player_br_machend
			sfx.mach = "sfx_player_br_mach"
			sfx.grab = "sfx_player_br_grab"
			sfx.gasp = -4
		break
		case chars.preoutman:
			sfx.step = sfx_player_pom_step
			sfx.jump = sfx_player_pom_jump
			sfx.machturn = sfx_player_pom_machturn
			sfx.machend = sfx_player_pom_machend
			sfx.mach = "sfx_player_pom_mach"
			sfx.grab = "sfx_player_pom_grab"
			sfx.sjump = sfx_player_pom_presuperjump
			sfx.sjump_release = sfx_player_pom_superjump
			sfx.rollgetup = sfx_player_pom_rollgetup
			sfx.groundpound = sfx_player_pom_groundpound
			sfx.slam = sfx_player_pom_slam
			sfx.gasp = -4
		break
		case chars.soda:
			sfx.laugh = sfx_playersoda0
			sfx.voice_hurt = -4
			sfx.ok = -4
			sfx.gasp = -4
		break
		case chars.skatenic:
			sfx.step = sfx_skatenic_step
			sfx.jump = sfx_skatenic_jump
			sfx.machturn = sfx_skatenic_machturn
			sfx.machend = sfx_skatenic_machend
			sfx.mach = "sfx_skatenic_mach"
			sfx.grab = "sfx_skatenic_grab"
			sfx.voice_hurt = sfx_skatenic_hurt
			sfx.gasp = -4
		break
	}
}