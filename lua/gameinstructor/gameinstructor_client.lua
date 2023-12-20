print("[Game Instructor [CLIENT]] Loaded.")

local HintEntity = { }

net.Receive("GINetwork", function()
    HintEntity = net.ReadTable()
end)

AddGIIcons()

local iconKeyToCheck = "warning" -- Zastąp "nazwaIkony" odpowiednim kluczem do sprawdzenia

if not GIIcons[iconKeyToCheck] then
    print("Ikona o kluczu " .. iconKeyToCheck .. " nie istnieje w tabeli GIIcons.")
else
    print("Ikona o kluczu " .. iconKeyToCheck .. " istnieje w tabeli GIIcons.")
end

local function DisplayHints()
    for index, hint in ipairs(HintEntity) do
        local HintPosition = hint.position
        local IconType = hint.icontype
        local HintText = hint.hinttext
        local DebugID = hint.debugid

       

        surface.SetMaterial(GIIcons["ammo"])
        surface.DrawTexturedRect(ScrW() / 2, ScrH() / 2, 100, 100)
    end
end

hook.Add("HUDPaint", "GIHUDManager", DisplayHints)

hook.Add( "InitPostEntity", "LoadGIIcons", function()
	AddGIIcons()
end)