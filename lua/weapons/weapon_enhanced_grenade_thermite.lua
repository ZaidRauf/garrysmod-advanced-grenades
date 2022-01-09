AddCSLuaFile()

SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Thermite Greande"
SWEP.Instructions		= "Pull Pin, Aim, Throw -> Creates light and burns anything that gets too close"
SWEP.Category           = "Enhanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_thermite"
SWEP.Primary.Ammo		= "thermite_grenade"
SWEP.BodyMaterial	 	= 'test'
-- SWEP.PinMaterial	 	= 'test'
SWEP.WorldMaterial	 	= 'test'

-- local wave = Material( "test" )

-- hook.Add( "HUDPaint", "HUDPaint_DrawATexturedBox", function()
-- 	surface.SetMaterial( wave )
-- 	surface.SetDrawColor( 255, 255, 255, 255 )
-- 	surface.DrawTexturedRect( 50, 50, 128, 128 )
-- end )

-- function SWEP:PreDrawViewModel(vm, ply, wep)
--     vm:SetSubMaterial(3, 'test')
-- end

-- function SWEP:ViewModelDrawn(vm)
--     if vm:IsValid() then
--         vm:SetSubMaterial()
--     end
-- end

-- function SWEP:Initialize()
-- 	self:GetOwner():GetViewModel():SetSubMaterial(3, 'test')
-- end

hook.Add("Initialize", "expanded_grenade_thermite_ammo", function()
    game.AddAmmoType( {
	    name = "thermite_grenade",
    } )
end)
