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
	SuppressHostEvents( NULL ) -- Do not suppress the flechette effects

    local playerTable = {}
    local entityCount = 0
    local numFlechettes = 35 -- Use to be 100

    for k,v in pairs(ents.FindInSphere(self:GetPos(), 350)) do
        if v:IsPlayer() or v:IsNPC() or v:IsNextBot() then
            playerTable[k] = v
            entityCount = entityCount + 1
        end
    end

    local flechettesPerEntity = math.floor(numFlechettes / entityCount)
    local leftoverFlechettes = numFlechettes % entityCount

    if not (entityCount == 0) then
        for k,v in pairs(playerTable) do
            for i=1,flechettesPerEntity do
                local ent = ents.Create( "hunter_flechette" )
                if ( !IsValid( ent ) ) then return end

                ent:SetPos( self:GetPos())
                ent:Spawn()
                ent:Activate()
                ent:PointAtEntity(v)
                ent:SetAngles(ent:GetAngles() + Angle(math.random(-10, -5), 0, 0))
                ent:SetVelocity( ent:GetForward() * 2500 )  
            end
        end

        for i=1,leftoverFlechettes do
          	local ent = ents.Create( "hunter_flechette" )
            if ( !IsValid( ent ) ) then return end

            ent:SetPos( self:GetPos())
            ent:Spawn()
            ent:Activate()
            local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(0.0, 1.0)) * 2500
            ent:SetAngles(directionVec:Angle())
            ent:SetVelocity( directionVec )  
        end
    else
        for i=1,numFlechettes do
          	local ent = ents.Create( "hunter_flechette" )
            if ( !IsValid( ent ) ) then return end

            ent:SetPos( self:GetPos())
            ent:Spawn()
            ent:Activate()
            local directionVec = Vector(math.Rand(-1.0, 1.0), math.Rand(-1.0, 1.0), math.Rand(0.0, 1.0)) * 2500
            ent:SetAngles(directionVec:Angle())
            ent:SetVelocity( directionVec )  
        end
    end

    self:StopSound(self.ThermiteSound)
	local explosion = ents.Create( "env_explosion" ) -- The explosion entity
	explosion:SetPos( self:GetPos() ) -- Put the position of the explosion at the position of the entity
	explosion:Spawn() -- Spawn the explosion
	explosion:SetKeyValue( "iMagnitude", "10" ) -- the magnitude of the explosion
	explosion:Fire( "Explode", 0, 0 ) -- explode
end