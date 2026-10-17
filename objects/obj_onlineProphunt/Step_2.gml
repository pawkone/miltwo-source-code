if instance_exists(obj_player)
{
	if global.prophuntmode.select >= 0
		obj_player.image_alpha = 0.25
}
obj_hud.visible = false
obj_shell.whitelist = ["toggle_collisions", "toggle_debug"]

instance_destroy(obj_monolithblock_sleep, false)
instance_destroy(obj_monolithblock_wake, false)
instance_destroy(obj_monolith, false)

instance_destroy(obj_potable_cage, false)
instance_destroy(obj_magicianPickup, false)

instance_destroy(obj_secret, false)
instance_destroy(obj_secretStart, false)

instance_destroy(obj_bacadmad, false)
instance_destroy(obj_baconsmacon, false)
instance_destroy(obj_baconsmacon_dead, false)
instance_destroy(obj_hipnatuese, false)