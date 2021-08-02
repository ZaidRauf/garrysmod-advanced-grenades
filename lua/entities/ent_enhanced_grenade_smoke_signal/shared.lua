ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Smoke Signal Greande"
ENT.Spawnable = false

ENT.SmokeSound = Sound( "npc/env_headcrabcanister/hiss.wav" )
ENT.SoundTimer = CurTime() + 4.5

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "SmokeActive")
    self:SetSmokeActive(false)
end