AddCSLuaFile()

SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Thermite Greande"
SWEP.Instructions		= "Pull Pin, Aim, Throw -> Creates light and burns anything that gets too close"
SWEP.Category           = "Advanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_thermite"
SWEP.Primary.Ammo		= "thermite_grenade"
SWEP.BodyMaterial	 	= 'enhanced_grenade_thermite/thermite_body'
SWEP.PinMaterial	 	= 'enhanced_grenade_thermite/thermite_handle'
SWEP.WorldMaterial	 	= 'enhanced_grenade_thermite/thermite_w'

hook.Add("Initialize", "expanded_grenade_thermite_ammo", function()
    game.AddAmmoType( {
	    name = "thermite_grenade",
    } )
end)
