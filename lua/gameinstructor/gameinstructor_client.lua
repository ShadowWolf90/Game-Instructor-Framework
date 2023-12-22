print("[Game Instructor [CLIENT]] Loaded.")

local HintsTable = {}
local SmoothTargetX = {}
local SmoothTargetY = {}
local SmoothArrowX = {}
local SmoothArrowY = {}
local HintSoundPlayed = {}

net.Receive("GINetwork", function()
    HintsTable = net.ReadTable()
end)

surface.CreateFont( "HintFont", {
    font = "Arial", 
    extended = false,
    size = 20,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = true,
    additive = false,
    outline = true,
} )


local function DisplayHints()
    local HintX = {}
    local HintY = {}
    local ArrowHintX = {}
    local ArrowHintY = {}
    local ArrowTexture = Material("gi_arrow/arrow_up.png")

    for index, hint in pairs(HintsTable) do

        local HintPosition = hint.position
        local IconType = hint.icontype
        local HintText = hint.hinttext
        local HintSnd = hint.hintsound
        local HintID = hint.uniqueid


        local HintOnScreen = HintPosition:ToScreen()
        local HalfScreenX = ScrW() / 2
        local HalfScreenY = ScrH() / 2
        local Radius = ScrH() * 0.25
        local ArrowRadius = ScrH() * 0.3
        local OnScreenHintPos = math.atan2(HintOnScreen.y - HalfScreenY, HintOnScreen.x - HalfScreenX)
        local HintArrowRotation = math.NormalizeAngle(0 - math.deg(OnScreenHintPos)) - 90
        HintX[index] = HalfScreenX + math.cos(OnScreenHintPos) * Radius
        HintY[index] = HalfScreenY + math.sin(OnScreenHintPos) * Radius
        ArrowHintX[index] = HalfScreenX + math.cos(OnScreenHintPos) * ArrowRadius
        ArrowHintY[index] = HalfScreenY + math.sin(OnScreenHintPos) * ArrowRadius

        if (HintOnScreen.x < 0 or HintOnScreen.x > ScrW() or HintOnScreen.y < 0 or HintOnScreen.y > ScrH()) then
            SmoothTargetX[index] = Lerp(FrameTime() / 0.1, SmoothTargetX[index] or HalfScreenX, HintX[index])
            SmoothTargetY[index] = Lerp(FrameTime() / 0.1, SmoothTargetY[index] or HalfScreenY, HintY[index])
            SmoothArrowX[index] = Lerp(FrameTime() / 0.1, SmoothArrowX[index] or HalfScreenX, ArrowHintX[index])
            SmoothArrowY[index] = Lerp(FrameTime() / 0.1, SmoothArrowY[index] or HalfScreenY, ArrowHintY[index])
            surface.SetMaterial(GIIcons[IconType])
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRectRotated(SmoothTargetX[index], SmoothTargetY[index], 50, 50, 0)
            surface.SetMaterial(ArrowTexture)
            surface.DrawTexturedRectRotated(SmoothArrowX[index], SmoothArrowY[index], 50, 50, HintArrowRotation)
        else
            SmoothTargetX[index] = Lerp(FrameTime() / 0.1, SmoothTargetX[index] or HalfScreenX, HintOnScreen.x)
            SmoothTargetY[index] = Lerp(FrameTime() / 0.1, SmoothTargetY[index] or HalfScreenY, HintOnScreen.y)
            SmoothArrowX[index] = Lerp(FrameTime() / 0.1, SmoothArrowX[index] or HalfScreenX, HintOnScreen.x)
            SmoothArrowY[index] = Lerp(FrameTime() / 0.1, SmoothArrowY[index] or HalfScreenY, HintOnScreen.y)
            surface.SetMaterial(GIIcons[IconType])
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawTexturedRectRotated(SmoothTargetX[index], SmoothTargetY[index], 50, 50, 0)
            draw.SimpleText(HintText, "HintFont", SmoothTargetX[index] + 30, SmoothTargetY[index], Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        if HintSoundPlayed[index] != true and HintSnd != nil and GISounds[HintSnd] then
            surface.PlaySound(GISounds[HintSnd])
            HintSoundPlayed[index] = true
        end
    end
end

hook.Add("HUDPaint", "GIHUDManager", DisplayHints)

hook.Add( "InitPostEntity", "LoadGIContentClient", function()
	AddGIIcons()
    AddGISounds()
end)