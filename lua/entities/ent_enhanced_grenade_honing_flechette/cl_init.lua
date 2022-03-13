include("shared.lua")

function ENT:Initialize()
	self:SetSubMaterial(0, self.WorldMaterial)
end

function ENT:Draw()
    self:DrawModel()
    render.SetMaterial(self.GrenadeLight)
    render.DrawSprite(self:GetUp() * 4.5 + self:GetPos(), 12.5, 12.5, self.GrenadeColor)
end

function ENT:OnRemove()
    self:StopSound(self.TickSound)
end
