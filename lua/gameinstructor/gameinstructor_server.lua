print("[Game Instructor [SERVER]] Loaded.")

util.AddNetworkString("GINetworkPosition")
util.AddNetworkString("GINetwork")

include("gameinstructor/gameinstructor_icons.lua")

function CreateGIHint(icon, text, pos)
    if IsValid(GIIcons[icon]) and isentity(pos) and text ~= nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
    elseif (not IsValid(GIIcons[icon]) or text == nil or pos == nil) then
        if not IsValid(GIIcons[icon]) then
            ErrorNoHalt("Icon is incorrect. Please check your LUA script.")
        elseif text == nil then
            ErrorNoHalt("Text is incorrect. Please check your LUA script.")
        elseif pos == nil then
            ErrorNoHalt("Position/Entity is incorrect. Please check your LUA script.")
        end
    end
end

local iconKeyToCheck = "warning" -- Zastąp "nazwaIkony" odpowiednim kluczem do sprawdzenia

if not GIIcons[iconKeyToCheck] then
    print("Ikona o kluczu " .. iconKeyToCheck .. " nie istnieje w tabeli GIIcons.")
else
    print("Ikona o kluczu " .. iconKeyToCheck .. " istnieje w tabeli GIIcons.")
end


local function GatherHints()
    local HintTable = { }
    for i, ent in ents.Iterator() do
        local hintindex = ent:GetCreationID()
        local iconKey = ent:GetNWString("GIIcon")

        if GIIcons[iconKey] then
            local HintInfo = {
                position = ent:GetPos(),
                icontype = iconKey,
                hinttext = ent:GetNWString("GIText"),
                debugid = hintindex
            }
            print("Working!")
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


