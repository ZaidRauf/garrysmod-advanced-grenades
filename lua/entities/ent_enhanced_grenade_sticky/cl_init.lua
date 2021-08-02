include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:OnRemove()
    self:StopSound(self.TickSound)
end
