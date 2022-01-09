AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self.timeToLive = 4.5
    
    self:SetModel("models/weapons/w_npcnade.mdl")
    
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.isRunning = false
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    util.SpriteTrail(self, 0, self.GrenadeColor, false, 1.25, 0, 0.35, 1/1.25 * 0.5, "trails/plasma.vmt")

    timer.Create("explodeTimer"..self:GetName()..self:EntIndex(), self.timeToLive, 1, function() 
        self:Remove()
    end)

    self:EmitSound( self.TickSound )
    timer.Create("soundTickTimer"..self:EntIndex(), 0.4, 0, function() 
        self:EmitSound( self.TickSound )
    end)
end

function ENT:Use(activator, caller, useType, value)
    if activator:IsValid() and activator:IsPlayer() then
        activator:PickupObject(self)
    end
end

function ENT:OnRemove()
    timer.Remove("soundTickTimer"..self:EntIndex())
    self:StopSound(self.TickSound)

	SuppressHostEvents( NULL )

    for i=1,30 do
      	local ent = ents.Create( "hunter_flechette" )
        if ( !IsValid( ent ) ) then return end
        
        ent:SetOwner(self:GetOwner())
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

        ent:SetOwner(self:GetOwner())
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

        ent:SetOwner(self:GetOwner())
        ent:SetPos( self:GetPos() + Vector(0, 0, 5))
        ent:Spawn()
        ent:Activate()

        local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(-1.0, 0.0)) * 2500
        ent:SetAngles(directionVec:Angle())
        ent:SetVelocity( directionVec )  
    end

	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	if ( not explosion:IsValid() ) then return end

    explosion:SetOwner(self:GetOwner())
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "125" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end

function ENT:PhysicsCollide(colData, collider)    
    if colData.Speed > 300 then
        local soundNumber = math.random(3)
        local volumeCalc = math.min(1, colData.Speed / 500)
        self:EmitSound(Sound("physics/metal/metal_grenade_impact_hard"..soundNumber..".wav"), 75, 100, volumeCalc)
    end
end