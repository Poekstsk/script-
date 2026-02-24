local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UIS=game:GetService("UserInputService")
local TweenService=game:GetService("TweenService")
local LocalPlayer=Players.LocalPlayer
local Camera=workspace.CurrentCamera

---

-- INTRO

do
local g=Instance.new("ScreenGui",game.CoreGui)
g.IgnoreGuiInset=true
local f=Instance.new("Frame",g)
f.Size=UDim2.fromScale(1,1)
f.BackgroundColor3=Color3.new(0,0,0)

local t=Instance.new("TextLabel",f)
t.Size=UDim2.fromScale(1,1)
t.BackgroundTransparency=1
t.Text="Made by Scykl"
t.TextColor3=Color3.new(1,1,1)
t.Font=Enum.Font.GothamBlack
t.TextScaled=true
t.TextTransparency=1

TweenService:Create(t,TweenInfo.new(.8),{TextTransparency=0}):Play()
task.wait(1.6)
TweenService:Create(f,TweenInfo.new(.8),{BackgroundTransparency=1}):Play()
TweenService:Create(t,TweenInfo.new(.8),{TextTransparency=1}):Play()
task.wait(.9)
g:Destroy()
end

---

-- HUB BASE (SEU HUB PRETO)

local gui=Instance.new("ScreenGui",game.CoreGui)
gui.Name="ScyklHub"

local main=Instance.new("Frame",gui)
main.Size=UDim2.new(0,520,0,360)
main.Position=UDim2.new(.5,-260,.5,-180)
main.BackgroundColor3=Color3.fromRGB(20,18,30)
main.Active=true
main.Draggable=true
Instance.new("UICorner",main).CornerRadius=UDim.new(0,14)

---

-- BOTÃO MINIMIZAR

local minimize=Instance.new("TextButton",main)
minimize.Size=UDim2.new(0,36,0,36)
minimize.Position=UDim2.new(1,-42,0,6)
minimize.Text="-"
minimize.TextScaled=true
minimize.BackgroundColor3=Color3.fromRGB(90,70,160)
Instance.new("UICorner",minimize).CornerRadius=UDim.new(1,0)

local bubble=Instance.new("TextButton",gui)
bubble.Visible=false
bubble.Size=UDim2.new(0,60,0,60)
bubble.BackgroundColor3=Color3.fromRGB(90,70,160)
bubble.Text=""
bubble.Active=true
bubble.Draggable=true
Instance.new("UICorner",bubble).CornerRadius=UDim.new(1,0)

minimize.MouseButton1Click:Connect(function()
main.Visible=false
bubble.Visible=true
bubble.Position=UDim2.new(0,40,0,200)
end)

bubble.MouseButton1Click:Connect(function()
main.Visible=true
bubble.Visible=false
end)

---

-- CONFIG

local Config={
ESP=true,
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
