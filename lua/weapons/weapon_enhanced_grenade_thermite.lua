AddCSLuaFile()

SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Thermite Greande"
SWEP.Instructions		= "Pull Pin, Aim, Throw -> Creates light and burns anything that gets too close"
SWEP.Category           = "Enhanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_thermite"
SWEP.Primary.Ammo		= "thermite_grenade"

hook.Add("Initialize", "expanded_grenade_thermite_ammo", function()
    game.AddAmmoType( {
	    name = "thermite_grenade",
    } )
end)
