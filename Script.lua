local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local UIS          = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LP           = Players.LocalPlayer
local Camera       = workspace.CurrentCamera

-- ════════════════════════════════════════════
-- INTRO
-- ════════════════════════════════════════════
do
    local ig = Instance.new("ScreenGui", game.CoreGui)
    ig.IgnoreGuiInset = true

    local bg = Instance.new("Frame", ig)
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.new(0, 0, 0)
    bg.BorderSizePixel = 0

    local t1 = Instance.new("TextLabel", bg)
    t1.Size = UDim2.new(1, 0, 0, 40)
    t1.Position = UDim2.new(0, 0, 0.5, -36)
    t1.BackgroundTransparency = 1
    t1.Text = "Made by"
    t1.TextColor3 = Color3.fromRGB(160, 140, 220)
    t1.Font = Enum.Font.Gotham
    t1.TextScaled = true
    t1.TextTransparency = 1

    local t2 = Instance.new("TextLabel", bg)
    t2.Size = UDim2.new(1, 0, 0, 60)
    t2.Position = UDim2.new(0, 0, 0.5, -4)
    t2.BackgroundTransparency = 1
    t2.Text = "Scykl"
    t2.TextColor3 = Color3.new(1, 1, 1)
    t2.Font = Enum.Font.GothamBlack
    t2.TextScaled = true
    t2.TextTransparency = 1

    local line = Instance.new("Frame", bg)
    line.Size = UDim2.new(0, 0, 0, 2)
    line.Position = UDim2.new(0.5, 0, 0.5, 58)
    line.BackgroundColor3 = Color3.fromRGB(128, 88, 255)
    line.BorderSizePixel = 0
    local lc = Instance.new("UICorner", line); lc.CornerRadius = UDim.new(1, 0)

    TweenService:Create(t1, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
    task.wait(0.3)
    TweenService:Create(t2, TweenInfo.new(0.55, Enum.EasingStyle.Back), { TextTransparency = 0 }):Play()
    task.wait(0.2)
    TweenService:Create(line, TweenInfo.new(0.45), {
        Size = UDim2.new(0, 200, 0, 2),
        Position = UDim2.new(0.5, -100, 0.5, 58),
    }):Play()
    task.wait(1.6)
    TweenService:Create(bg, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(t1, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
    TweenService:Create(t2, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
    TweenService:Create(line, TweenInfo.new(0.3), { BackgroundTransparency = 1 }):Play()
    task.wait(0.55)
    ig:Destroy()
end

-- ════════════════════════════════════════════
-- CONFIG
-- ════════════════════════════════════════════
local Config = {
    Aimbot      = false,
    ESP         = false,
    TeamCheck   = true,
    VisCheck    = true,
    FovRadius   = 120,
    Smoothness  = 0.12,
    AimPart     = "Head",
}

-- ════════════════════════════════════════════
-- COLOURS
-- ════════════════════════════════════════════
local C = {
    BG      = Color3.fromRGB(15, 13, 24),
    BG2     = Color3.fromRGB(20, 18, 32),
    SIDEBAR = Color3.fromRGB(18, 16, 28),
    CARD    = Color3.fromRGB(26, 24, 40),
    CARD2   = Color3.fromRGB(32, 30, 48),
    BORDER  = Color3.fromRGB(55, 50, 85),
    TEXT    = Color3.fromRGB(224, 224, 244),
    SUB     = Color3.fromRGB(140, 134, 174),
    ACCENT  = Color3.fromRGB(128, 88, 255),
    ACCENT2 = Color3.fromRGB(255, 88, 168),
    GREEN   = Color3.fromRGB(68, 210, 126),
    RED     = Color3.fromRGB(212, 72, 92),
    YELLOW  = Color3.fromRGB(255, 210, 50),
    WHITE   = Color3.new(1, 1, 1),
    BLACK   = Color3.new(0, 0, 0),
}

-- ════════════════════════════════════════════
-- GUI ROOT  (CoreGui so it survives resets)
-- ════════════════════════════════════════════
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ScyklHub"
gui.IgnoreGuiInset = true

-- ════════════════════════════════════════════
-- MAIN WINDOW
-- ════════════════════════════════════════════
local WIN_W, WIN_H = 520, 370
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, WIN_W, 0, WIN_H)
main.Position = UDim2.new(0.5, -WIN_W/2, 0.5, -WIN_H/2)
main.BackgroundColor3 = C.BG
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
local mc = Instance.new("UICorner", main); mc.CornerRadius = UDim.new(0, 14)
local ms = Instance.new("UIStroke", main); ms.Color = C.BORDER; ms.Thickness = 1.4

-- ════════════════════════════════════════════
-- TOP BAR
-- ════════════════════════════════════════════
local topBar = Instance.new("Frame", main)
topBar.Size = UDim2.new(1, 0, 0, 48)
topBar.BackgroundColor3 = C.BG2
topBar.BorderSizePixel = 0
local tc = Instance.new("UICorner", topBar); tc.CornerRadius = UDim.new(0, 14)
-- cover bottom corners of topbar
local tfix = Instance.new("Frame", topBar)
tfix.Size = UDim2.new(1, 0, 0.5, 0)
tfix.Position = UDim2.new(0, 0, 0.5, 0)
tfix.BackgroundColor3 = C.BG2
tfix.BorderSizePixel = 0

local tgrad = Instance.new("UIGradient", topBar)
tgrad.Color = ColorSequence.new(Color3.fromRGB(28, 16, 54), C.BG2)
tgrad.Rotation = 90

-- Title
local titleLbl = Instance.new("TextLabel", topBar)
titleLbl.Size = UDim2.new(0, 160, 1, 0)
titleLbl.Position = UDim2.new(0, 14, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "ScyklHub  PL"
titleLbl.TextColor3 = C.TEXT
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextScaled = true
titleLbl.TextXAlignment = Enum.TextXAlignment.Left

-- Version badge
local badge = Instance.new("Frame", topBar)
badge.Size = UDim2.new(0, 70, 0, 22)
badge.Position = UDim2.new(0, 176, 0.5, -11)
badge.BackgroundColor3 = C.ACCENT
badge.BorderSizePixel = 0
local bc = Instance.new("UICorner", badge); bc.CornerRadius = UDim.new(0, 7)
local badgeG = Instance.new("UIGradient", badge)
badgeG.Color = ColorSequence.new(C.ACCENT, C.ACCENT2)
badgeG.Rotation = 45
local badgeLbl = Instance.new("TextLabel", badge)
badgeLbl.Size = UDim2.fromScale(1, 1)
badgeLbl.BackgroundTransparency = 1
badgeLbl.Text = "Aimbot v3"
badgeLbl.TextColor3 = C.WHITE
badgeLbl.Font = Enum.Font.GothamBold
badgeLbl.TextScaled = true

-- Status dot + label
local statusDot = Instance.new("Frame", topBar)
statusDot.Size = UDim2.new(0, 10, 0, 10)
statusDot.Position = UDim2.new(1, -80, 0.5, -5)
statusDot.BackgroundColor3 = C.RED
statusDot.BorderSizePixel = 0
local sdc = Instance.new("UICorner", statusDot); sdc.CornerRadius = UDim.new(1, 0)

local statusLbl = Instance.new("TextLabel", topBar)
statusLbl.Size = UDim2.new(0, 60, 1, 0)
statusLbl.Position = UDim2.new(1, -78, 0, 0)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "OFF"
statusLbl.TextColor3 = C.RED
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextScaled = true
statusLbl.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    while statusDot and statusDot.Parent do
        local on = Config.Aimbot
        statusDot.BackgroundColor3 = on and C.GREEN or C.RED
        statusLbl.TextColor3 = on and C.GREEN or C.RED
        statusLbl.Text = on and "ON" or "OFF"
        task.wait(0.2)
    end
end)

-- Minimize button
local minBtn = Instance.new("TextButton", topBar)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -36, 0.5, -14)
minBtn.BackgroundColor3 = Color3.fromRGB(36, 32, 64)
minBtn.TextColor3 = C.TEXT
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextScaled = true
minBtn.BorderSizePixel = 0
local mnc = Instance.new("UICorner", minBtn); mnc.CornerRadius = UDim.new(1, 0)
local mns = Instance.new("UIStroke", minBtn); mns.Color = C.BORDER; mns.Thickness = 1

-- ════════════════════════════════════════════
-- BODY
-- ════════════════════════════════════════════
local body = Instance.new("Frame", main)
body.Size = UDim2.new(1, 0, 1, -48)
body.Position = UDim2.new(0, 0, 0, 48)
body.BackgroundTransparency = 1
body.BorderSizePixel = 0

-- ════════════════════════════════════════════
-- SIDEBAR
-- ════════════════════════════════════════════
local SB_W = 120
local sidebar = Instance.new("Frame", body)
sidebar.Size = UDim2.new(0, SB_W, 1, 0)
sidebar.BackgroundColor3 = C.SIDEBAR
sidebar.BorderSizePixel = 0

local sbGrad = Instance.new("UIGradient", sidebar)
sbGrad.Color = ColorSequence.new(C.SIDEBAR, Color3.fromRGB(10, 9, 18))
sbGrad.Rotation = 180

local sbDiv = Instance.new("Frame", body)
sbDiv.Size = UDim2.new(0, 1, 1, 0)
sbDiv.Position = UDim2.new(0, SB_W, 0, 0)
sbDiv.BackgroundColor3 = C.BORDER
sbDiv.BorderSizePixel = 0

local sbFooter = Instance.new("TextLabel", sidebar)
sbFooter.Size = UDim2.new(1, 0, 0, 22)
sbFooter.Position = UDim2.new(0, 0, 1, -24)
sbFooter.BackgroundTransparency = 1
sbFooter.Text = "ScyklHub"
sbFooter.TextColor3 = C.SUB
sbFooter.Font = Enum.Font.Gotham
sbFooter.TextScaled = true

-- ════════════════════════════════════════════
-- CONTENT AREA
-- ════════════════════════════════════════════
local content = Instance.new("Frame", body)
content.Size = UDim2.new(1, -(SB_W + 8), 1, -6)
content.Position = UDim2.new(0, SB_W + 6, 0, 3)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ClipsDescendants = true

-- ════════════════════════════════════════════
-- HELPER: TWEEN
-- ════════════════════════════════════════════
local function TW(obj, props, t, style, dir)
    if not obj or not obj.Parent then return end
    local ok, tw = pcall(TweenService.Create, TweenService, obj,
        TweenInfo.new(t or 0.2, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
    if ok and tw then tw:Play() end
end

-- ════════════════════════════════════════════
-- HELPER: SCROLL CONTAINER
-- ════════════════════════════════════════════
local function MkScroll(parent)
    local sc = Instance.new("ScrollingFrame", parent)
    sc.Size = UDim2.new(1, 0, 1, -32)
    sc.Position = UDim2.new(0, 0, 0, 32)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 3
    sc.ScrollBarImageColor3 = C.ACCENT
    sc.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sc.CanvasSize = UDim2.new(0, 0, 0, 0)
    local ll = Instance.new("UIListLayout", sc)
    ll.SortOrder = Enum.SortOrder.LayoutOrder
    ll.Padding = UDim.new(0, 6)
    local pad = Instance.new("UIPadding", sc)
    pad.PaddingLeft = UDim.new(0, 6)
    pad.PaddingRight = UDim.new(0, 6)
    pad.PaddingTop = UDim.new(0, 4)
    return sc
end

-- ════════════════════════════════════════════
-- HELPER: SECTION HEADER
-- ════════════════════════════════════════════
local function MkSection(parent, text)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 22)
    row.BackgroundTransparency = 1
    row.BorderSizePixel = 0
    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -4, 1, 0)
    lbl.Position = UDim2.new(0, 4, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = C.ACCENT
    lbl.Font = Enum.Font.GothamBold
    lbl.TextScaled = true
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    local div = Instance.new("Frame", row)
    div.Size = UDim2.new(1, 0, 0, 1)
    div.Position = UDim2.new(0, 0, 1, -1)
    div.BackgroundColor3 = C.BORDER
    div.BorderSizePixel = 0
end

-- ════════════════════════════════════════════
-- HELPER: TOGGLE ROW
-- ════════════════════════════════════════════
local function MkToggle(parent, label, desc, getVal, setVal, onChange)
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 52)
    row.BackgroundColor3 = C.CARD
    row.BorderSizePixel = 0
    local rc = Instance.new("UICorner", row); rc.CornerRadius = UDim.new(0, 10)
    local rs = Instance.new("UIStroke", row); rs.Color = C.BORDER; rs.Thickness = 1

    local dot = Instance.new("Frame", row)
    dot.Size = UDim2.new(0, 7, 0, 7)
    dot.Position = UDim2.new(0, 9, 0.5, -3.5)
    dot.BackgroundColor3 = getVal() and C.GREEN or C.SUB
    dot.BorderSizePixel = 0
    local dc = Instance.new("UICorner", dot); dc.CornerRadius = UDim.new(1, 0)

    local mainLbl = Instance.new("TextLabel", row)
    mainLbl.Size = UDim2.new(1, -96, 0, 20)
    mainLbl.Position = UDim2.new(0, 23, 0, 6)
    mainLbl.BackgroundTransparency = 1
    mainLbl.Text = label
    mainLbl.TextColor3 = C.TEXT
    mainLbl.Font = Enum.Font.GothamBold
    mainLbl.TextScaled = true
    mainLbl.TextXAlignment = Enum.TextXAlignment.Left

    local subLbl = Instance.new("TextLabel", row)
    subLbl.Size = UDim2.new(1, -96, 0, 16)
    subLbl.Position = UDim2.new(0, 23, 0, 28)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = desc
    subLbl.TextColor3 = C.SUB
    subLbl.Font = Enum.Font.Gotham
    subLbl.TextScaled = true
    subLbl.TextXAlignment = Enum.TextXAlignment.Left

    local track = Instance.new("Frame", row)
    track.Size = UDim2.new(0, 46, 0, 22)
    track.Position = UDim2.new(1, -54, 0.5, -11)
    track.BackgroundColor3 = getVal() and C.GREEN or C.RED
    track.BorderSizePixel = 0
    local trc = Instance.new("UICorner", track); trc.CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", track)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = getVal() and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    knob.BackgroundColor3 = C.WHITE
    knob.BorderSizePixel = 0
    local kc = Instance.new("UICorner", knob); kc.CornerRadius = UDim.new(1, 0)

    local tbtn = Instance.new("TextButton", track)
    tbtn.Size = UDim2.fromScale(1, 1)
    tbtn.BackgroundTransparency = 1
    tbtn.Text = ""
    tbtn.BorderSizePixel = 0

    local function Refresh()
        local v = getVal()
        TW(track, { BackgroundColor3 = v and C.GREEN or C.RED }, 0.13)
        TW(knob, { Position = v and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8) }, 0.13)
        TW(dot, { BackgroundColor3 = v and C.GREEN or C.SUB }, 0.13)
    end

    tbtn.MouseButton1Click:Connect(function()
        setVal(not getVal())
        Refresh()
        if onChange then pcall(onChange, getVal()) end
    end)

    row.MouseEnter:Connect(function() TW(row, { BackgroundColor3 = C.CARD2 }, 0.1) end)
    row.MouseLeave:Connect(function() TW(row, { BackgroundColor3 = C.CARD }, 0.1) end)
end

-- ════════════════════════════════════════════
-- HELPER: SLIDER
-- ════════════════════════════════════════════
local function MkSlider(parent, label, vmin, vmax, getVal, setVal, fmtFn)
    local range = vmax - vmin
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 56)
    row.BackgroundColor3 = C.CARD
    row.BorderSizePixel = 0
    local rc = Instance.new("UICorner", row); rc.CornerRadius = UDim.new(0, 10)
    local rs = Instance.new("UIStroke", row); rs.Color = C.BORDER; rs.Thickness = 1

    local mainLbl = Instance.new("TextLabel", row)
    mainLbl.Size = UDim2.new(0.58, 0, 0, 22)
    mainLbl.Position = UDim2.new(0, 12, 0, 5)
    mainLbl.BackgroundTransparency = 1
    mainLbl.Text = label
    mainLbl.TextColor3 = C.TEXT
    mainLbl.Font = Enum.Font.GothamBold
    mainLbl.TextScaled = true
    mainLbl.TextXAlignment = Enum.TextXAlignment.Left

    local function fmt(v) return fmtFn and fmtFn(v) or tostring(math.floor(v)) end

    local valLbl = Instance.new("TextLabel", row)
    valLbl.Size = UDim2.new(0.38, 0, 0, 22)
    valLbl.Position = UDim2.new(0.6, 0, 0, 5)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = fmt(getVal())
    valLbl.TextColor3 = C.ACCENT
    valLbl.Font = Enum.Font.GothamBold
    valLbl.TextScaled = true
    valLbl.TextXAlignment = Enum.TextXAlignment.Right

    local trk = Instance.new("Frame", row)
    trk.Size = UDim2.new(1, -24, 0, 6)
    trk.Position = UDim2.new(0, 12, 0, 36)
    trk.BackgroundColor3 = C.BG2
    trk.BorderSizePixel = 0
    local trc = Instance.new("UICorner", trk); trc.CornerRadius = UDim.new(1, 0)

    local pct0 = (getVal() - vmin) / range
    local fill = Instance.new("Frame", trk)
    fill.Size = UDim2.new(pct0, 0, 1, 0)
    fill.BackgroundColor3 = C.ACCENT
    fill.BorderSizePixel = 0
    local fc = Instance.new("UICorner", fill); fc.CornerRadius = UDim.new(1, 0)
    local fg = Instance.new("UIGradient", fill)
    fg.Color = ColorSequence.new(C.ACCENT, C.ACCENT2)
    fg.Rotation = 0

    local knob = Instance.new("Frame", trk)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(pct0, -7, 0.5, -7)
    knob.BackgroundColor3 = C.WHITE
    knob.BorderSizePixel = 0
    local kc = Instance.new("UICorner", knob); kc.CornerRadius = UDim.new(1, 0)

    local dragging = false
    knob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local abs = trk.AbsolutePosition
            local sz  = trk.AbsoluteSize
            local pct = math.clamp((i.Position.X - abs.X) / sz.X, 0, 1)
            local val = vmin + pct * range
            setVal(val)
            valLbl.Text = fmt(val)
            fill.Size = UDim2.new(pct, 0, 1, 0)
            knob.Position = UDim2.new(pct, -7, 0.5, -7)
        end
    end)
