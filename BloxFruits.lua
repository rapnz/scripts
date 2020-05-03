repeat wait(0,1) until  game:IsLoaded() == true

local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")


local hrootpart = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

function hitfunc()
local VirtualUser = game:GetService("VirtualUser")
	VirtualUser:CaptureController()
    VirtualUser:ClickButton1(Vector2.new(0, 0), CFrame.new(Vector3.new(0, 0, 0)))

end


function takebanditquest() --bandit görevini alma functionu
local A_1 = "StartQuest"
local A_2 = "BanditQuest1"
local A_3 = 1
local Event = game:GetService("ReplicatedStorage").Remotes["CommF_"]
Event:InvokeServer(A_1, A_2, A_3)
end


local plr = game.Players.LocalPlayer
local quest = plr.PlayerGui.Main:FindFirstChild("Quest")
if not quest then
	plr.PlayerGui.Main:WaitForChild("Quest")
end

function farmbebegim()
		for i,v in pairs(enemies:GetChildren()) do
			if v:IsA("Model") and v:FindFirstChild("Humanoid") and v.Humanoid.Health ~= 0 then
				local enemyhumanoid = v:FindFirstChild("Humanoid")
				repeat
					wait(0,1)
					hrootpart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
					hitfunc()
				until enemyhumanoid.Health == 0 or enemyhumanoid == nil or game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health == 0 
			end
	end
end
hitfunc(game.Players.LocalPlayer.Character)


if quest.Visible then
farmbebegim()
else
takebanditquest()
end
