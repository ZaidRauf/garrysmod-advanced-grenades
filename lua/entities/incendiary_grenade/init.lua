AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.incendiaryTime = CurTime() + 4.5
    self.timeToLive = CurTime() + 20
    
    self:SetModel("models/Items/grenadeAmmo.mdl")
    
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.isRunning = falseq
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:Think()
    if ((not self:GetIncendiaryActive()) and (CurTime() >= self.incendiaryTime)) then
        self:SetIncendiaryActive(true)
        -- self:Ignite(15, 350)
    end

    if CurTime() >= self.timeToLive then
        self:Remove()
    end

    if self:GetIncendiaryActive() then
        for k,v in pairs(ents.FindInSphere(self:GetPos(), 125)) do
            if v:IsPlayer() or v:IsNPC() or v:IsNextBot() or v:IsVehicle() or v:IsRagdoll() or v:GetClass() == "prop_physics" then
                v:Ignite(4)
                v:SetHealth(v:Health() - 1)
            end
        end
    end

end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "25" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end