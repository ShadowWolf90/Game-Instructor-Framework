if SERVER then
    include("gameinstructor/gameinstructor_server.lua")
end

-- Dodaj plik do klienta
if CLIENT then
    include("gameinstructor/gameinstructor_client.lua")
    include("gameinstructor/gameinstructor_icons.lua")
end