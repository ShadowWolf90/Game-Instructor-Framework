if SERVER then
    include("gameinstructor/gameinstructor_icons.lua")
    include("gameinstructor/gameinstructor_server.lua")
end

if CLIENT then
    include("gameinstructor/gameinstructor_icons.lua")
    include("gameinstructor/gameinstructor_client.lua")
end