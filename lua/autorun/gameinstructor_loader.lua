GIIcons = GIIcons or {}
GISounds = GISounds or {}

AddCSLuaFile("gameinstructor/gameinstructor_icons.lua")
AddCSLuaFile("gameinstructor/gameinstructor_sounds.lua")

if SERVER then
    include("gameinstructor/gameinstructor_server.lua")
    include("gameinstructor/gameinstructor_icons.lua")
    include("gameinstructor/gameinstructor_sounds.lua")
end

if CLIENT then
    include("gameinstructor/gameinstructor_client.lua")
    include("gameinstructor/gameinstructor_icons.lua")
    include("gameinstructor/gameinstructor_sounds.lua")
end