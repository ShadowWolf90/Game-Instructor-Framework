GIIcons = GIIcons or {}

AddCSLuaFile("gameinstructor/gameinstructor_icons.lua")

if SERVER then
    include("gameinstructor/gameinstructor_server.lua")
    include("gameinstructor/gameinstructor_icons.lua")
end

if CLIENT then
    include("gameinstructor/gameinstructor_client.lua")
    include("gameinstructor/gameinstructor_icons.lua")
end