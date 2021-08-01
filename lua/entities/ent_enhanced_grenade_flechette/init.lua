AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.timeToLive = CurTime() + 4.5
    
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

    if CurTime() >= self.timeToLive then
        self:Remove()
    end

end

function ENT:OnRemove()
	SuppressHostEvents( NULL )

    -- Use to be 75, 20 , 20

    for i=1,30 do
      	local ent = ents.Create( "hunter_flechette" )
        if ( !IsValid( ent ) ) then return end

        ent:SetPos( self:GetPos())
        ent:Spawn()
        ent:Activate()
        local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(0.0, 1.0)) * 2500
        ent:SetAngles(directionVec:Angle())
        ent:SetVelocity( directionVec )  
    end

    for i=1,10 do
      	local ent = ents.Create( "hunter_flechette" )
        if ( !IsValid( ent ) ) then return end

        ent:SetPos( self:GetPos() + Vector(0, 0, 5))
        ent:Spawn()
        ent:Activate()
        local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(0.0, 0.05)) * 2500
        ent:SetAngles(directionVec:Angle())
        ent:SetVelocity( directionVec )  
    end

    for i=1,10 do
      	local ent = ents.Create( "hunter_flechette" )
        if ( !IsValid( ent ) ) then return end

        ent:SetPos( self:GetPos() + Vector(0, 0, 5))
        ent:Spawn()
        ent:Activate()
        local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(-1.0, 0.0)) * 2500
        ent:SetAngles(directionVec:Angle())
        ent:SetVelocity( directionVec )  
    end

    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "125" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end