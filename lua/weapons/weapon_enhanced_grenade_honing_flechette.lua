if ( !IsMounted( "ep2" ) ) then return end

AddCSLuaFile()

SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Honing Flechette Grenade" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Instructions		= "Pull Pin, Aim, Throw -> Fires guided flechettes"
SWEP.Category           = "Advanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_honing_flechette"
SWEP.Primary.Ammo	    = "honing_flechette_grenade"
SWEP.BodyMaterial	 	= 'enhanced_grenade_honing_flechette/honing_flechette_grenade_body'
SWEP.PinMaterial	 	= 'enhanced_grenade_honing_flechette/honing_flechette_grenade_handle'
SWEP.WorldMaterial	 	= 'enhanced_grenade_honing_flechette/honing_flechette_grenade_w'

game.AddParticles( "particles/hunter_flechette.pcf" )
game.AddParticles( "particles/hunter_projectile.pcf" )

hook.Add("Initialize", "expanded_grenade_honing_flechette_ammo", function()
    game.AddAmmoType( {
	    name = "honing_flechette_grenade",
    } )
end)
