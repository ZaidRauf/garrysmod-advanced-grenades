AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.smokeStartTime = 4.5
    self.timeToLive = 30
    
    self:SetModel("models/Items/grenadeAmmo.mdl")
    
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.isRunning = false
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    timer.Create("smokeStartTimer"..self:GetName()..self:EntIndex(), self.smokeStartTime, 1, function() 
        self:SetIncendiaryActive(true)
    end)

    timer.Create("explodeTimer"..self:GetName()..self:EntIndex(), self.timeToLive, 1, function() 
        self:Remqwd qove()
    end)
end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "0" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end