SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Thermite Greande" -- This will be shown in the spawn menu, and in the weapon selection menu
-- SWEP.Instructions		= "Creates light and burns anyone who gets too close"
SWEP.Category           = "Enhanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_thermite"

SWEP.Primary.Ammo			= "thermite_grenade"


hook.Add("Initialize", "expanded_grenade_thermite_ammo", function()
    game.AddAmmoType( {
	    name = "thermite_grenade",
    } )
end)
