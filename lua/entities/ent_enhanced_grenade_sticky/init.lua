AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
    self.notStuck = true

    self:SetModel("models/Items/grenadeAmmo.mdl")
    
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.isRunning = false
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end


end

function ENT:StartTouch(touchEnt)
    if self.notStuck then
        self.notStuck = false;

        constraint.Weld(self, touchEnt, 0, 0, 0, true, true)

        timer.Create("explodeTimer"..self:GetName()..self:EntIndex(), 2, 1, function() 
            self:Remove()
        end)
    end
end

function ENT:PhysicsCollide(colData, collider)
    if self.notStuck and (colData.HitEntity:EntIndex() == 0) then
        self.notStuck = false;

        physObj = self:GetPhysicsObject()
        -- physObj:SetVelocity(Vector(0, 0, 0))
        physObj:EnableMotion(false)

        timer.Create("explodeTimer"..self:GetName()..self:EntIndex(), 2, 1, function() 
            self:Remove()
        end)
    end
end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	if ( not explosion:IsValid() ) then return end
    explosion:SetOwner(self:GetOwner())
    explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "150" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end