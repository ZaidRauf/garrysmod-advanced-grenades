ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Thermite Grenade"
ENT.Spawnable = false
ENT.TickSound = Sound( "weapons/grenade/tick1.wav" )
ENT.ThermiteSound = Sound( "npc/env_headcrabcanister/hiss.wav" )
ENT.SparkEffect = Material("effects/spark")
ENT.SoundTimer = CurTime() + 4.5
ENT.GrenadeLight = Material("sprites/light_glow02_add")
ENT.GrenadeColor = Color(255, 255, 255)
ENT.WorldMaterial = 'enhanced_grenade_thermite/thermite_w'

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IncendiaryActive")
    self:SetIncendiaryActive(false)
end