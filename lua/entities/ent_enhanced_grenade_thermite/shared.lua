ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Thermite Grenade"
ENT.Spawnable = false

ENT.TickSound = Sound( "weapons/grenade/tick1.wav" )
ENT.ThermiteSound = Sound( "npc/env_headcrabcanister/hiss.wav" )
ENT.SoundTimer = CurTime() + 4.5

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IncendiaryActive")
    self:SetIncendiaryActive(false)
end