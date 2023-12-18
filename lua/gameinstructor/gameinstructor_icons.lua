print("[Game Instructor [ICONS]] Loaded.")

function AddGIIcons()
    GIIcons = {}

    local files, _ = file.Find("materials/gi_icons/*.png", "GAME")
    
    for _, fileName in ipairs(files) do
        local variableName = string.gsub(fileName, "%.png$", "")
        GIIcons[variableName] = Material("gi_icons/" .. fileName)
        print("Icon: (" .. variableName .. ") has been loaded.")
    end
end