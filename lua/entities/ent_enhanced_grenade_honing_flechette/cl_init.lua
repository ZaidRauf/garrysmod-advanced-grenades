include("shared.lua")

function ENT:Draw()
    self:DrawModel()
    render.SetMaterial(self.GrenadeLight)
    render.DrawSprite(self:GetPos() + self:GetUp() * 4.5, 12.5, 12.5, self.GrenadeColor)
end

function ENT:OnRemove()
    self:StopSound(self.TickSound)
end
