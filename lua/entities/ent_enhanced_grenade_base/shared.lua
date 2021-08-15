ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Base Greande Entity"
ENT.Spawnable = false
ENT.TickSound = Sound( "weapons/grenade/tick1.wav" )
ENT.SoundTimer = CurTime() + 4.5
ENT.GrenadeLight = Material("sprites/light_glow02_add")
ENT.GrenadeColor = Color(0, 255, 0)

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "SmokeActive")
    self:SetSmokeActive(false)
end