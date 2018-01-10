
AddCSLuaFile()
ENT.PrintName = "Money Printer B Donator Edition  "
ENT.Type = "anim"
ENT.Author = "Sherlock"
ENT.Category = "YourRP"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize()

	if ( SERVER ) then

		self:SetModel( "models/pcmod/kopierer.mdl" )
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetHealth(900)
		self:SetPos(self:GetPos() + Vector(0,0,100))
		self:SetColor( Color (234,155,231,255) )

		screen = ents.Create("prop_dynamic")
		screen:SetModel("models/combine_soldier_anims.mdl")
		screen:SetPos(self:GetPos() + (self:GetForward() * 12) + (self:GetRight() * 4) + (self:GetUp() * 24.05))
		screen:SetAngles(self:GetAngles() + Angle(0,90,0))
		screen:SetNoDraw( false )
		screen:Spawn()
		screen:SetParent( self, -1 )

		self:SetNWEntity("scr", screen)
		self:SetNWFloat("proc_print", 0)
		self:SetNWFloat("proc_power", 20)
		self:SetNWFloat("proc_paper", 40)
		self:SetNWFloat("proc_cooling", 90)
		self:SetNWInt("money", 10)

		local payday = file.Read( "Printer_B.txt", "DATA" )
		if(payday == nil)then
		payday = 200
		else
		payday = tonumber(payday)
		end
		self:SetNWInt("payday", payday)

		self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
		self.sound:SetSoundLevel(52)
		self.sound:PlayEx(1, 100)

		local phys = self.Entity:GetPhysicsObject()

		if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
	end

	end

end

if(CLIENT)then
surface.CreateFont( "printfont", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 12,
	weight = 1500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "moneyfont", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 50,
	weight = 1500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )
end

function ENT:Draw()
self:DrawModel()

if(self:GetNWEntity("scr") != NULL)then

	cam.Start3D2D( self:GetNWEntity("scr"):GetPos() , self:GetNWEntity("scr"):GetAngles() + Angle(0,0,0), 0.1 )

		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect( 0, 0, 140, 60 )
		--
		surface.SetFont( "printfont" )
		if(self:GetNWFloat("proc_power", 0) > 0)then
		surface.SetTextColor( 255, 255, 255, 255 )
		else
		surface.SetTextColor( 255, 0, 0, 255 )
		end
		surface.SetTextPos( 70, 8 )
		surface.DrawText( "Power" )

		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 10, 10, 50, 10 )

		surface.SetDrawColor( 255, 255, 0, 255 )
		if(self:GetNWInt("proc_power", 0) > 0)then
		surface.DrawRect( 10, 10, self:GetNWInt("proc_power", 0)/2, 10 )
		end

		surface.SetFont( "printfont" )
		if(self:GetNWFloat("proc_paper", 0) >= 15)then
		surface.SetTextColor( 255, 255, 255, 255 )
		else
		surface.SetTextColor( 255, 0, 0, 255 )
		end
		surface.SetTextPos( 70, 23 )
		surface.DrawText( "Paper" )

		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 10, 25, 50, 10 )

		surface.SetDrawColor( 255, 255, 0, 255 )
		if(self:GetNWInt("proc_paper", 0) > 0)then
		surface.DrawRect( 10, 25, self:GetNWInt("proc_paper", 0)/2, 10 )
		end

		surface.SetFont( "printfont" )
		surface.SetTextColor( 255, 255, 255, 255 )
		surface.SetTextPos( 70, 38 )
		surface.DrawText( "Cooling" )

		surface.SetDrawColor( 0, 0, 0, 255 )
		surface.DrawRect( 10, 40, 50, 10 )

		surface.SetDrawColor( 255, 255, 0, 255 )
		if(self:GetNWInt("proc_cooling", 2) > 0)then
		surface.DrawRect( 10, 40, self:GetNWInt("proc_cooling", 0)/2, 10)
		end

		if(self:Health() < 150 && self:Health() > 0)then
		surface.DrawRect( 135, 60/150 * (150-self:Health()), 5, 60/150 * self:Health() )
		elseif(self:Health() <= 0)then
		surface.DrawRect( 135, 0, 5, 0 )
		else
		surface.DrawRect( 135, 0, 5, 60 )
		end
		--
	cam.End3D2D()

	cam.Start3D2D( self:GetNWEntity("scr"):GetPos() + (self:GetForward() * 4.1) + (self:GetRight() * 0.1) + (self:GetUp() * -8.5) , self:GetNWEntity("scr"):GetAngles() + Angle(0,0,90), 0.1 )

	surface.SetDrawColor( 0, 0, 0, 255 )
	surface.DrawRect( 0, 0, 135, 70 )

	surface.SetFont( "moneyfont" )
	surface.SetTextColor( 255, 255, 255, 255 )
	surface.SetTextPos( 10, 10 )
	surface.DrawText( self:GetNWInt("money", 0).."$" )

	if(self:GetNWFloat("proc_print", 0) > 0)then
	surface.SetDrawColor( 0, 255, 0, 255 )
	surface.DrawRect( 0, 65, (135/100) * self:GetNWFloat("proc_print", 0), 5 )
	end

	cam.End3D2D()
