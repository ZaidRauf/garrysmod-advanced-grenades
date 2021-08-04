SWEP.Base = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Smoke Signal Grenade" -- This will be shown in the spawn menu, and in the weapon selection menu
-- SWEP.Instructions		= "Gives off a plume of green smoke when active"

SWEP.Category = "Enhanced Grenades"
SWEP.Spawnable = true

SWEP.GrenadeEntity = "ent_enhanced_grenade_smoke_signal"

SWEP.Primary.Ammo			= "smoke_signal_grenade"


hook.Add("Initialize", "expanded_grenade_smoke_signal_ammo", function()
    game.AddAmmoType( {
	    name = "smoke_signal_grenade",
    } )
end)
