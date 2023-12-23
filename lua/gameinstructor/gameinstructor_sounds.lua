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
        print("[GIF Content Manager] Sound (" .. variableName .. ") has been loaded.")
    end

    local filesWav, _ = file_Find("sound/gi_sounds/*.wav", "GAME")
    
    for _, fileNameWav in ipairs(filesWav) do
        local variableName = string_gsub(fileName, "%.wav$", "")
        GISounds[variableName] = "gi_sounds/" .. fileName
        print("[GIF Content Manager] Sound (" .. variableName .. ") has been loaded.")
    end
end

PrintTable(GISounds)