end
end

function ENT:Think()
	if(SERVER)then
	if ( timer.Exists( "print_money" ) == false ) then
	timer.Create( "print_money", 2, 0, function()

	local addprint = self:GetNWFloat("proc_print", 0) + (100/60)
	local addmoney = self:GetNWInt("money", 0) + self:GetNWInt("payday", 200)
	local delpower = self:GetNWFloat("proc_power", 0) - (1/9)
	local delcool = self:GetNWFloat("proc_cooling", 0) - (1/6)

	if(self:GetNWFloat("proc_power", 0) > 10)then
	self:SetNWFloat("proc_power", delpower)
	else
	self:SetNWFloat("proc_power", 0)
	end


	if(self:GetNWFloat("proc_cooling", 2) >0)then
	if(self:GetNWFloat("proc_power", 4) > 0)then
	self:SetNWFloat("proc_cooling", delcool)
	end
	else
	self:Ignite( 30 )
	self:SetNWFloat("proc_cooling", 1)
	end


	if(self:GetNWFloat("proc_power", 2) > 0 && self:GetNWFloat("proc_paper", 2) >= 0)then

	if(self:GetNWFloat("proc_print", 0) < 100)then
	self:SetNWFloat("proc_print", addprint)
	else
	local delpaper = self:GetNWFloat("proc_paper", 0) - 5
	self:SetNWInt("money", addmoney)
	self:SetNWFloat("proc_paper", delpaper)
	self:SetNWFloat("proc_print", 0)
	self:EmitSound( "ambient/machines/combine_terminal_idle1.wav")
	end

	end


	timer.Remove("print_money")
	end)
	end

end
end

function ENT:OnTakeDamage(dmg)
	self:SetHealth(self:Health() - dmg:GetDamage())
	if (self:Health() <= 10) then
	self:Ignite( 30 )
	end
	if (self:Health() <= 0) then
		self.Entity:Remove()
	end
	end

function ENT:OnRemove()
if(SERVER)then
timer.Remove("print_money")
self.sound:Stop()
if (self:Health() <= 0) then
local explosion = ents.Create( "env_explosion" )
		explosion:SetKeyValue( "spawnflags", 144 )
		explosion:SetKeyValue( "iMagnitude", 200 )
		explosion:SetKeyValue( "iRadiusOverride", 150 )
		explosion:SetPos(self:GetPos())
		explosion:Spawn( )
		explosion:Fire("explode","",0)
		self:EmitSound( "ambient/levels/labs/electric_explosion4.wav")
		end
end
end

function ENT:Use( activator, ply )
	if ply:IsPlayer() then
	if(self:GetNWInt("money", 0) > 0)then
	ply:addMoney(self:GetNWInt("money", 0))
	self:SetNWInt("money", 0)
	end
	end
end
