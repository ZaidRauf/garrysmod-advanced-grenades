include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    self.incendiaryEmitter = ParticleEmitter( self:GetPos() ) -- Particle emitter in this position
    self.emitSoundFlag = false
end

function ENT:Think()

    if self:GetIncendiaryActive() then
        if (not self.emitSoundFlag) then
            self:EmitSound( self.ThermiteSound )
            self.emitSoundFlag = true;
        end
    end
end

function ENT:OnRemove()

    self:StopSound(self.ThermiteSound)
    self.incendiaryEmitter:Finish()
end
