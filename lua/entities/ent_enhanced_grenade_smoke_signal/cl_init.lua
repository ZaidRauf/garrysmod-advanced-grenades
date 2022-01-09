include("shared.lua")

function ENT:Initialize()
	self:SetSubMaterial(0, self.WorldMaterial)
    self.smokeEmitter = ParticleEmitter( self:GetPos() ) -- Particle emitter in this position
    -- self:SetMaterial("phoenix_storms/wood") -- Placeholder to test changing material
end

function ENT:Draw()
    self:DrawModel()
    render.SetMaterial(self.GrenadeLight)
    render.DrawSprite(self:GetPos() + self:GetUp() * 4.5, 12.5, 12.5, self.GrenadeColor)
end

function ENT:Think()
    if self:GetSmokeActive() then
        if IsValid(self.smokeEmitter) then
            local part = self.smokeEmitter:Add( self.SmokeEffect,  self:GetPos() ) -- Create a new particle at pos
            if ( part ) then
                part:SetDieTime( 10 ) -- How long the particle should "live"

                part:SetStartAlpha( 255 ) -- Starting alpha of the particle
                part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

                part:SetStartSize( math.random(10, 20)) -- Starting size
                part:SetEndSize( 5.5 ) -- Size when removed
                
                part:SetColor(82,144,98) -- Make variable

                part:SetVelocity( Vector(math.random(-5, 5), math.random(-5, 5), math.random(20, 50)) ) -- Initial velocity of the particle
                part:SetGravity( Vector( math.random(-1.5, 1.5), math.random(-1.5, 1.5), math.random(5, 50) ) ) -- Gravity of the particle
                -- part:SetAngleVelocity( AngleRand() )
                part:SetBounce(0.9)
                part:SetCollide(true)
            end
        end
    end
end

function ENT:OnRemove()
    self:StopSound(self.SmokeSound)
    self.smokeEmitter:Finish()
end
