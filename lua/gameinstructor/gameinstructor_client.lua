print("[Game Instructor [CLIENT]] Loaded.")

hook.Add( "InitPostEntity", "LoadGIIcons", function()
	AddGIIcons()
end)

local HintPosition = { }
local HintEntity = { }

net.Receive("GINetworkPosition", function() 
    HintPosition = {
        iconType = net.ReadString(icon),
        hintText = net.ReadString(text),
        position = net.ReadVector(pos)
    }
end)

net.Receive("GINetwork", function()
    HintEntity = net.ReadTable()
end)


local function DisplayHints()
    for i, hint in ipairs(HintEntity) do
        print(hint.debugid)
    end
end

hook.Add("HUDPaint", "GIHUDManager", DisplayHints)