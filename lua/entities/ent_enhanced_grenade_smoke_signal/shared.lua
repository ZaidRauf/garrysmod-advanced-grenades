ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Smoke Signal Greande"
ENT.Spawnable = false
ENT.TickSound = Sound( "weapons/grenade/tick1.wav" )
ENT.SmokeSound = Sound( "npc/env_headcrabcanister/hiss.wav" )
ENT.SmokeEffect = Material("particle/particle_smokegrenade")
ENT.SoundTimer = CurTime() + 4.5
ENT.GrenadeLight = Material("sprites/light_glow02_add")
ENT.GrenadeColor = Color(0, 255, 0)
ENT.WorldMaterial = 'enhanced_grenade_smoke/smoke_grenade_w'

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "SmokeActive")
    self:SetSmokeActive(false)
end