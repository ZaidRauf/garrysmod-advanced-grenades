include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    self.incendiaryEmitter = ParticleEmitter( self:GetPos() ) -- Particle emitter in this position
    self.dlight = nil
end


function ENT:Think()

    if self:GetIncendiaryActive() then

        if IsValid(self.incendiaryEmitter) then
            for i=1,10 do
                local part = self.incendiaryEmitter:Add( "effects/spark",  self:GetPos() ) -- Create a new particle at pos
                if ( part ) then
                    part:SetDieTime( 1 ) -- How long the particle should "live"

                    part:SetStartAlpha( 255 ) -- Starting alpha of the particle
                    part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

                    part:SetStartSize( math.random() * 3) -- Starting size
                    part:SetEndSize( 0 ) -- Size when removed

                    part:SetVelocity( VectorRand() * 125 ) -- Initial velocity of the particle
                    part:SetGravity( Vector( 0, 0, -300 ) ) -- Gravity of the particle
                    part:SetAngleVelocity( AngleRand() ) -- Gravity of the particle
                    part:SetBounce(0.9)
                    part:SetCollide(true)
                end
            end
        end

        if (not self.dlight) then
            self.dlight = DynamicLight( self:EntIndex() )
        end

        if ( self.dlight ) then
            self.dlight.pos = self:GetPos()
            self.dlight.r = 255
            self.dlight.g = 255
            self.dlight.b = 255
            self.dlight.brightness = 2
            self.dlight.Decay = 1000
            self.dlight.Size = 256
            self.dlight.DieTime = CurTime() + 1
        end

    end
end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
    self.incendiaryEmitter:Finish()
end
