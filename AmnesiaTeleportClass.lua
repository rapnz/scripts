--[[
    I don't suggest you to change anything else than TeleportSettings you might break the script if you don't know what you are doing
    I copied the float properties from Infinite Yield because I am a lazy ass
    Made by Amnesia @v3rm
]]

getgenv().Teleport = {}

--//TeleportSettings
Teleport.Speed = 35
Teleport.Notifications = true --Set it to false if you don't want notifications
Teleport.CFrameType = true --Set it to false if you don't want your character rotate when you are teleporting (if you are teleporting a part changing it to false probably better idea)


local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Teleporting = false



function SeatsFunction() --Seats are annoying while teleporting
    for i,v in pairs(workspace:GetDescendants()) do
        if v:IsA("Seat") then
            v.Disabled = not v.Disabled
        end
    end
end

function FloatFunction() --Credits to Infinite Yield
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local Float = Instance.new('Part')
	Float.Name = math.random(1,10000)
	Float.Parent = LocalPlayer.Character
	Float.Transparency = 1
	Float.Size = Vector3.new(6,1,6)
	Float.Anchored = true
	local FloatValue = -3.5
    return Float, FloatValue
end

function Notification(text)
    if not Teleport.Notifications then
        return
    end
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Amnesia Teleport Class", Text = text, Duration = 5})
end

function Teleport:TeleportPlayer(player)
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local TargetChar = Players[player].Character
    local TargetPart = TargetChar:WaitForChild("HumanoidRootPart", 10) or TargetChar:WaitForChild("Torso", 10) or TargetChar:WaitForChild("UpperTorso", 10)
    local Distance = (LocalHRP.Position - TargetPart.Position).magnitude
    local Goal = {CFrame = TargetPart.CFrame}
    if not Teleport.CFrameType then Goal = {CFrame = CFrame.new(TargetPart.Position)}  end
    local Tween = TweenService:Create(LocalHRP, TweenInfo.new(Distance/Teleport.Speed), Goal)
    if not Teleporting and Humanoid.Health > 0 then
    Teleporting = true
    local Float, FloatValue;
    local HumanoidLoop = game:GetService("RunService").Stepped:Connect(function()
        Humanoid:ChangeState("PlatformStanding")
        if not Float then
            Float, FloatValue = FloatFunction()
        end
        Float.CFrame = LocalHRP.CFrame * CFrame.new(0,FloatValue,0)
    end)
    Humanoid.Died:Connect(function()
        if Tween then
            Tween:Cancel()
        end
        if HumanoidLoop then
            HumanoidLoop:Disconnect()
            HumanoidLoop = nil
            if Float then
                Float:Destroy()
                Float = nil
                FloatValue = nil
            end
        end
        Teleporting = false
    end)
    pcall(SeatsFunction)
    Tween:Play()
    pcall(Notification, "Teleporting.. it will take " .. math.floor(Distance/Teleport.Speed) .. " seconds")
    Tween.Completed:Wait()
    HumanoidLoop:Disconnect()
    HumanoidLoop = nil
    pcall(function() if Float then Float:Destroy() Float = nil FloatValue = nil end end) 
    pcall(SeatsFunction)
    Teleporting = false
    else
        return pcall(Notification, "You are currently teleporting")
    end
end
function Teleport:TeleportPart(part)
    local LocalHRP = LocalPlayer.Character:WaitForChild("HumanoidRootPart", 10) or LocalPlayer.Character:WaitForChild("Torso", 10) --I'm adding torso for R6 Teleport Bypass
    local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid", 10)
    local TargetPart = part
    local Distance = (LocalHRP.Position - TargetPart.Position).magnitude
    local Goal = {CFrame = TargetPart.CFrame}
    if not Teleport.CFrameType then Goal = {CFrame = CFrame.new(TargetPart.Position)}  end
    local Tween = TweenService:Create(LocalHRP, TweenInfo.new(Distance/Teleport.Speed), Goal)
    if not Teleporting and Humanoid.Health > 0 then
    Teleporting = true
    local Float, FloatValue;
    local HumanoidLoop = game:GetService("RunService").Stepped:Connect(function()
        Humanoid:ChangeState("PlatformStanding")
        if not Float then
        Float, FloatValue = FloatFunction()
        end
        Float.CFrame = LocalHRP.CFrame * CFrame.new(0,FloatValue,0)
    end)
    Humanoid.Died:Connect(function()
        if Tween then
            Tween:Cancel()
        end
        if HumanoidLoop then
            HumanoidLoop:Disconnect()
            HumanoidLoop = nil
            if Float then
                Float:Destroy()
                Float = nil
                FloatValue = nil
            end
        end
        Teleporting = false
    end)
    pcall(SeatsFunction)
    Tween:Play()
    pcall(Notification, "Teleporting.. it will take " .. math.floor(Distance/Teleport.Speed) .. " seconds")
    Tween.Completed:Wait()
    HumanoidLoop:Disconnect()
    HumanoidLoop = nil
    pcall(function() if Float then Float:Destroy() Float = nil FloatValue = nil end end) 
    pcall(SeatsFunction)
    Teleporting = false
    else
        return pcall(Notification, "You are currently teleporting")
    end
end

print("Amnesia Teleport Class loaded")
