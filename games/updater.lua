local aliveCheck = function(player)
	if player ~= lplr then 
		if player.leaderstats.Bed.Value ~= '✅' and player.Character:WaitForChild('Humanoid').Health == 0 then return false else return nil end
	end
	if player.Character.Humanoid then
		return player.Character.Humanoid.Health ~= 0
	end
    return false
end
local lplr = game.Players.LocalPlayer
local getTarget = function(distance)
	local magnitude, target = distance or math.huge, {}
	if not aliveCheck(lplr) then 
		return target 
	end
	for i,v in game.Players:GetPlayers() do 
		local localpos = (aliveCheck(lplr) and lplr.Character.HumanoidRootPart.Position or Vector3.zero)
		if v ~= lplr and aliveCheck(v) and aliveCheck(lplr) then
			pcall(function()
				local playerdistance = (localpos - v.Character.HumanoidRootPart.Position).Magnitude
				if playerdistance < magnitude then 
					magnitude = playerdistance
					target.Human = true
					target.RootPart = v.Character.HumanoidRootPart
					target.Humanoid = v.Character:WaitForChild('Humanoid')
					target.Player = v
				end
			end)
		end
	end
	return target
end
local update = function()
    local target = getTarget(25)
    if target.RootPart then
        shared.target = {
            Humanoid = target.Humanoid,
            Player = target.Player,
            RootPart = target.RootPart,
            Name = target.Player.Name
        }
    else
        shared.target = {
            Humanoid = nil,
            Player = nil,
            RootPart = nil,
            Name = 'None'
        }
    end
end
shared.updateConnection = game:GetService('RunService').Stepped:Connect(update)
