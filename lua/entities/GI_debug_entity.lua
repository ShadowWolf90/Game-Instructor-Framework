AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Game Instructor Debug Entity"
ENT.Author = "Aaron"
ENT.Spawnable = true
ENT.Category = "Game Instructor"

function ENT:Initialize()
    if SERVER then
        CreateGIHint("bulb", "Test for function!", self)
        self:SetModel("models/hunter/blocks/cube05x05x05.mdl")
        timer.Simple(5, function() 
            RemoveGIHint(self) 
        end)
    end
end

scripted_ents.Register(ENT, "GI_debug_entity")