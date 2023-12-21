print("[Game Instructor [SOUNDS]] Loaded.")

GISounds = {}

function AddGISounds()
    local files, _ = file.Find("sounds/gi_sounds/*.mp3", "GAME")
    
    for _, fileName in ipairs(files) do
        local variableName = string.gsub(fileName, "%.png$", "")
        GISounds[variableName] = Material("gi_sounds/" .. fileName)
        print("Sound: (" .. variableName .. ") has been loaded.")
    end
end

