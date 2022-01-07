AddCSLuaFile()

SWEP.PrintName				= "Enhanced Grenade Base" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author					= "Memelord" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions			= "Pull Pin, Aim, Throw"
SWEP.Spawnable 				= false
SWEP.AdminOnly 				= true
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "Grenade"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Weight					= 5
SWEP.AutoSwitchTo			= false
SWEP.AutoSwitchFrom			= false
SWEP.Slot					= 4
SWEP.SlotPos				= 2
SWEP.DrawAmmo				= true
SWEP.DrawCrosshair			= true
SWEP.ViewModel				= "models/weapons/c_grenade.mdl"
SWEP.WorldModel				= "models/weapons/w_grenade.mdl"
SWEP.UseHands 				= true
SWEP.ViewModelFOV			= 54
SWEP.GrenadeEntity			= ""
SWEP.RollSound 				= Sound("WeaponFrag.Throw")
SWEP.BodyMaterial	 		= 'phoenix_storms/wood'
-- SWEP.PinMaterial	 		= nil

function SWEP:Initialize()
	self:SetHoldType("grenade")
	self.startHighThrow = false
	self.startLowThrow = false
end

function SWEP:Deploy()
	local owner = self:GetOwner()
	if not ( self:IsValid() and owner:IsValid() and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then return end

	timer.Create("animTimerIdleDeploy"..self:EntIndex(), 0.2, 1, function()
		timer.Remove("animTimerIdleDeploy"..self:EntIndex())
		if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_IDLE) end
	end)
end

-- Called when the left mouse button is pressed
function SWEP:PrimaryAttack()

	if not self.startLowThrow and not self.startHighThrow then
		self:SendWeaponAnim(ACT_VM_PULLBACK_HIGH)
		self.startHighThrow = true
	end

end

function SWEP:SecondaryAttack()

	if not self.startLowThrow and not self.startHighThrow then
		self:SendWeaponAnim(ACT_VM_PULLBACK_LOW)
		self.startLowThrow = true
	end

end

function SWEP:Think()
   local ply = self:GetOwner()
   if not IsValid(ply) then return end
   
	if self.startHighThrow and not ply:KeyDown(IN_ATTACK) then
		self.startHighThrow = false
		self:ThrowGrenadeHigh()
	end

	if self.startLowThrow and not ply:KeyDown(IN_ATTACK2) then
		self.startLowThrow = false

		if ply:KeyDown(IN_DUCK) then
			self:ThrowGrenadeRoll()
		else
			self:ThrowGrenadeLow()
		end
	end
end

function SWEP:ThrowGrenadeHigh()
	local owner = self:GetOwner()
	if ( not owner:IsValid() ) then return end

	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire( CurTime() + 1.82 )
	self:SetNextSecondaryFire( CurTime() + 1.82 )

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_THROW)

	if ( CLIENT ) then return end
	
	local ent = ents.Create( self.GrenadeEntity )

	-- Always make sure that created entities are actually created!
	if ( not ent:IsValid() ) then return end
	ent:SetOwner(owner)

	-- This is the same as owner:EyePos() + (self.Owner:GetAimVector() * 16)
	-- but the vector methods prevent duplicitous objects from being created
	-- which is faster and more memory efficient
	-- AimVector is not directly modified as it is used again later in the function
	local aimvec = owner:GetAimVector()

	local pos = aimvec * 8 -- This creates a new vector object
	pos:Add( owner:EyePos() ) -- This translates the local aimvector to world coordinates
	
	-- THIS WORKS!!!!
	local distance = 6.35 -- 6 was pretty good
	local parallelVec = owner:EyeAngles():Right()

	pos.x = pos.x + (parallelVec.x * distance)
	pos.y = pos.y + (parallelVec.y * distance)


	-- Set the position to the player's eye position plus 8 units forward
	ent:SetPos( pos )

	-- Set the angles to the player'e eye angles. Then spawn it.
	ent:SetAngles( owner:EyeAngles() + Angle(math.random(-10, 10)) )
	ent:Spawn()
 
	local phys = ent:GetPhysicsObject()
	if ( not phys:IsValid() ) then ent:Remove() return end
 
	aimvec:Mul( 1245 ) -- Happy with how throwing lokos now to add some more forece
	aimvec:Add( VectorRand( -10, 10 ) ) -- Add a random vector with elements [-10, 10)
	aimvec:Add(owner:GetVelocity() * 0.90)
	phys:AddAngleVelocity(Vector(math.random(-500, -250), math.random(-250, -100), math.random(-250, -100))) -- Changed from 500 to 125 to 50
	phys:ApplyForceCenter( aimvec )

	if self:Ammo1() <= 0 then
		self:Remove()
		owner:SwitchToDefaultWeapon()
		return
	end

	timer.Create("animTimer1"..self:EntIndex(), 0.4, 1, function()
		timer.Remove("animTimer1"..self:EntIndex())
		if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_DRAW) end

		timer.Create("animTimerIdleHiThrow"..self:EntIndex(), 1.2, 1, function()
			timer.Remove("animTimerIdleHiThrow"..self:EntIndex())
				if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_IDLE) end
		end)
	end)
end

