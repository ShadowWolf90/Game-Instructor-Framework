local file_Find = file.Find
local string_gsub = string.gsub
local ipairs = ipairs

print("[Game Instructor [ICONS]] Loaded.")

GIIcons = {}

function AddGIIcons()
    local files, _ = file_Find("materials/gi_icons/*.png", "GAME")
    
    for _, fileName in ipairs(files) do
        local variableName = string_gsub(fileName, "%.png$", "")
        GIIcons[variableName] = Material("gi_icons/" .. fileName)
        print("Icon: (" .. variableName .. ") has been loaded.")
    end
end

PrintTable(GIIcons)

