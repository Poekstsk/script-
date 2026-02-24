local ok,err=pcall(function()

local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")

local LP=Players.LocalPlayer
if not LP then return end

local PlayerGui=LP:WaitForChild("PlayerGui")
local Cam=workspace.CurrentCamera

-- GUI
local gui=Instance.new("ScreenGui")
gui.Name="ScyklHub"
gui.ResetOnSpawn=false
gui.Parent=PlayerGui

local frame=Instance.new("Frame",gui)
frame.Size=UDim2.new(0,220,0,140)
frame.Position=UDim2.new(0.05,0,0.3,0)
frame.BackgroundColor3=Color3.fromRGB(20,20,20)
frame.BorderSizePixel=0

local title=Instance.new("TextLabel",frame)
title.Size=UDim2.new(1,0,0,30)
title.BackgroundTransparency=1
title.Text="Scykl Hub"
title.TextColor3=Color3.new(1,1,1)
title.Font=Enum.Font.SourceSansBold
title.TextSize=20

local toggle=Instance.new("TextButton",frame)
toggle.Size=UDim2.new(0.9,0,0,35)
toggle.Position=UDim2.new(0.05,0,0,45)
toggle.BackgroundColor3=Color3.fromRGB(40,40,40)
toggle.TextColor3=Color3.new(1,1,1)
toggle.Font=Enum.Font.SourceSansBold
toggle.TextSize=18
toggle.Text="Aimbot: ON"

local info=Instance.new("TextLabel",frame)
info.Size=UDim2.new(1,0,0,20)
info.Position=UDim2.new(0,0,1,-20)
info.BackgroundTransparency=1
info.Text="Hold Q to aim"
info.TextColor3=Color3.fromRGB(180,180,180)
info.Font=Enum.Font.SourceSans
info.TextSize=14

-- drag mobile/pc
do
local dragging=false
local dragStart,startPos

frame.InputBegan:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1
or i.UserInputType==Enum.UserInputType.Touch then
dragging=true
dragStart=i.Position
startPos=frame.Position
end
end)

UIS.InputChanged:Connect(function(i)
if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement
or i.UserInputType==Enum.UserInputType.Touch) then
local delta=i.Position-dragStart
frame.Position=UDim2.new(
startPos.X.Scale,startPos.X.Offset+delta.X,
startPos.Y.Scale,startPos.Y.Offset+delta.Y)
end
end)

UIS.InputEnded:Connect(function(i)
if i.UserInputType==Enum.UserInputType.MouseButton1
or i.UserInputType==Enum.UserInputType.Touch then
dragging=false
end
end)
end

-- settings
local S={
aimbot=true,
holding=false,
radius=130,
smooth=0.15,
teamCheck=true,
visible=true,
part="Head"
}

toggle.MouseButton1Click:Connect(function()
S.aimbot=not S.aimbot
toggle.Text="Aimbot: "..(S.aimbot and "ON" or "OFF")
end)

-- FOV circle
local circle=Drawing.new("Circle")
circle.Thickness=2
circle.NumSides=40
circle.Radius=S.radius
circle.Filled=false
circle.Visible=true

RunService.RenderStepped:Connect(function()
circle.Position=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)
circle.Radius=S.radius
end)

-- input
UIS.InputBegan:Connect(function(i,g)
if not g and i.KeyCode==Enum.KeyCode.Q then
S.holding=true
end
end)

UIS.InputEnded:Connect(function(i)
if i.KeyCode==Enum.KeyCode.Q then
S.holding=false
end
end)

-- helpers
local function root()
local c=LP.Character
return c and c:FindFirstChild("HumanoidRootPart")
end

local function sameTeam(p)
if not S.teamCheck then return false end
if not LP.Team then return false end
return p.Team==LP.Team
end

local function visible(part)
if not S.visible then return true end
local origin=Cam.CFrame.Position
local dir=part.Position-origin
local ray=RaycastParams.new()
ray.FilterType=Enum.RaycastFilterType.Exclude
ray.FilterDescendantsInstances={LP.Character,part.Parent}
local r=workspace:Raycast(origin,dir,ray)
return (not r) or r.Instance:IsDescendantOf(part.Parent)
end

local function target()
local r=root()
if not r then return end

local best=nil
local bestDist=math.huge
local center=Vector2.new(Cam.ViewportSize.X/2,Cam.ViewportSize.Y/2)

for _,p in ipairs(Players:GetPlayers()) do
if p~=LP and p.Character and not sameTeam(p) then

local char=p.Character
local hum=char:FindFirstChildOfClass("Humanoid")
local hrp=char:FindFirstChild("HumanoidRootPart")
local part=char:FindFirstChild(S.part) or hrp

if hum and hrp and part and hum.Health>0 then

local pos,on=Cam:WorldToViewportPoint(part.Position)
if on then
local distScreen=(Vector2.new(pos.X,pos.Y)-center).Magnitude
if distScreen<=S.radius and visible(part) then
local d=(r.Position-hrp.Position).Magnitude
if d<bestDist then
bestDist=d
best=part
end
end
end

end
end
end

return best
end

-- main loop
RunService.RenderStepped:Connect(function()

if not S.aimbot then return end
if not S.holding then return end

local t=target()
if not t then return end

local cf=CFrame.lookAt(Cam.CFrame.Position,t.Position)
Cam.CFrame=Cam.CFrame:Lerp(cf,math.clamp(1-S.smooth,0.02,0.98))

end)

end)

if not ok then warn(err) end
