include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    self.incendiaryEmitter = ParticleEmitter( self:GetPos() ) -- Particle emitter in this position
    self.emitSoundFlag = false
end

function ENT:OnRemove()
    self:StopSound(self.ThermiteSound)
    self.incendiaryEmitter:Finish()
end
