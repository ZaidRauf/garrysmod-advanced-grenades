AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")


function ENT:Initialize()
    self.incendiaryTime = CurTime() + 4.5
    self.timeToLive = CurTime() + 30
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
        print("Grenade Stuck to: ", touchEnt)
        constraint.Weld(self, touchEnt, 0, 0, 0, true, true)

        timer.Create("explodeTimer"..self:EntIndex(), 2, 1, function() 
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

        timer.Create("explodeTimer"..self:EntIndex(), 2, 1, function() 
            self:Remove()
        end)
    end
end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
    explosion:SetOwner(self:GetOwner())
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "150" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end