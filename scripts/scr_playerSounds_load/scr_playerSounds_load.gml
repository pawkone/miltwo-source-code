function scr_playerSounds_loadcheck(str, event)
{
	if !struct_exists(sfx, str)
		struct_set(sfx, str, event)
}
function scr_playerSounds_release(str)
{
	if struct_exists(sfx, str)
	{
		var _sfx = struct_get(sfx, str)
		if is_real(_sfx)
			fmod_studio_event_instance_release(_sfx)
	}
}
function scr_playerSounds_load()
{
	if !variable_instance_exists(id, "sfx") sfx = {}
	
	scr_playerSounds_release("laugh")
	scr_playerSounds_release("mach")
	scr_playerSounds_release("sjump")
	scr_playerSounds_release("roll")
	scr_playerSounds_release("groundpound")
	scr_playerSounds_release("grab")
	scr_playerSounds_release("hammer")
	scr_playerSounds_release("hammerair")
	scr_playerSounds_release("skateboard")
	scr_playerSounds_release("skateaim")
	
	sfx = {}
	
	switch character
	{
		case chars.valentia:
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
			sfx.laugh = sfx_soda
		break
	}
	
	scr_playerSounds_loadcheck("taunt", "event:/Sfx/Player/taunt")
	scr_playerSounds_loadcheck("step", "event:/Sfx/Player/step")
	scr_playerSounds_loadcheck("jump", "event:/Sfx/Player/jump")
	scr_playerSounds_loadcheck("machturn", "event:/Sfx/Player/machturn")
	scr_playerSounds_loadcheck("machend", "event:/Sfx/Player/machend")
	scr_playerSounds_loadcheck("sjump_release", "event:/Sfx/Player/superjumprelease")
	scr_playerSounds_loadcheck("rollgetup", "event:/Sfx/Player/rollgetup")
	scr_playerSounds_loadcheck("slam", "event:/Sfx/Player/slam")
	scr_playerSounds_loadcheck("ok", "event:/Sfx/Player/yeag")
	scr_playerSounds_loadcheck("laugh", "event:/Sfx/Player/yay")
	scr_playerSounds_loadcheck("gasp", "event:/Sfx/Player/gasp")
	scr_playerSounds_loadcheck("voice_hurt", -4)
	scr_playerSounds_loadcheck("mach", FMODcreate_event("event:/Sfx/Player/mach"))
	scr_playerSounds_loadcheck("sjump", FMODcreate_event("event:/Sfx/Player/superjump"))
	scr_playerSounds_loadcheck("roll", FMODcreate_event("event:/Sfx/Player/tumble"))
	scr_playerSounds_loadcheck("groundpound", FMODcreate_event("event:/Sfx/Player/groundpound"))
	scr_playerSounds_loadcheck("grab", FMODcreate_event("event:/Sfx/Player/dash"))
	scr_playerSounds_loadcheck("hammer", FMODcreate_event("event:/Sfx/Player/hammerattack"))
	scr_playerSounds_loadcheck("hammerair", FMODcreate_event("event:/Sfx/Player/hammerair"))
	scr_playerSounds_loadcheck("skateboard", FMODcreate_event("event:/Sfx/Player/Transformations/Skateboard/move"))
	scr_playerSounds_loadcheck("skateaim", FMODcreate_event("event:/Sfx/Player/Transformations/Skateboard/aim"))
}