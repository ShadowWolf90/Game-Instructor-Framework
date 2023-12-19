print("[Game Instructor [SERVER]] Loaded.")

util.AddNetworkString("GINetworkPosition")
util.AddNetworkString("GINetwork")

function CreateGIHint(icon, text, pos)
    if IsValid(GIIcons[icon]) and isentity(pos) and text ~= nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
    elseif IsValid(GIIcons[icon]) and isvector(pos) and text ~= nil then
        print("WIP")
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


local function GatherHints()
    local HintTable = { }
    for i, ent in ipairs(ents.GetAll()) do
        local hintindex = ent:GetCreationID()
        if ent:GetNWString("GIIcon") == GIIcons[ent:GetNWString("GIIcon")] then
            local HintInfo = {
                position = ent:GetPos(),
                icontype = ent:GetNWString("GIIcon"),
                hinttext = ent:GetNWString("GIText"),
                debugid = hintindex
            }
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