end

-- ════════════════════════════════════════════
-- HELPER: DROPDOWN
-- ════════════════════════════════════════════
local function MkDropdown(parent, label, options, getVal, setVal)
    local open = false
    local row = Instance.new("Frame", parent)
    row.Size = UDim2.new(1, 0, 0, 46)
    row.BackgroundColor3 = C.CARD
    row.BorderSizePixel = 0
    local rc = Instance.new("UICorner", row); rc.CornerRadius = UDim.new(0, 10)
    local rs = Instance.new("UIStroke", row); rs.Color = C.BORDER; rs.Thickness = 1

    local mainLbl = Instance.new("TextLabel", row)
    mainLbl.Size = UDim2.new(0.52, 0, 1, 0)
    mainLbl.Position = UDim2.new(0, 12, 0, 0)
    mainLbl.BackgroundTransparency = 1
    mainLbl.Text = label
    mainLbl.TextColor3 = C.TEXT
    mainLbl.Font = Enum.Font.GothamBold
    mainLbl.TextScaled = true
    mainLbl.TextXAlignment = Enum.TextXAlignment.Left

    local selBtn = Instance.new("TextButton", row)
    selBtn.Size = UDim2.new(0, 108, 0, 28)
    selBtn.Position = UDim2.new(1, -116, 0.5, -14)
    selBtn.BackgroundColor3 = C.BG2
    selBtn.TextColor3 = C.TEXT
    selBtn.Text = getVal() .. " v"
    selBtn.Font = Enum.Font.GothamBold
    selBtn.TextScaled = true
    selBtn.BorderSizePixel = 0
    local sc = Instance.new("UICorner", selBtn); sc.CornerRadius = UDim.new(0, 8)
    local ss = Instance.new("UIStroke", selBtn); ss.Color = C.BORDER; ss.Thickness = 1

    local drop = Instance.new("Frame", row)
    drop.Size = UDim2.new(0, 108, 0, 0)
    drop.Position = UDim2.new(1, -116, 1, 3)
    drop.BackgroundColor3 = C.BG2
    drop.BorderSizePixel = 0
    drop.Visible = false
    drop.ZIndex = 20
    local dc = Instance.new("UICorner", drop); dc.CornerRadius = UDim.new(0, 8)
    local ds = Instance.new("UIStroke", drop); ds.Color = C.ACCENT; ds.Thickness = 1.2

    for i, opt in ipairs(options) do
        local ob = Instance.new("TextButton", drop)
        ob.Size = UDim2.new(1, 0, 0, 28)
        ob.Position = UDim2.new(0, 0, 0, (i - 1) * 28)
        ob.BackgroundTransparency = 1
        ob.TextColor3 = C.TEXT
        ob.Text = opt
        ob.Font = Enum.Font.GothamMedium
        ob.TextScaled = true
        ob.BorderSizePixel = 0
        ob.ZIndex = 21
        ob.MouseEnter:Connect(function() TW(ob, { BackgroundColor3 = C.CARD }, 0.08); ob.BackgroundTransparency = 0 end)
        ob.MouseLeave:Connect(function() ob.BackgroundTransparency = 1 end)
        ob.MouseButton1Click:Connect(function()
            setVal(opt); selBtn.Text = opt .. " v"
            open = false
            TW(drop, { Size = UDim2.new(0, 108, 0, 0) }, 0.14)
            task.delay(0.16, function() drop.Visible = false end)
        end)
    end

    selBtn.MouseButton1Click:Connect(function()
        open = not open
        drop.Visible = true
        TW(drop, { Size = UDim2.new(0, 108, 0, #options * 28) }, 0.18, Enum.EasingStyle.Back)
    end)
end

-- ════════════════════════════════════════════
-- HELPER: INFO LABEL
-- ════════════════════════════════════════════
local function MkInfo(parent, text, col)
    local l = Instance.new("TextLabel", parent)
Aimbot=false,
TeamCheck=true
}

---

-- ESP COMPLETO (CAIXA + ANTENA + NICK + METROS)

local drawings={}

local function createESP(plr)
if plr==LocalPlayer then return end
local box=Drawing.new("Square")
box.Color=Color3.fromRGB(0,255,120)
box.Thickness=2
box.Filled=false

local line=Drawing.new("Line")
line.Color=box.Color
line.Thickness=2

local name=Drawing.new("Text")
name.Size=16
name.Center=true
name.Outline=true
name.Color=Color3.new(1,1,1)

drawings[plr]={box,line,name}
end

for _,p in pairs(Players:GetPlayers()) do createESP(p) end
Players.PlayerAdded:Connect(createESP)

RunService.RenderStepped:Connect(function()
for plr,obj in pairs(drawings) do
local char=plr.Character
local hrp=char and char:FindFirstChild("HumanoidRootPart")
local hum=char and char:FindFirstChildOfClass("Humanoid")

if Config.ESP and hrp and hum and hum.Health>0 then
local pos,vis=Camera:WorldToViewportPoint(hrp.Position)
if vis then
local dist=(Camera.CFrame.Position-hrp.Position).Magnitude
local scale=1/(dist*0.05)*100
local size=Vector2.new(30,50)*scale

obj.box.Size=size
obj.box.Position=Vector2.new(pos.X-size.X/2,pos.Y-size.Y/2)
obj.box.Visible=true

obj.line.From=Vector2.new(pos.X,pos.Y-size.Y/2)
obj.line.To=Vector2.new(pos.X,pos.Y-size.Y/2-18)
obj.line.Visible=true

obj.name.Text=plr.Name.." - "..math.floor(dist).."m"
obj.name.Position=Vector2.new(pos.X,pos.Y-size.Y/2-30)
obj.name.Visible=true
else
obj.box.Visible=false
obj.line.Visible=false
obj.name.Visible=false
end
else
obj.box.Visible=false
obj.line.Visible=false
obj.name.Visible=false
end
end
end)

---

-- AIMBOT MOBILE (SEM Q / COM FOV CIRCLE)

local fov=Drawing.new("Circle")
fov.Radius=120
fov.Filled=false
fov.Thickness=2
fov.Color=Color3.fromRGB(140,110,255)
fov.Visible=true

local aimBtn=Instance.new("TextButton",main)
aimBtn.Size=UDim2.new(0,140,0,40)
aimBtn.Position=UDim2.new(0,20,1,-60)
aimBtn.Text="Aimbot: OFF"
aimBtn.BackgroundColor3=Color3.fromRGB(60,50,100)
aimBtn.TextScaled=true
Instance.new("UICorner",aimBtn).CornerRadius=UDim.new(0,10)

aimBtn.MouseButton1Click:Connect(function()
Config.Aimbot=not Config.Aimbot
aimBtn.Text=Config.Aimbot and "Aimbot: ON" or "Aimbot: OFF"
end)

RunService.RenderStepped:Connect(function()
local m=UIS:GetMouseLocation()
fov.Position=m

if not Config.Aimbot then return end

local closest=nil
local dist=1e9

for _,plr in pairs(Players:GetPlayers()) do
if plr~=LocalPlayer then
if not Config.TeamCheck or plr.Team~=LocalPlayer.Team then
local char=plr.Character
local head=char and char:FindFirstChild("Head")
local hum=char and char:FindFirstChildOfClass("Humanoid")
if head and hum and hum.Health>0 then
local pos,vis=Camera:WorldToViewportPoint(head.Position)
if vis then
local d=(Vector2.new(pos.X,pos.Y)-m).Magnitude
if d<fov.Radius and d<dist then
dist=d
closest=head
end
end
end
end
end
end

if closest then
Camera.CFrame=CFrame.new(Camera.CFrame.Position,closest.Position)
end
end)

---

-- SAVE CONFIG (SIMPLES)

local save=Instance.new("TextButton",main)
save.Size=UDim2.new(0,140,0,36)
save.Position=UDim2.new(1,-160,1,-60)
save.Text="Save Config"
save.TextScaled=true
save.BackgroundColor3=Color3.fromRGB(80,70,140)
Instance.new("UICorner",save).CornerRadius=UDim.new(0,10)

save.MouseButton1Click:Connect(function()
if writefile then
writefile("ScyklHub.json",game:GetService("HttpService"):JSONEncode(Config))
end
end)
