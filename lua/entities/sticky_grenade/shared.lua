ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Sticky Greande"
ENT.Spawnable = true

ENT.ThermiteSound = Sound( "npc/env_headcrabcanister/hiss.wav" )
ENT.SoundTimer = CurTime() + 4.5

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IncendiaryActive")
    self:SetIncendiaryActive(false)
end