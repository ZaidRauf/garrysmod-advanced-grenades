AddCSLuaFile()

SWEP.Base                   = "weapon_enhanced_grenade_base"
SWEP.PrintName			    = "Sticky Grenade" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Instructions		    = "Pull Pin, Aim, Throw -> Sticks to whatever it hits"
SWEP.Category               = "Advanced Grenades"
SWEP.Spawnable              = true
SWEP.GrenadeEntity          = "ent_enhanced_grenade_sticky"
SWEP.Primary.Ammo			= "sticky_grenade"
SWEP.BodyMaterial	 		= 'enhanced_grenade_sticky/sticky_grenade_body'
SWEP.PinMaterial	 		= 'enhanced_grenade_sticky/sticky_grenade_handle'
SWEP.WorldMaterial	 		= 'enhanced_grenade_sticky/sticky_grenade_w'

hook.Add("Initialize", "expanded_grenade_sticky_ammo", function()
    game.AddAmmoType( {
	    name = "sticky_grenade",
    } )
end)

function SWEP:Think()
   local ply = self:GetOwner()
   if not IsValid(ply) then return end
   
	if self.startHighThrow and not ply:KeyDown(IN_ATTACK) then
		self.startHighThrow = false
		self:ThrowGrenadeHigh()
	end

	if self.startLowThrow and not ply:KeyDown(IN_ATTACK2) then
		self.startLowThrow = false
		self:ThrowGrenadeLow()
	end
end