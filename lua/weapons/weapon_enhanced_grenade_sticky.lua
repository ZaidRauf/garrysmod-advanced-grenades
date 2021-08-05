AddCSLuaFile()

SWEP.Base                   = "weapon_enhanced_grenade_base"
SWEP.PrintName			    = "Sticky Grenade" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Instructions		    = "Pull Pin, Aim, Throw -> Sticks to whatever it hits"
SWEP.Category               = "Enhanced Grenades"
SWEP.Spawnable              = true
SWEP.GrenadeEntity          = "ent_enhanced_grenade_sticky"
SWEP.Primary.Ammo			= "sticky_grenade"

hook.Add("Initialize", "expanded_grenade_sticky_ammo", function()
    game.AddAmmoType( {
	    name = "sticky_grenade",
    } )
end)
