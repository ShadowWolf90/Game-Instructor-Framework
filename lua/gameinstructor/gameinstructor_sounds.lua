local file_Find = file.Find
local string_gsub = string.gsub
local ipairs = ipairs

print("[Game Instructor [SOUNDS]] Loaded.")

GISounds = {}

function AddGISounds()
    local files, _ = file_Find("sound/gi_sounds/*.mp3", "GAME")
    
    for _, fileName in ipairs(files) do
        local variableName = string_gsub(fileName, "%.mp3$", "")
        GISounds[variableName] = "gi_sounds/" .. fileName
        print("Sound: (" .. variableName .. ") has been loaded.")
    end
end

PrintTable(GISounds)