function SWEP:ThrowGrenadeLow()
	local owner = self:GetOwner()
	if ( not owner:IsValid() ) then return end

	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire( CurTime() + 1.82 )
	self:SetNextSecondaryFire( CurTime() + 1.82 )

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

	if ( CLIENT ) then return end
	
	local ent = ents.Create( self.GrenadeEntity )

	-- Always make sure that created entities are actually created!
	if ( not ent:IsValid() ) then return end
	ent:SetOwner(owner)

	local aimvec = owner:GetAimVector()

	local pos = aimvec * 8 -- This creates a new vector object
	pos:Add( owner:EyePos() ) -- This translates the local aimvector to world coordinates
	pos:Add( Vector(0,0,-3.5))
	-- Set the position to the player's eye position plus 16 units forward.
	
	-- THIS WORKS!!!!
	local distance = 6.35
	local parallelVec = owner:EyeAngles():Right()
	
	pos.x = pos.x + (parallelVec.x * distance)
	pos.y = pos.y + (parallelVec.y * distance)

	ent:SetPos( pos )

	-- Set the angles to the player'e eye angles. Then spawn it.
	ent:SetAngles( owner:EyeAngles() + Angle(math.random(-10, 10)) )
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if ( not phys:IsValid() ) then ent:Remove() return end

	aimvec:Mul( 325 ) -- Happy with how throwing lokos now to add some more forece
	aimvec:Add( VectorRand( -2, 2 ) ) -- Add a random vector with elements [-10, 10)
	aimvec:Add(owner:GetVelocity() * 0.65)
	phys:AddAngleVelocity(Vector(math.random(-300, -250), math.random(-200, -100), math.random(-200, -100))) -- Changed from 500 to 125 to 50
	phys:ApplyForceCenter( aimvec )

	if self:Ammo1() <= 0 then
		self:Remove()
		owner:SwitchToDefaultWeapon()
		return
	end

	timer.Create("animTimer2"..self:EntIndex(), 0.6, 1, function()
		timer.Remove("animTimer2"..self:EntIndex())
		if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_DRAW) end

		timer.Create("animTimerIdleLoThrow"..self:EntIndex(), 1.2, 1, function()
			timer.Remove("animTimerIdleLoThrow"..self:EntIndex())
			if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_IDLE) end
		end)
	end)
end

function SWEP:ThrowGrenadeRoll()
	local owner = self:GetOwner()
	if ( not owner:IsValid() ) then return end

	self:TakePrimaryAmmo( 1 )
	self:SetNextPrimaryFire( CurTime() + 1.82 )
	self:SetNextSecondaryFire( CurTime() + 1.82 )

	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

	if ( CLIENT ) then return end
	
	local ent = ents.Create( self.GrenadeEntity )

	-- Always make sure that created entities are actually created!
	if ( not ent:IsValid() ) then return end
	ent:SetOwner(owner)

	local aimangles = owner:GetAngles()
	aimangles.x = 0

	local vecSrc = owner:GetPos()
	local vecFacing = aimangles:Forward()

	trData = {}
	trData["start"] = vecSrc
	trData["endpos"] = vecSrc - Vector(0, 0, 16)
	trData["mask"] = MASK_PLAYERSOLID
	trData["collisiongroup"] = COLLISION_GROUP_NONE

	tr = util.TraceLine(trData)
	if tr["Fraction"] != 1 then
		local tangent = vecFacing:Cross(tr["HitNormal"])
		vecFacing = tr["HitNormal"]:Cross(tangent)
	end
	vecSrc:Add(vecFacing * 18)

	local vecThrow = owner:GetVelocity()
	vecThrow:Add(vecFacing * 700)
	
	local backwards = (-owner:GetForward()) * 10
	backwards.z = 0

	ent:SetPos(vecSrc + Vector(0, 0, 5) + backwards)
	ent:SetAngles( owner:EyeAngles() + Angle(0 ,0, -90))
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if ( not phys:IsValid() ) then ent:Remove() return end

	phys:ApplyForceCenter( vecThrow )
	phys:AddAngleVelocity(Vector(math.random(10,50), 0, 500))

	if self:Ammo1() <= 0 then
		self:Remove()
		owner:SwitchToDefaultWeapon()
		return
	end

	timer.Create("animTimer2"..self:EntIndex(), 0.6, 1, function()
		timer.Remove("animTimer2"..self:EntIndex())
		if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_DRAW) end

		timer.Create("animTimerIdleLoThrow"..self:EntIndex(), 1.2, 1, function()
			timer.Remove("animTimerIdleLoThrow"..self:EntIndex())
			if ( self:IsValid() and owner:IsValid()  and owner:Alive() and owner:GetActiveWeapon():GetPrintName() == self.PrintName ) then self:SendWeaponAnim(ACT_VM_IDLE) end
		end)
	end)
end

function SWEP:PreDrawViewModel(vm, ply, wep)
    vm:SetSubMaterial(3, self.BodyMaterial)
	-- vm:SetSubMaterial(3, SWEP.PinMaterial)
end

function SWEP:ViewModelDrawn(vm)
    if vm:IsValid() then
        vm:SetSubMaterial()
    end
end