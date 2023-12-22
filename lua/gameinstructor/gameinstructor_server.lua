print("[Game Instructor [SERVER]] Loaded.")

util.AddNetworkString("GINetwork")

include("gameinstructor/gameinstructor_icons.lua")
include("gameinstructor/gameinstructor_sounds.lua")

hook.Add( "Initialize", "LoadGIContentServer", function()
	AddGIIcons()
	AddGISounds()
end)

local HintTable = { }

function CreateGIHint(icon, text, pos, snd)
    if GIIcons[icon] and text != nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
        pos:SetNWString("GISound", snd)
    else
        print("[Game Instructor [SERVER]] Oops, couldn't add hint! \n")
    end
end


function CreateGIVectorHint(icon, text, pos, snd, uniqueid)
    if GIIcons[icon] and text != nil and isvector(pos) and uniqueid != nil then
        local VectorInfo = {
            position = pos,
            icontype = icon,
            hinttext = text,
            hintsound = snd,
        }

        HintTable[uniqueid] = VectorInfo
    end
end


function RemoveGIHint(pos)
    if IsValid(Entity(pos:EntIndex())) and isentity(pos) then
        local ID = pos:GetCreationID()
        pos:SetNWString("GIIcon", nil)
        pos:SetNWString("GIText", nil)
        pos:SetNWString("GISound", nil)
        HintTable[ID] = nil
    else
        print("[Game Instructor [SERVER]] Oops, couldn't remove hint! \n")
    end
end


function RemoveGIVectorHint(uniqueid)
    if uniqueid != nil then
        HintTable[uniqueid] = nil
    end
end


local function GatherHints()
    for i, ent in ents.Iterator() do
        local hintindex = ent:GetCreationID()
        local iconKey = ent:GetNWString("GIIcon")

        if GIIcons[iconKey] then
            local HintInfo = {
                position = ent:WorldSpaceCenter(),
                icontype = iconKey,
                hinttext = ent:GetNWString("GIText"),
                hintsound = ent:GetNWString("GISound"),
            }

            HintTable[hintindex] = HintInfo
        end
    end

    return HintTable
end

local function SendHintToClients()
    local HintData = GatherHints()
    --PrintTable(HintTable)

    net.Start("GINetwork")
    net.WriteTable(HintData)
    net.Broadcast()
end

hook.Add("Tick", "UpdateHintDataHook", function()
    SendHintToClients()
end)


