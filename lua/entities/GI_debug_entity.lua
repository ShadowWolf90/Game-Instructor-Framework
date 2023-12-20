AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Game Instructor Debug Entity"
ENT.Author = "Aaron"
ENT.Spawnable = true
ENT.Category = "Game Instructor"

function ENT:Initialize()
    if SERVER then
        self:SetNWString("GIIcon", "warning")
        self:SetNWString("GIText", "Debug Text")
        self:SetModel("models/hunter/blocks/cube05x05x05.mdl")
    end
end

scripted_ents.Register(ENT, "GI_debug_entity")