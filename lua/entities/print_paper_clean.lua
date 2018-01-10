AddCSLuaFile()

ENT.PrintName = "Printer cleaner"
ENT.Type = "anim"
ENT.Author = "Sherlock"
ENT.Category = "YourRP"
ENT.Spawnable = true
ENT.AdminOnly = true


function ENT:Initialize()
if(SERVER)then
		self:SetModel("models/props_lab/huladoll.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		
		local phys = self.Entity:GetPhysicsObject()

		if (phys:IsValid()) then
		phys:Wake()
		phys:SetMass(1)
	end
end
end

function ENT:PhysicsCollide( data, phys )
if(SERVER)then
local hit = data.HitEntity

if(hit:GetClass() == "bm_print_a" || hit:GetClass() == "bm_print_b" || hit:GetClass() == "bm_print_c")||hit:GetClass()== "bm_print_b_donator" then
hit:SetNWFloat("proc_paper", 0)
hit:SetNWFloat("proc_power", 0)
hit:SetNWFloat("proc_cooling", 5)
self:Remove()
end

end
end

