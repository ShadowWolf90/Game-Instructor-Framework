print("[Game Instructor [SERVER]] Loaded.")

util.AddNetworkString("GINetwork")

include("gameinstructor/gameinstructor_icons.lua")
include("gameinstructor/gameinstructor_sounds.lua")

hook.Add( "Initialize", "LoadGIIconsClient", function()
	AddGIIcons()
	AddGISounds()
end)

function CreateGIHint(icon, text, pos, snd)
    if GIIcons[icon] and text != nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
        pos:SetNWString("GISound", snd)
    else
        print("[Game Instructor [SERVER]] Oops, couldn't add hint! \n")
    end
end

--[[
function CreateGITextbox(text, pos)
    if GIIcons[icon] and text != nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
    else
        print("[Game Instructor [SERVER] Oops, couldn't add hint! \n")
    end
end
]]--

function RemoveGIHint(pos)
    if IsValid(Entity(pos:EntIndex())) and isentity(pos) then
        pos:SetNWString("GIIcon", nil)
        pos:SetNWString("GIText", nil)
        pos:SetNWString("GISound", nil)
    else
        print("[Game Instructor [SERVER]] Oops, couldn't remove hint! \n")
    end
end

local function GatherHints()
    local HintTable = { }
    for i, ent in ents.Iterator() do
        local hintindex = ent:GetCreationID()
        local iconKey = ent:GetNWString("GIIcon")

        if GIIcons[iconKey] then
            local HintInfo = {
                position = ent:WorldSpaceCenter(),
                icontype = iconKey,
                hinttext = ent:GetNWString("GIText"),
                hintsound = ent:GetNWString("GISound"),
                debugid = hintindex
            }
            --print("Detected entity with GI Flag at: " .. tostring(HintInfo.position) .. ", type: " .. HintInfo.icontype .. ", and text: " .. HintInfo.hinttext)
            HintTable[hintindex] = HintInfo
        end
    end

    return HintTable
end

local function SendHintToClients()
    local HintData = GatherHints()

    net.Start("GINetwork")
    net.WriteTable(HintData)
    net.Broadcast()
end

hook.Add("Tick", "UpdateHintDataHook", function()
    SendHintToClients()
end)


