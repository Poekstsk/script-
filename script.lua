local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")

local LP=Players.LocalPlayer
if not LP then return end
local PlayerGui=LP:WaitForChild("PlayerGui")
local Cam=workspace.CurrentCamera

-- INTRO (black screen + fade text)
do
local intro=Instance.new("ScreenGui")
intro.IgnoreGuiInset=true
intro.Parent=PlayerGui

local bg=Instance.new("Frame",intro)
bg.Size=UDim2.fromScale(1,1)
bg.BackgroundColor3=Color3.new(0,0,0)

local txt=Instance.new("TextLabel",bg)
txt.AnchorPoint=Vector2.new(.5,.5)
txt.Position=UDim2.fromScale(.5,.5)
txt.Size=UDim2.new(.8,0,.2,0)
txt.BackgroundTransparency=1
txt.Text="Made by Scykl"
txt.TextColor3=Color3.new(1,1,1)
txt.TextScaled=true
txt.Font=Enum.Font.GothamBold
txt.TextTransparency=1

TweenService:Create(txt,TweenInfo.new(.8),{TextTransparency=0}):Play()
task.wait(1.6)
TweenService:Create(bg,TweenInfo.new(.8),{BackgroundTransparency=1}):Play()
TweenService:Create(txt,TweenInfo.new(.8),{TextTransparency=1}):Play()
task.wait(.9)
intro:Destroy()
end

-- HUB
local gui=Instance.new("ScreenGui")
gui.Name="ScyklHub"
gui.ResetOnSpawn=false
gui.Parent=PlayerGui

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,240,0,140)
frame.Position=UDim2.new(.05,0,.35,0)
frame.BackgroundColor3=Color3.fromRGB(18,18,18)
frame.BorderSizePixel=0

local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0,30)
title.BackgroundTransparency=1
title.Text="Scykl Hub"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.GothamBold
title.TextSize=20

local toggle=Instance.new("TextButton",frame)
toggle.Size=UDim2.new(.9,0,0,36)
toggle.Position=UDim2.new(.05,0,.45,0)
toggle.BackgroundColor3=Color3.fromRGB(40,40,40)
toggle.TextColor3=Color3.new(1,1,1)
toggle.Font=Enum.Font.GothamBold
toggle.TextSize=18
toggle.Text="Aimbot: OFF"

local info=Instance.new("TextLabel",frame)
info.Size=UDim2.new(1,0,0,20)
info.Position=UDim2.new(0,0,1,-20)
info.BackgroundTransparency=1
info.Text="Hold Q to aim"
info.TextColor3=Color3.fromRGB(170,170,170)
info.Font=Enum.Font.Gotham
info.TextSize=14

-- DRAG
do
local dragging=false
local dragStart,startPos
frame.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=i.Position
startPos=frame.Position
end
end)
UIS.InputChanged:Connect(function(i)
if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
local delta=i.Position-dragStart
frame.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)
UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)
end

-- AIMBOT REAL
local aimbot=false
local holding=false
local radius=140

toggle.MouseButton1Click:Connect(function()
aimbot=not aimbot
toggle.Text="Aimbot: "..(aimbot and "ON" or "OFF")
end)

UIS.InputBegan:Connect(function(i,g)
if g then return end
if i.KeyCode==Enum.KeyCode.Q then
holding=true
end
end)

UIS.InputEnded:Connect(function(i)
if i.KeyCode==Enum.KeyCode.Q then
holding=false
end
end)

local function getTarget()
local best=nil
local dist=math.huge
local center=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)

for _,p in pairs(Players:GetPlayers()) do
if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
local hrp=p.Character.HumanoidRootPart
local hum=p.Character:FindFirstChildOfClass("Humanoid")
if hum and hum.Health>0 then
local pos,vis=Cam:WorldToViewportPoint(hrp.Position)
if vis then
local d=(Vector2.new(pos.X,pos.Y)-center).Magnitude
if d<radius and d<dist then
dist=d
best=hrp
end
end
end
end
end
return best
end

RunService.RenderStepped:Connect(function()
if aimbot and holding then
local target=getTarget()
if target then
Cam.CFrame=Cam.CFrame:Lerp(CFrame.lookAt(Cam.CFrame.Position,target.Position),0.25)
end
end
end)

-- FOV
local circle=Drawing.new("Circle")
circle.Radius=radius
circle.Thickness=2
circle.NumSides=40
circle.Filled=false
circle.Visible=true

RunService.RenderStepped:Connect(function()
circle.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)
end)
