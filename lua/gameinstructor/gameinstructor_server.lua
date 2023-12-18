print("[Game Instructor [SERVER]] Loaded.")

util.AddNetworkString("GINetworkPosition")
util.AddNetworkString("GINetworkEntity")

function CreateGIHint(icon, text, pos)
    if IsValid(GIIcons[icon]) and isentity(pos) and text != nil then
        pos:SetNWString("GIIcon", icon)
        pos:SetNWString("GIText", text)
    elseif IsValid(GIIcons[icon]) and isvector(pos) and text != nil then
        net.Start("GINetwork")
        net.WriteString(icon)
        net.WriteString(text)
        net.WriteVector(pos)
        net.Broadcast()
    elseif (not IsValid(GIIcons[icon]) or text == nil or pos == nil) then
        if not IsValid(GIIcons[icon]) then
            --ErrorNoHalt("Icon, Text or Position/Entity is incorrect. Please check your LUA script.")
            ErrorNoHalt("Icon is incorrect. Please check your LUA script.")
        elseif text == nil then
            ErrorNoHalt("Text is incorrect. Please check your LUA script.")
        elseif pos == nil then
            ErrorNoHalt("Position/Entity is incorrect. Please check your LUA script.")
        end
    end
end



