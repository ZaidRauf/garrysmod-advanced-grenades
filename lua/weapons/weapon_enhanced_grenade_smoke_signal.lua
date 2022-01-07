AddCSLuaFile()

SWEP.Base               = "weapon_enhanced_grenade_base"
SWEP.PrintName			= "Smoke Signal Grenade" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Instructions		= "Pull Pin, Aim, Throw -> Gives off a plume of green smoke"
SWEP.Category           = "Enhanced Grenades"
SWEP.Spawnable          = true
SWEP.GrenadeEntity      = "ent_enhanced_grenade_smoke_signal"
SWEP.Primary.Ammo		= "smoke_signal_grenade"

-- function SWEP:PreDrawViewModel(vm, ply, weapon)
--     local logoWhitePNG = Material("grenade_body_thermite.png", "noclamp smooth")

--     local logoWhite = CreateMaterial("bKeypads.LogoWhite", "UnlitGeneric", {
--         ["$ignorez"] = 1,
--         ["$translucent"] = 1
--     })

--     logoWhite:SetTexture("$basetexture", logoWhitePNG:GetName())
--     logoWhite:Recompute()

-- 	vm:SetSubMaterial(3, "!bKeypads.LogoWhite") -- Placeholder to test changing material'

--     hook.Add( "HUDPaint", "HUDPaint_DrawATexturedBox", function()
--         surface.SetMaterial( logoWhitePNG )
--         surface.SetDrawColor( 255, 255, 255, 255 )
--         surface.DrawTexturedRect( 50, 50, 128, 128 )
--     end )
-- end

hook.Add("Initialize", "expanded_grenade_smoke_signal_ammo", function()
    game.AddAmmoType( {
	    name = "smoke_signal_grenade",
    } )
end)
