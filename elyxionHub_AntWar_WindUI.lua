-- Open source code
-- Version Re-1.1 (WindUI Converted + Fixed)
-- Original by Edzefd | UI by elyxionHub / lavatrapgaming1

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "elyxionHub",
    Icon = "rbxassetid://13548131415563",
    Author = "By lavatrapgaming1",
    Folder = "elyxionHub",
    Size = UDim2.fromOffset(580, 480),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 150,
    Background = "rbxassetid://135481314155653",
    BackgroundImageTransparency = 0.42,
    HideSearchBar = false,
    ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = false },
})

Window:EditOpenButton({
    Title = "Open elyxionHub ",
    Icon = "rbxassetid://135481314155653",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("007BFF"),
        Color3.fromHex("00BFFF")
    ),
    Draggable = true,
})

local Tabs = {
    Info = Window:Tab({ Title = "Info", Icon = "ghost" }),
    Main = Window:Tab({ Title = "Main", Icon = "gem" }),
    Farm = Window:Tab({ Title = "Farm", Icon = "wheat" }),
    Movement = Window:Tab({ Title = "Movement", Icon = "wind" }),
    Visuals = Window:Tab({ Title = "Visuals", Icon = "eye" }),
    Misc = Window:Tab({ Title = "Misc", Icon = "more-horizontal" }),
    Teleport = Window:Tab({ Title = "Teleport", Icon = "map-pin" }),
}

local InfoTab = Tabs.Info
local MainTab = Tabs.Main
local FarmTab = Tabs.Farm
local MovementTab = Tabs.Movement
local VisualTab = Tabs.Visuals
local MiscTab = Tabs.Misc
local TPTab = Tabs.Teleport

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")

local LP = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local ServerEvents = ReplicatedStorage:WaitForChild("ServerEvents")
local BiteEvent = ServerEvents:WaitForChild("Bite")
local DigEvent = ServerEvents:WaitForChild("Dig")
local LarvaeEvent = ServerEvents:WaitForChild("Larvae")
local AcidEvent = ServerEvents:WaitForChild("Acid")
local StingEvent = ServerEvents:WaitForChild("Sting")
local PheromoneEvent = ServerEvents:WaitForChild("Pheromone") 

local KillSound = Instance.new("Sound", game:GetService("CoreGui"))
KillSound.SoundId = "rbxassetid://2866718318"
KillSound.Volume = 0.4

local HighDmgSound = Instance.new("Sound", game:GetService("CoreGui"))
HighDmgSound.SoundId = "rbxassetid://8255306220"
HighDmgSound.Volume = 0.4

local LowHPSound = Instance.new("Sound", game:GetService("CoreGui"))
LowHPSound.SoundId = "rbxassetid://8502168540"
LowHPSound.Volume = 0.4

local QueenDangerSound = Instance.new("Sound", game:GetService("CoreGui"))
QueenDangerSound.SoundId = "rbxassetid://6243260174"
QueenDangerSound.Volume = 0.5
QueenDangerSound.Looped = true

_G.AuraEnabled = true
_G.DigAuraEnabled = false
_G.ShowHUD = true
_G.ESPEnabled = true
_G.SpeedBypassEnabled = false 
_G.TargetWalkSpeed = 16 
_G.StingHitboxEnabled = true
_G.StingHitboxSize = 25
_G.WalkFlingEnabled = false

local flingPart = nil
local FlingEnabled = false
_G.LockToQueen = false 
_G.BiteAnimCheck = true
_G.AcidDetectionEnabled = false
_G.ESPShowNames = true
_G.ESPNameSize = 8
_G.ESPFillTransparency = 0.5
_G.ESPOutlineTransparency = 0.1
_G.ESPQueenEnabled = true
_G.ESPLarvaeEnabled = true
_G.UseCustomESPColors = false
_G.ESPConcreteClanColor = Color3.fromRGB(200, 200, 200)
_G.ESPLeafKingdomColor = Color3.fromRGB(0, 255, 0)
_G.ESPFireNationColor = Color3.fromRGB(255, 165, 0)
_G.ESPGoldenEmpireColor = Color3.fromRGB(255, 255, 0)
_G.ESPLarvaeColor = Color3.fromRGB(255, 255, 255)

local TWEEN_SPEED = 30
local FLY_HEIGHT = 35
local SelectedPlayerName = nil

local CurrentSelectedColor = "White"
local CurrentSelectedMaterial = "Plastic"
local RainbowEnabled = false

_G.AcidAimEnabled = false
_G.AcidTeamCheck = true
_G.AcidWallCheck = false
_G.AcidPredIntensity = 5
_G.AcidHPThreshold = 100
_G.AcidAimOffsetX = 0
_G.AcidAimOffsetY = -100
local ACID_ANIM_ID = "rbxassetid://11157254990"

_G.StingAuraEnabled = false
_G.StingRange = 13
_G.StingTeamCheck = true
_G.StingWallCheck = true
_G.IsStingSpamming = false
_G.StingSpamEndTime = 0
_G.LastStingAuraTime = 0
_G.StingHPThreshold = 100

_G.AutoFarm = false
_G.HomePos = nil
_G.CurrentSize = "Minor"
_G.GatherCount = 0

_G.FarmMode = "Instant Teleport"
_G.TweenSpeed = 30
_G.TweenHeight = 10
_G.TweenLarvaePerCycle = 3
_G.TweenWaitTime = 15
_G.InstantDelay = 25
_G.InstantLootSpeed = 50
_G.InstantLarvaeLimit = 51

local SPAM_DURATION = 0.25 

_G.BiteRange = 20
_G.BiteInterval = 0 
local lastBiteTime = 0
_G.BiteWallCheck = true

_G.QueenProtectEnabled = false
_G.PatrolRadius = 50
_G.GuardDetectionRange = 100
_G.CurrentQueen = nil

_G.JumpPowerEnabled = false
_G.JumpPowerValue = 50

_G.TotalDamage = 0
_G.TotalKills = 0
_G.TotalDeaths = 0
_G.MonitorEnabled = false
_G.HideMonitorUI = false
_G.MonitorPosition = "Default"
_G.MonitorBaseColor = Color3.fromRGB(0, 0, 0)
local allyHealthCache = {}
local enemyHealthCache = {}
local lastQueenHealth = 100
local allyAlertTimer = 0
_G.QueenAttackTimer = 0
_G.DeathTimer = 0
_G.DeathMsg = ""
local deathMsgColor = "#FFFFFF"
local UIEventFlashColor = Color3.fromRGB(0,0,0)
local UIEventFlashTime = 0
local cachedQueens = {}
local myTeamQueenName = "Unknown"
local myTeamColor = Color3.new(1,1,1)
local MonitorFrame, MonitorLabel, MonitorStatsLabel, MonitorBillboard, MonitorHeadFrame, MonitorHeadStatsLabel
local HPBarBG, HPBarFill, HPBarWhiteFill, HPTextLabel
local TargetBarBG, TargetBarFill, TargetBarWhiteFill, TargetTextLabel, TargetNameLabel
local manualRespawnTimer = 0
local isDeadNow = false
local enemyPreviousHealth = {}
local damageFlashTimer = 0
local lastDamageDealt = 0
local queenDeadNotified = {}
local MyDamageTargets = {}
_G.Fullbright = false
_G.NoFog = false

_G.SoundEffectsEnabled = true
_G.CustomSoundEffects = false
local soundEnemyPreviousHealth = {}
_G.hasPlayedLowHPSound = false

task.spawn(function()
    while task.wait(0.1) do
        if not _G.SoundEffectsEnabled then continue end
        pcall(function()
            local myChar = LP.Character
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            if myHum then
                local pct = myHum.Health / myHum.MaxHealth
                if pct <= 0.25 and myHum.Health > 0 then
                    if not _G.hasPlayedLowHPSound then
                        _G.hasPlayedLowHPSound = true
                        LowHPSound:Play()
                    end
                elseif pct > 0.25 then
                    _G.hasPlayedLowHPSound = false
                end
            end

            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Team ~= LP.Team and p.Character then
                    local pHum = p.Character:FindFirstChildOfClass("Humanoid")
                    if pHum then
                        local prevH = soundEnemyPreviousHealth[p.UserId] or pHum.Health
                        if pHum.Health < prevH then
                            local dmg = prevH - pHum.Health
                            if MyDamageTargets and MyDamageTargets[pHum] and tick() - MyDamageTargets[pHum] <= 5 then
                                if dmg > 40 then HighDmgSound:Play() end
                            end
                        end
                        if pHum.Health <= 0 and prevH > 0 then
                            if MyDamageTargets and MyDamageTargets[pHum] and tick() - MyDamageTargets[pHum] <= 5 then
                                KillSound:Play()
                            end
                        end
                        soundEnemyPreviousHealth[p.UserId] = pHum.Health
                    end
                end
            end
            
            for _, q in pairs(cachedQueens) do
                if q.TeamName ~= myTeamQueenName and q.Model then
                    local qHum = q.Model:FindFirstChildOfClass("Humanoid")
                    if qHum then
                        local qID = q.TeamName .. "QueenSound"
                        local prevH = soundEnemyPreviousHealth[qID] or qHum.Health
                        if qHum.Health < prevH then
                            local dmg = prevH - qHum.Health
                            if MyDamageTargets and MyDamageTargets[qHum] and tick() - MyDamageTargets[qHum] <= 5 then
                                if dmg > 40 then HighDmgSound:Play() end
                            end
                        end
                        if qHum.Health <= 0 and prevH > 0 then
                            if MyDamageTargets and MyDamageTargets[qHum] and tick() - MyDamageTargets[qHum] <= 5 then
                                KillSound:Play()
                            end
                        end
                        soundEnemyPreviousHealth[qID] = qHum.Health
                    end
                end
            end
        end)
    end
end)

_G.QueenDangerEndTime = 0

task.spawn(function()
    while task.wait(0.1) do
        if _G.SoundEffectsEnabled and tick() < _G.QueenDangerEndTime then
            if not QueenDangerSound.IsPlaying then
                QueenDangerSound:Play()
            end
        else
            if QueenDangerSound.IsPlaying then
                QueenDangerSound:Stop()
            end
        end
    end
end)

task.spawn(function()
    local independentLastQueenHealth = 100
    while task.wait(0.2) do
        for _, q in pairs(cachedQueens) do
            if q.TeamName == myTeamQueenName then
                local qHum = q.Model:FindFirstChildOfClass("Humanoid")
                if qHum then
                    if qHum.Health < independentLastQueenHealth then
                        _G.QueenAttackTimer = 2
                        _G.QueenDangerEndTime = tick() + 5
                    end
                    independentLastQueenHealth = qHum.Health
                end
            end
        end
    end
end)

local Config = {
    rangeQueen = 25,
    rangePlayer = 25,
    biteAnims = {["11157251132"] = true, ["11157253523"] = true},
    stingId = "11157256255",
    stingEndWindow = 0.15, 
    digForwardDist = 5,
    digInterval = 0.01,
    sizeLimits = {
        ["Minor"] = 35,
        ["Major"] = 35, 
        ["Supermajor"] = 35
    },
    teamColors = {
        ["Leaf Kingdom"] = Color3.fromRGB(0, 255, 0),
        ["Fire Nation"] = Color3.fromRGB(255, 165, 0),
        ["Golden Empire"] = Color3.fromRGB(255, 255, 0),
        ["Concrete Clan"] = Color3.fromRGB(200, 200, 200)
    },
    detectionRadius = 150,
    enemyNearMeDist = 50 
}

local lastDigTime = 0
local TargetGui, T_Name, T_HP, DigFrame, DigTitle, DigStatus

local cachedChambersFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Chambers")
if not cachedChambersFolder then
    task.spawn(function()
        local map = workspace:WaitForChild("Map", 9999)
        if map then
            cachedChambersFolder = map:WaitForChild("Chambers", 9999)
        end
    end)
end

local aimbotCenterPos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
task.spawn(function()
    while true do
        pcall(function()
            local basePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local gameGui = LP.PlayerGui:FindFirstChild("GameGui")
            if gameGui then
                local mobileMouse = gameGui:FindFirstChild("MobileMouse")
                if mobileMouse then
                    basePos = mobileMouse.AbsolutePosition + (mobileMouse.AbsoluteSize / 2)
                end
            end
            aimbotCenterPos = basePos
        end)
        task.wait(3)
    end
end)

local function SetUIFlash(color, duration)
    UIEventFlashColor = color
    UIEventFlashTime = tick() + duration
end

local function UpdateQueenCache()
    cachedQueens = {}
    local myTeam = LP.Team
    local myTeamName = myTeam and myTeam.Name or ""
    if myTeam then
        myTeamColor = myTeam.TeamColor.Color
    end

    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Queen" and v:IsA("Model") then
            local parentName = v.Parent and v.Parent.Name or "Unknown"
            table.insert(cachedQueens, {
                Model = v,
                TeamName = parentName,
                HRP = v.PrimaryPart or v:FindFirstChild("HumanoidRootPart")
            })
            if parentName == myTeamName or parentName:find(myTeamName) then
                myTeamQueenName = parentName
            end
        end
    end
end

local function SetupJumpPower(char)
    local hum = char:WaitForChild("Humanoid")
    hum.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Jumping and _G.JumpPowerEnabled then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                RunService.RenderStepped:Wait()
                root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, _G.JumpPowerValue, root.AssemblyLinearVelocity.Z)
            end
        end
    end)
end

if LP.Character then SetupJumpPower(LP.Character) end

local DarkerParts = {
    "ThoraxBits", "Neck", "Petiole", "Stinger", "Antennae", 
    "RightMandible", "LeftMandible", 
    "LAntenna1", "LAntenna2", "LAntenna3", 
    "RAntenna1", "RAntenna2", "RAntenna3"
}

local ExcludedParts = {"Eyes", "Glisten", "HoneypotStrips", "Liquid"}

local function ApplyColorToParts(color)
    local char = LP.Character
    if not char then return end

    local isNeonColor = string.find(string.lower(CurrentSelectedColor), "neon")
    local baseColor = color
    local darkerColor = baseColor:Lerp(Color3.new(0, 0, 0), 0.35)

    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BasePart") then
            local isExcluded = false
            for _, exName in pairs(ExcludedParts) do 
                  if obj.Name == exName then isExcluded = true break end
            end

            if not isExcluded then
                  local shouldBeDark = false
                  for _, name in pairs(DarkerParts) do 
                      if obj.Name == name then shouldBeDark = true break end
                end
                if string.find(string.lower(obj.Name), "leg") then shouldBeDark = true end

                obj.Color = shouldBeDark and darkerColor or baseColor
                if isNeonColor then 
                    obj.Material = Enum.Material.Neon
                 end
            end
        end
    end
end

local function ApplyMaterialToParts(matName)
    local char = LP.Character
    if not char then return end
    
    local mat = Enum.Material[matName]

    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BasePart") then
              local isExcluded = false
                for _, exName in pairs(ExcludedParts) do
                    if obj.Name == exName then isExcluded = true break end
            end
            if not isExcluded then
                 obj.Material = mat
             end
          end
    end
end

local function ExecuteColorChange()
    RainbowEnabled = false 
    if CurrentSelectedColor == "Rainbow" then
        RainbowEnabled = true
    else
        local color3Value 
        if CurrentSelectedColor == "Fire Ant" then
            color3Value = Color3.fromRGB(255, 69, 0) 
        elseif CurrentSelectedColor == "Bronze" then
            color3Value = Color3.fromRGB(176, 141, 87) 
        else
            color3Value = BrickColor.new(CurrentSelectedColor).Color
         end
        ApplyColorToParts(color3Value)
    end 
end

LP.CharacterAdded:Connect(function(newChar)
    SetupJumpPower(newChar)
    task.wait(1)
    if _G.QueenProtectEnabled then
         _G.CurrentQueen = GetMyTeamQueen()
         WindUI:Notify({Title = "Update Queen Team", Content = "Updated After Yourself Respawn!", Duration = 3})
    end
    UpdateQueenCache()
    allyHealthCache = {}
    enemyHealthCache = {} 
    lastQueenHealth = 100
    allyAlertTimer = 0
    _G.QueenAttackTimer = 0
    _G.DeathTimer = 0
    _G.DeathMsg = ""
    manualRespawnTimer = 0
    isDeadNow = false
    enemyPreviousHealth = {}
    damageFlashTimer = 0
    lastDamageDealt = 0
    queenDeadNotified = {} 
end)

RunService.Heartbeat:Connect(function()
    if FlingEnabled and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LP.Character.HumanoidRootPart
        local oldVel = hrp.Velocity
        hrp.Velocity = Vector3.new(0, 50000000000, 0) + Vector3.new(math.random(-10000, 10000), 0, math.random(-10000, 10000))
        RunService.RenderStepped:Wait()
        hrp.Velocity = oldVel
    end
end)

local function GetMyTeamQueen()
    for _, obj in pairs(workspace:GetDescendants()) do
         if obj.Name == "Queen" and obj:IsA("Model") then
            local isSameTeam = false
            local teamName = LP.Team and LP.Team.Name or ""
            if obj.Parent and (obj.Parent.Name == teamName or obj.Parent.Name:find(teamName)) then
                isSameTeam = true
            elseif obj:FindFirstChild("TeamColor") and obj.TeamColor == LP.TeamColor then
                isSameTeam = true
            end
             if isSameTeam and (obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart")) then
                 return obj
            end
        end
    end
    return nil
end

local function GetClosestEnemyToQueen(queen)
    local closestEnemy = nil
    local shortestDistance = _G.GuardDetectionRange
    local queenPos = queen.PrimaryPart and queen.PrimaryPart.Position or queen:FindFirstChild("HumanoidRootPart").Position

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Team ~= LP.Team and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local enemyRoot = p.Character.HumanoidRootPart
            local distToQueen = (queenPos - enemyRoot.Position).Magnitude
            local health = p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health or 0
            if distToQueen < _G.GuardDetectionRange and health > 0 then
                closestEnemy = p.Character
                shortestDistance = distToQueen
            end
        end
    end
    return closestEnemy
end

task.spawn(function()
    while true do
        task.wait(0.5)
         if not _G.QueenProtectEnabled then continue end
        
        local char = LP.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not hum or hum.Health <= 0 then continue end

        if not _G.CurrentQueen or not _G.CurrentQueen.Parent then
              _G.CurrentQueen = GetMyTeamQueen()
        end

        local queen = _G.CurrentQueen
        if not queen then continue end
        local queenPos = queen.PrimaryPart and queen.PrimaryPart.Position or queen:FindFirstChild("HumanoidRootPart").Position

        local enemy = GetClosestEnemyToQueen(queen)

         if enemy and enemy:FindFirstChild("HumanoidRootPart") then
             while _G.QueenProtectEnabled and enemy and enemy:FindFirstChildOfClass("Humanoid") and enemy:FindFirstChildOfClass("Humanoid").Health > 0 do
                  local distToQueen = (queenPos - enemy.HumanoidRootPart.Position).Magnitude
                if distToQueen > _G.GuardDetectionRange then break end
                 hum:MoveTo(enemy.HumanoidRootPart.Position)
                 task.wait(0.1)
           end
        else
              local randomPos = queenPos + Vector3.new(math.random(-_G.PatrolRadius, _G.PatrolRadius), 0, math.random(-_G.PatrolRadius, _G.PatrolRadius))
            hum:MoveTo(randomPos)
             local startWait = tick()
              repeat task.wait(0.1) until (root.Position - randomPos).Magnitude < 5 or GetClosestEnemyToQueen(queen) or tick() - startWait > 5
         end
    end
end)

local function ApplyStingHitbox(character)
    if not _G.StingHitboxEnabled then return end
    if character ~= LP.Character then return end 
    task.wait(2) 
     if character and character.Parent then
        local stingHitbox = character:FindFirstChild("StingHitbox", true)
        if stingHitbox and stingHitbox:IsA("BasePart") then
               stingHitbox.Size = Vector3.new(_G.StingHitboxSize, _G.StingHitboxSize, _G.StingHitboxSize)
        end
    end
end

LP.CharacterAdded:Connect(ApplyStingHitbox)

local function getPlayersByTeam(isTeammate)
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
         if p ~= LP then
              local sameTeam = (p.Team == LP.Team)
            if (isTeammate and sameTeam) or (not isTeammate and not sameTeam) then
                 table.insert(list, p.Name)
            end
         end
    end
    return list
end

local function executeSafeTween()
      if not SelectedPlayerName or SelectedPlayerName == "" then
          WindUI:Notify({Title = "Error", Content = "Please select a player first!", Duration = 3})
        return 
    end
   
    local targetPlayer = Players:FindFirstChild(SelectedPlayerName)
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local rootPart = LP.Character:FindFirstChild("HumanoidRootPart")
        local targetPart = targetPlayer.Character.HumanoidRootPart
      
         if rootPart then
             local startPos = rootPart.Position
            local upPos = startPos + Vector3.new(0, FLY_HEIGHT, 0)
            local targetUpPos = targetPart.Position + Vector3.new(0, FLY_HEIGHT, 0)
            local finalCFrame = targetPart.CFrame
   
            local function runTween(targetCFrame)
                 local dist = (rootPart.Position - targetCFrame.Position).Magnitude
                 local duration = dist / TWEEN_SPEED
                 local tween = TweenService:Create(rootPart, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
                tween:Play()
                tween.Completed:Wait()
             end

             WindUI:Notify({Title = "Teleporting", Content = "Flying to " .. SelectedPlayerName .. " at height " .. FLY_HEIGHT, Duration = 2})
           
            runTween(CFrame.new(upPos))       
            runTween(CFrame.new(targetUpPos)) 
            runTween(finalCFrame)  
        end
    end
end

local function startContinuousTP()
    if not SelectedPlayerName or SelectedPlayerName == "" then
        WindUI:Notify({Title = "Error", Content = " select an enemy first!", Duration = 3})
        return 
    end

    _G.ContinuousTPActive = true
    WindUI:Notify({Title = "Instant TP Started", Content = "Targeting: " .. SelectedPlayerName, Duration = 2})

    task.spawn(function()
         while _G.ContinuousTPActive do
             local targetPlayer = Players:FindFirstChild(SelectedPlayerName)
             local myChar = LP.Character
             local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")

            if targetPlayer and targetPlayer.Character and myRoot then
                local enemyHum = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
                local enemyRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

                if not enemyHum or enemyHum.Health <= 0 or not enemyRoot then
                      _G.ContinuousTPActive = false
                      WindUI:Notify({Title = "Target Eliminated", Content = "Stopping TP because enemy died.", Duration = 3})
                    break
                 end

                 myRoot.CFrame = enemyRoot.CFrame
              else
                  _G.ContinuousTPActive = false
                  break
            end
            task.wait() 
         end
    end)
end

local function getQueenList()
    local queens = {}
    for _, obj in pairs(workspace:GetDescendants()) do
         if obj.Name == "Queen" and obj:IsA("Model") then
             local teamName = "Unknown"
             if obj.Parent and obj.Parent:IsA("Folder") or obj.Parent:IsA("Model") then
                 teamName = obj.Parent.Name
              end
             local label = "[" .. teamName .. "] Queen"
              table.insert(queens, {Label = label, Model = obj})
         end
    end
    return queens
end

local SelectedQueenModel = nil

local function executeQueenTween()
    if not SelectedQueenModel or not SelectedQueenModel.Parent then
        WindUI:Notify({Title = "Error", Content = "Please select a Queen first!", Duration = 3})
        return 
    end
    
     local targetPart = SelectedQueenModel.PrimaryPart or SelectedQueenModel:FindFirstChild("HumanoidRootPart")
     local rootPart = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
 
    if targetPart and rootPart then
         local function runTween(targetCFrame)
             local dist = (rootPart.Position - targetCFrame.Position).Magnitude
             local duration = dist / TWEEN_SPEED
             local tween = TweenService:Create(rootPart, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
             tween:Play()
             tween.Completed:Wait()
        end

         WindUI:Notify({Title = "Teleporting", Content = "Flying to Queen...", Duration = 2})
        runTween(CFrame.new(rootPart.Position + Vector3.new(0, FLY_HEIGHT, 0)))
        runTween(CFrame.new(targetPart.Position + Vector3.new(0, FLY_HEIGHT, 0)))
         local landingPos = targetPart.CFrame * CFrame.new(0, 5, 5)
         runTween(landingPos)

         task.spawn(function()
             while _G.LockToQueen and SelectedQueenModel and SelectedQueenModel.Parent do
                 local currentRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                 if currentRoot and targetPart then
                     local dist = (currentRoot.Position - targetPart.Position).Magnitude
                    if dist <= 40 then
                        currentRoot.CFrame = targetPart.CFrame * CFrame.new(0, 18, 0)
                      end
                 end
                 task.wait()
                  if not _G.LockToQueen then break end
             end
        end)
    else
        WindUI:Notify({Title = "Error", Content = "Could not find Queen's position!", Duration = 3})
    end
end

local SharedRaycastParams = RaycastParams.new()
SharedRaycastParams.FilterType = Enum.RaycastFilterType.Exclude

local function isBehindWall(targetPart, teamCheckSync)
    if not targetPart then return false end
    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return false end

    local origin = root.Position
    local destination = targetPart.Position
    local direction = destination - origin
    local maxDist = direction.Magnitude
    local currentOrigin = origin
    
    local ignoreList = {}
    for _, p in ipairs(Players:GetPlayers()) do
         if p.Character then table.insert(ignoreList, p.Character) end
    end
    
    if char then table.insert(ignoreList, char) end
    if targetPart.Parent:IsA("Model") and not table.find(ignoreList, targetPart.Parent) then
        table.insert(ignoreList, targetPart.Parent)
    end

    while maxDist > 0.1 do
        direction = destination - currentOrigin
        SharedRaycastParams.FilterDescendantsInstances = ignoreList
         local raycastResult = workspace:Raycast(currentOrigin, direction, SharedRaycastParams)
      
        if raycastResult then
            local hitPart = raycastResult.Instance
              if not hitPart.CanCollide or hitPart.Transparency >= 0.5 or hitPart:FindFirstAncestorOfClass("Accessory") then
                 table.insert(ignoreList, hitPart)
                currentOrigin = raycastResult.Position + direction.Unit * 0.1
              maxDist = (destination - currentOrigin).Magnitude
            else
              return true
              end
        else
             return false
        end
    end
    return false
end

local function GetAcidAimbotTarget()
    local bestTarget = nil
    local shortestDist = 120 

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
              if _G.AcidTeamCheck and p.Team == LP.Team then continue end
              local hrp = p.Character.HumanoidRootPart
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
              
              if hum and hum.Health > 0 and (hum.Health / hum.MaxHealth) * 100 <= _G.AcidHPThreshold then
                 if _G.AcidWallCheck and isBehindWall(hrp, _G.AcidTeamCheck) then continue end 
                 local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                      local dist = (Vector2.new(screenPos.X, screenPos.Y) - aimbotCenterPos).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        bestTarget = p.Character
                   end
                 end
             end
        end
    end
    return bestTarget
end

RunService.RenderStepped:Connect(function()
    if _G.AcidAimEnabled then
         local isShooting = false
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
         if hum then
             for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                   if track.Animation.AnimationId == ACID_ANIM_ID then
                     isShooting = true
                     break
                 end
                end
         end

           if isShooting then
             local targetChar = GetAcidAimbotTarget()
            if targetChar then
                 local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                 local myHrp = LP.Character:FindFirstChild("HumanoidRootPart")
                 if targetHrp and myHrp then
                      local dist = (myHrp.Position - targetHrp.Position).Magnitude
                     local timeToReach = dist / 50
                     local predIntensityScale = _G.AcidPredIntensity / 5 
                     local flatVelocity = Vector3.new(targetHrp.Velocity.X, 0, targetHrp.Velocity.Z)
                      local predictedPos = targetHrp.Position + (flatVelocity * timeToReach * predIntensityScale)
                  local currentCF = Camera.CFrame
                 local aimCF = CFrame.lookAt(currentCF.Position, predictedPos)

                     if _G.AcidAimOffsetX ~= 0 or _G.AcidAimOffsetY ~= 0 then
                         local fovRadians = math.rad(Camera.FieldOfView)
                           local pitchOffset = (_G.AcidAimOffsetY / Camera.ViewportSize.Y) * fovRadians
                           local yawOffset = (_G.AcidAimOffsetX / Camera.ViewportSize.X) * fovRadians
                          aimCF = aimCF * CFrame.Angles(pitchOffset, -yawOffset, 0)
                   end

                     Camera.CFrame = currentCF:Lerp(aimCF, 0.15) 
                  end
              end
        end
    end
end)

local RobloxColors = {}

for i = 1, 1032 do
    local color = BrickColor.new(i)
    local colorName = color.Name
     
    local exists = false
    for _, name in ipairs(RobloxColors) do
          if name == colorName then
             exists = true
              break
        end
    end
    
    if not exists then
        table.insert(RobloxColors, colorName)
     end
end

local RobloxMaterials = {}
for _, mat in ipairs(Enum.Material:GetEnumItems()) do
    table.insert(RobloxMaterials, mat.Name)
end
table.sort(RobloxMaterials)

task.spawn(function()
    while task.wait(0.1) do
          if RainbowEnabled then
               local hue = tick() % 5 / 5 
               local color = Color3.fromHSV(hue, 1, 1)
            ApplyColorToParts(color)
         end
    end
end)

local function SetupHUDs()
    local playerGui = LP:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild("AntWarVisuals") then playerGui.AntWarVisuals:Destroy() end

    local ScreenGui = Instance.new("ScreenGui")
   
    ScreenGui.Name = "AntWarVisuals"
    ScreenGui.IgnoreGuiInset = true
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 10 
    ScreenGui.Parent = playerGui

    MonitorFrame = Instance.new("Frame", ScreenGui)
    MonitorFrame.Size = UDim2.new(0, 252, 0, 135)
    MonitorFrame.Position = UDim2.new(0, 15, 0.4, 0)
     MonitorFrame.BackgroundColor3 = _G.MonitorBaseColor
    MonitorFrame.BackgroundTransparency = 0.8
    MonitorFrame.Visible = false 
    Instance.new("UICorner", MonitorFrame)
    local stroke = Instance.new("UIStroke", MonitorFrame)
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 1
    stroke.Transparency = 0.8
    
    HPBarBG = Instance.new("Frame", ScreenGui)
    HPBarBG.Size = UDim2.new(0, 252, 0, 10)
    HPBarBG.Position = UDim2.new(0, 15, 0.4, -15)
    HPBarBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    HPBarBG.BackgroundTransparency = 0.5
    HPBarBG.Visible = false

     local hpStroke = Instance.new("UIStroke", HPBarBG)
    hpStroke.Color = Color3.fromRGB(255, 255, 255)
    hpStroke.Thickness = 1
    hpStroke.Transparency = 0.5
    
    HPBarWhiteFill = Instance.new("Frame", HPBarBG)
    
    HPBarWhiteFill.Size = UDim2.new(1, 0, 1, 0)
    HPBarWhiteFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HPBarWhiteFill.BorderSizePixel = 0
    HPBarWhiteFill.ZIndex = 1

    HPBarFill = Instance.new("Frame", HPBarBG)
    HPBarFill.Size = UDim2.new(1, 0, 1, 0)
    HPBarFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    HPBarFill.BorderSizePixel = 0
    HPBarFill.ZIndex = 2

    HPTextLabel = Instance.new("TextLabel", HPBarBG)
    HPTextLabel.Size = UDim2.new(1, 0, 1, 0)
    HPTextLabel.BackgroundTransparency = 1
    HPTextLabel.Font = Enum.Font.Arcade
    HPTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
   
    HPTextLabel.TextStrokeTransparency = 0.5
    HPTextLabel.TextSize = 10
    HPTextLabel.ZIndex = 3
    HPTextLabel.Text = "0 / 0"

    TargetBarBG = Instance.new("Frame", ScreenGui)
    TargetBarBG.Size = UDim2.new(0, 252, 0, 10)
    TargetBarBG.Position = UDim2.new(0, 15, 0.4, -40)
    TargetBarBG.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TargetBarBG.BackgroundTransparency = 0.5
    TargetBarBG.Visible = false

    local tgtStroke = Instance.new("UIStroke", TargetBarBG)
    tgtStroke.Color = Color3.fromRGB(255, 0, 0)
    tgtStroke.Thickness = 1
    tgtStroke.Transparency = 0.5

    TargetBarWhiteFill = Instance.new("Frame", TargetBarBG)
    TargetBarWhiteFill.Size = UDim2.new(1, 0, 1, 0)
    TargetBarWhiteFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TargetBarWhiteFill.BorderSizePixel = 0
    TargetBarWhiteFill.ZIndex = 1

    TargetBarFill = Instance.new("Frame", TargetBarBG)
    TargetBarFill.Size = UDim2.new(1, 0, 1, 0)
    TargetBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    TargetBarFill.BorderSizePixel = 0
    TargetBarFill.ZIndex = 2

    TargetTextLabel = Instance.new("TextLabel", TargetBarBG)
    TargetTextLabel.Size = UDim2.new(1, 0, 1, 0)
    TargetTextLabel.BackgroundTransparency = 1
    TargetTextLabel.Font = Enum.Font.Arcade
    
    TargetTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TargetTextLabel.TextStrokeTransparency = 0.5
    TargetTextLabel.TextSize = 10
    TargetTextLabel.ZIndex = 3
    TargetTextLabel.Text = "0 / 0"

    TargetNameLabel = Instance.new("TextLabel", TargetBarBG)
    TargetNameLabel.Size = UDim2.new(1, 0, 0, 15)
    TargetNameLabel.Position = UDim2.new(0, 0, 0, -15)
    TargetNameLabel.BackgroundTransparency = 1
    TargetNameLabel.Font = Enum.Font.Arcade
    TargetNameLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    TargetNameLabel.TextStrokeTransparency = 0.5
    TargetNameLabel.TextSize = 11
    TargetNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    TargetNameLabel.Text = "Targeting: None"

    MonitorLabel = Instance.new("TextLabel", MonitorFrame)
    MonitorLabel.Size = UDim2.new(1, -20, 1, -10)
    MonitorLabel.Position = UDim2.new(0, 10, 0, 5)
    MonitorLabel.BackgroundTransparency = 1
    MonitorLabel.TextColor3 = Color3.new(1, 1, 1)
    MonitorLabel.Font = "Arcade"
    MonitorLabel.TextSize = 11
    MonitorLabel.TextXAlignment = "Left"
    MonitorLabel.RichText = true
    MonitorLabel.TextWrapped = true
    MonitorLabel.Text = ""

    MonitorStatsLabel = Instance.new("TextLabel", MonitorFrame)
    MonitorStatsLabel.Name = "StatsLabel"
    MonitorStatsLabel.Size = UDim2.new(1, -10, 0, 50)
   
    MonitorStatsLabel.Position = UDim2.new(0, 0, 0, 5)
    MonitorStatsLabel.BackgroundTransparency = 1
    MonitorStatsLabel.TextColor3 = Color3.new(1, 1, 1)
    MonitorStatsLabel.Font = "Arcade"
    MonitorStatsLabel.TextSize = 9
    MonitorStatsLabel.TextXAlignment = "Right"
    MonitorStatsLabel.TextYAlignment = "Top"
    MonitorStatsLabel.RichText = true
    MonitorStatsLabel.TextWrapped = true
    MonitorStatsLabel.Text = ""

    MonitorBillboard = Instance.new("BillboardGui", ScreenGui)
    MonitorBillboard.Name = "MonitorHead"
    MonitorBillboard.Size = UDim2.new(0, 252, 0, 135)
    MonitorBillboard.StudsOffset = Vector3.new(0, 5, 0) 
    MonitorBillboard.AlwaysOnTop = true
 
    MonitorBillboard.Enabled = false
   
    MonitorHeadFrame = Instance.new("Frame", MonitorBillboard)
    MonitorHeadFrame.Size = UDim2.new(1, 0, 1, 0)
    MonitorHeadFrame.BackgroundTransparency = 0.9
    MonitorHeadFrame.BackgroundColor3 = _G.MonitorBaseColor
    Instance.new("UICorner", MonitorHeadFrame)
    local headStroke = Instance.new("UIStroke", MonitorHeadFrame)
    headStroke.Color = Color3.fromRGB(255, 255, 255)
    headStroke.Thickness = 1
    headStroke.Transparency = 0.9

    MonitorHeadStatsLabel = MonitorStatsLabel:Clone()
    MonitorHeadStatsLabel.Parent = MonitorHeadFrame
end

SetupHUDs()

local DamageCache = { Players = {}, Queens = {} }
local WorldEntities = { Queens = {}, Larvae = {}, Prompts = {} }

local function TrackEntity(obj)
     if obj.Name == "Queen" and obj:IsA("Model") then
          WorldEntities.Queens[obj] = obj
    elseif obj.Name == "Larvae" and (obj:IsA("Model") or obj:IsA("BasePart")) then
        WorldEntities.Larvae[obj] = obj
    elseif obj:IsA("ProximityPrompt") then
        WorldEntities.Prompts[obj] = obj
    end
end

local function UntrackEntity(obj)
    if WorldEntities.Queens[obj] then
        WorldEntities.Queens[obj] = nil
    elseif WorldEntities.Larvae[obj] then
         WorldEntities.Larvae[obj] = nil
    elseif WorldEntities.Prompts[obj] then
         WorldEntities.Prompts[obj] = nil
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do
    TrackEntity(obj)
end

workspace.DescendantAdded:Connect(TrackEntity)
workspace.DescendantRemoving:Connect(UntrackEntity)

local function SetupESPObject(model)
    if not model then return nil, nil end
    local highlight = model:FindFirstChild("ESPHighlight")
      if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.Parent = model
    end
    
    local head = model:FindFirstChild("Head") or model.PrimaryPart or model
    if model:IsA("BasePart") then head = model end

    local nameGui = model:FindFirstChild("NameESP")
     
    if not nameGui then
           nameGui = Instance.new("BillboardGui")
          nameGui.Name = "NameESP"
          nameGui.Adornee = head
          nameGui.Size = UDim2.new(0, 150, 0, 50)
        nameGui.AlwaysOnTop = true
        nameGui.ExtentsOffset = Vector3.new(0, 3, 0)
        nameGui.Parent = model

         local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "TextLabel"
          nameLabel.Size = UDim2.new(1, 0, 1, 0)
         nameLabel.BackgroundTransparency = 1
          nameLabel.TextStrokeTransparency = 0.5
          nameLabel.Font = Enum.Font.GothamBold
        nameLabel.Parent = nameGui
    end
    return highlight, nameGui:FindFirstChild("TextLabel")
end

local function GetDisplayColor(entity, isAlly, isQueen)
    local hum = entity:FindFirstChildOfClass("Humanoid")
     if not hum then return Color3.new(1, 1, 1) end 

    local currentHP = hum.Health
    local cacheTable = isQueen and DamageCache.Queens or DamageCache.Players
    local cache = cacheTable[entity] or {LastHP = currentHP, DamageTime = 0}

    if currentHP < cache.LastHP then
          cache.DamageTime = tick()
    end
    cache.LastHP = currentHP
    cacheTable[entity] = cache

    local baseColor = Color3.new(1, 1, 1)
    if isQueen then
        local teamName = entity.Parent and entity.Parent.Name or ""
         if _G.UseCustomESPColors then
              if teamName == "Concrete Clan" then baseColor = _G.ESPConcreteClanColor
            elseif teamName == "Leaf Kingdom" then baseColor = _G.ESPLeafKingdomColor
            elseif teamName == "Fire Nation" then baseColor = _G.ESPFireNationColor
            elseif teamName == "Golden Empire" then baseColor = _G.ESPGoldenEmpireColor
                else baseColor = Config.teamColors[teamName] or Color3.new(1, 1, 1) end
          else
              baseColor = Config.teamColors[teamName] or Color3.new(1, 1, 1)
           end
    else
         local player = Players:GetPlayerFromCharacter(entity)
         if player and player.Team then
            local teamName = player.Team.Name
              if _G.UseCustomESPColors then
                   if teamName == "Concrete Clan" then baseColor = _G.ESPConcreteClanColor
                     elseif teamName == "Leaf Kingdom" then baseColor = _G.ESPLeafKingdomColor
                 elseif teamName == "Fire Nation" then baseColor = _G.ESPFireNationColor
                  elseif teamName == "Golden Empire" then baseColor = _G.ESPGoldenEmpireColor
                else baseColor = Config.teamColors[teamName] or Color3.new(1, 1, 1) end
             else
                    baseColor = Config.teamColors[teamName] or Color3.new(1, 1, 1)
             end
         end
      end

    if tick() - cache.DamageTime <= 3 then
          if tick() % 0.5 < 0.25 then
              if isQueen then
             return isAlly and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 165, 0) 
             else
                 return isAlly and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0) 
              end
        end
    end
    return baseColor
end

local function CleanESP()
    for _, p in pairs(Players:GetPlayers()) do
          if p.Character then
              local h = p.Character:FindFirstChild("ESPHighlight")
             local n = p.Character:FindFirstChild("NameESP")
                if h then h.Enabled = false end
             if n and n:FindFirstChild("TextLabel") then n.TextLabel.Visible = false end
         end
       end
    for _, obj in pairs(WorldEntities.Queens) do
         if obj and obj.Parent then
               local h = obj:FindFirstChild("ESPHighlight")
                  local n = obj:FindFirstChild("NameESP")
              if h then h.Enabled = false end
             if n and n:FindFirstChild("TextLabel") then n.TextLabel.Visible = false end
         end
    end
    for _, obj in pairs(WorldEntities.Larvae) do
         if obj and obj.Parent then
                local h = obj:FindFirstChild("ESPHighlight")
             local n = obj:FindFirstChild("NameESP")
             if h then h.Enabled = false end
              if n and n:FindFirstChild("TextLabel") then n.TextLabel.Visible = false end
         end
    end
end

local function UpdateESP()
    if not _G.ESPEnabled then CleanESP() return end

    for _, p in pairs(Players:GetPlayers()) do
              if p ~= LP and p.Character then
              local hum = p.Character:FindFirstChildOfClass("Humanoid")
              local isDead = hum and hum.Health <= 0 or false

             local h, l = SetupESPObject(p.Character)
             if h and l then
                    local isAlly = (p.Team == LP.Team)
                  local targetColor = isDead and Color3.fromRGB(40, 5, 5) or GetDisplayColor(p.Character, isAlly, false)
 
                  h.FillColor = targetColor
                   h.FillTransparency = _G.ESPFillTransparency
                 h.OutlineTransparency = _G.ESPOutlineTransparency
                    h.Enabled = true

                 l.TextColor3 = targetColor
                  l.TextSize = _G.ESPNameSize
                  l.Visible = _G.ESPShowNames
       
                  local teamName = (p.Team and p.Team.Name) or "Neutral"
                    local deadTag = isDead and " [Dead]" or ""
                  local currentHP = hum and math.max(0, math.floor(hum.Health)) or 0
     
               l.Text = string.format("[HP: %d] [%s]\n%s%s", currentHP, teamName, p.Name, deadTag)
                end
        end
     end

      for _, q in pairs(WorldEntities.Queens) do
         if q and q.Parent then
             if not _G.ESPQueenEnabled then
                    local h = q:FindFirstChild("ESPHighlight")
                  local n = q:FindFirstChild("NameESP")
                  if h then h.Enabled = false end
                  if n and n:FindFirstChild("TextLabel") then n.TextLabel.Visible = false end
                continue
               end
         
                   local hum = q:FindFirstChildOfClass("Humanoid")
             if hum and hum.Health > 0 then
                  local h, l = SetupESPObject(q)
                if h and l then
                    local teamName = q.Parent.Name
                          local isAlly = false
           
                    if LP.Team and (teamName == LP.Team.Name or string.find(teamName, LP.Team.Name)) then 
                    isAlly = true 
                        elseif q:FindFirstChild("TeamColor") and q.TeamColor == LP.TeamColor then 
                         isAlly = true 
                      end
            
                      local targetColor = GetDisplayColor(q, isAlly, true)
         
                     h.FillColor = targetColor
                         h.FillTransparency = _G.ESPFillTransparency
            
       h.OutlineTransparency = _G.ESPOutlineTransparency
                       h.Enabled = true

                    l.TextColor3 = targetColor
                          l.TextSize = _G.ESPNameSize
                  l.Visible = _G.ESPShowNames
     
                       l.Text = string.format("[Queen HP: %d]\n[%s]", math.floor(hum.Health), teamName)
                 end
               end
         end
     end

    for _, lv in pairs(WorldEntities.Larvae) do
         if lv and lv.Parent then
              if not _G.ESPLarvaeEnabled then
                      local h = lv:FindFirstChild("ESPHighlight")
                 local n = lv:FindFirstChild("NameESP")
                    if h then h.Enabled = false end
                 if n and n:FindFirstChild("TextLabel") then n.TextLabel.Visible = false end
                  continue
               end
             local h, l = SetupESPObject(lv)
              if h and l then
                  
                    local lColor = _G.UseCustomESPColors and _G.ESPLarvaeColor or Color3.new(1, 1, 1)
                    h.FillColor = lColor 
            
                h.FillTransparency = _G.ESPFillTransparency
                 h.OutlineTransparency = _G.ESPOutlineTransparency
            h.Enabled = true

                  l.TextColor3 = lColor
                  l.TextSize = _G.ESPNameSize
                 l.Visible = _G.ESPShowNames
                    l.Text = "Larvae"
               end
         end
     end
end

local function UpdateMonitor()
    if not _G.MonitorEnabled or not MonitorFrame then 
          if MonitorFrame then MonitorFrame.Visible = false end 
          if MonitorBillboard then MonitorBillboard.Enabled = false end
          return 
    end

    local targetFrame
    local targetStatsFrame
    if _G.MonitorPosition == "Head" then
           MonitorFrame.Visible = false
 
           MonitorBillboard.Enabled = true
        MonitorBillboard.Adornee = LP.Character and LP.Character:FindFirstChild("Head")
          targetFrame = MonitorHeadFrame
         targetStatsFrame = MonitorHeadStatsLabel
    else
         MonitorBillboard.Enabled = false
         MonitorFrame.Visible = true
         targetFrame = MonitorFrame
          targetStatsFrame = MonitorStatsLabel
    end

     if MonitorLabel and targetFrame then
           MonitorLabel.Parent = targetFrame
    end

     if targetStatsFrame then
           targetStatsFrame.Text = string.format("<font color='#FFA500'>Total Dmg: %d</font>\n<font color='#00FF00'>Kills: %d</font>\n<font color='#FF0000'>Deaths: %d</font>", _G.TotalDamage or 0, _G.TotalKills or 0, _G.TotalDeaths or 0)
    end
     
     local myTeam = LP.Team
    local myChar = LP.Character
      local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
      local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
     
     local r, g, b = math.floor(myTeamColor.R*255), math.floor(myTeamColor.G*255), math.floor(myTeamColor.B*255)
    MonitorLabel.Text = string.format("🛡️ <font color='rgb(%d,%d,%d)'>%s Team </font>\n", r, g, b, myTeamQueenName)
    
     local display = "<b><font color='#CCCCCC'>[ MONITOR STATUS ]</font></b>\n"

    local teamCounts = {}
    for _, p in ipairs(Players:GetPlayers()) do
         if p.Team then
               teamCounts[p.Team.Name] = (teamCounts[p.Team.Name] or 0) + 1
           end
    end
    
    local larvaeCount = 0
    for _, v in pairs(WorldEntities.Larvae) do
        if v and v.Parent then larvaeCount = larvaeCount + 1 end
    end

    display = display .. "<b><font color='#AAAAAA'>[ SERVER INFO ]</font></b>\n"
    local sInfo = "🐛 Larvae: " .. larvaeCount
    for tName, count in pairs(teamCounts) do
         local c = Config.teamColors[tName] or Color3.new(1,1,1)
           local hex = string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
         sInfo = sInfo .. " | <font color='" .. hex .. "'>" .. tName .. ": " .. count .. "</font>"
    end
    display = display .. sInfo .. "\n\n"
    
    if not myChar or (myHum and myHum.Health <= 0) then
        if not isDeadNow then
             isDeadNow = true
            manualRespawnTimer = 7.0
            _G.TotalDeaths = (_G.TotalDeaths or 0) + 1
         end
        display = display .. string.format("<font color='#FF3333'>⚠️ You Died, Respawn In: %.1fs</font>\n", math.max(0, manualRespawnTimer))
        if manualRespawnTimer > 0 then manualRespawnTimer = manualRespawnTimer - 0.05 end
    else
         isDeadNow = false
    end

    local enemiesMe = 0
    local enemiesQueen = 0
    local allyDmg = false
    local siegeCounts = {} 

      for _, p in pairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local pPos = p.Character.HumanoidRootPart.Position
            local pHum = p.Character:FindFirstChildOfClass("Humanoid")
             local distToMe = myHRP and (pPos - myHRP.Position).Magnitude or 999

            if p.Team ~= myTeam then
                   if pHum then
                    local prevH = enemyPreviousHealth[p.UserId] or pHum.Health
                    if pHum.Health < prevH then
                         local dmg = math.floor(prevH - pHum.Health)
                               if MyDamageTargets[pHum] and tick() - MyDamageTargets[pHum] <= 5 then
                            lastDamageDealt = dmg
                             _G.TotalDamage = (_G.TotalDamage or 0) + dmg 
                                   damageFlashTimer = 2.0
                        end
                        end

                     if pHum.Health <= 0 and prevH > 0 then
                           if MyDamageTargets[pHum] and tick() - MyDamageTargets[pHum] <= 5 then
                             _G.TotalKills = (_G.TotalKills or 0) + 1
                  _G.DeathMsg = "You killed " .. p.DisplayName
                                    deathMsgColor = "#00FF00"
                               _G.DeathTimer = 2
                                    enemyHealthCache[p.UserId] = 0
                                     SetUIFlash(Color3.fromRGB(255, 255, 255), 0.6)
                               end
               end

                       enemyPreviousHealth[p.UserId] = pHum.Health
                   end

                   if distToMe <= Config.enemyNearMeDist then
                    enemiesMe = enemiesMe + 1
                   end

                   for _, q in pairs(cachedQueens) do
                     if q.TeamName == myTeamQueenName and q.HRP then
                         if (pPos - q.HRP.Position).Magnitude <= Config.detectionRadius then
                                    enemiesQueen = enemiesQueen + 1
                          end
                       end
                 end

                    if pHum then
                    if pHum.Health <= 0 and (enemyHealthCache[p.UserId] or 100) > 0 then
                           local msgs = {"Is Dead", "Got Bitten To Death"}
                            _G.DeathMsg = "Enemy " .. p.DisplayName .. " " .. msgs[math.random(1, #msgs)]
                          deathMsgColor = "#FF4444"
                            _G.DeathTimer = 2
             SetUIFlash(Color3.fromRGB(255, 0, 0), 0.6)
                   end
                     enemyHealthCache[p.UserId] = pHum.Health
                   end
               else
                 for _, q in pairs(cachedQueens) do
                        if q.TeamName ~= myTeamQueenName and q.HRP then
                         if (pPos - q.HRP.Position).Magnitude <= Config.detectionRadius then
                            siegeCounts[q.TeamName] = (siegeCounts[q.TeamName] or 0) + 1
                               end
                     end
                  end

                    if p ~= LP and pHum then
                       if pHum.Health <= 0 and (allyHealthCache[p.UserId] or 100) > 0 then
                           _G.DeathMsg = p.DisplayName .. " was killed!"
                            deathMsgColor = "#55AAFF"
                                      _G.DeathTimer = 2
                             SetUIFlash(Color3.fromRGB(0, 150, 255), 0.6)
             elseif (allyHealthCache[p.UserId] or 100) > pHum.Health then
                               allyDmg = true
                            end
                      allyHealthCache[p.UserId] = pHum.Health
                 end
               end
         end
     end

    for _, q in pairs(cachedQueens) do
          local hum = q.Model:FindFirstChildOfClass("Humanoid")
          if hum then
              local pct = math.floor((hum.Health/hum.MaxHealth)*100)
             
              if q.TeamName ~= myTeamQueenName then
                 local qID = q.TeamName .. "QueenDmg"
                 local prevH = enemyHealthCache[qID] or hum.MaxHealth
                if hum.Health < prevH then
                    local dmg = math.floor(prevH - hum.Health)
                     if MyDamageTargets[hum] and tick() - MyDamageTargets[hum] <= 5 then
                          lastDamageDealt = dmg
                         _G.TotalDamage = (_G.TotalDamage or 0) + dmg
                         damageFlashTimer = 2.0
                     end
                 end
                if hum.Health <= 0 and prevH > 0 then
                    if MyDamageTargets[hum] and tick() - MyDamageTargets[hum] <= 5 then
                         _G.TotalKills = (_G.TotalKills or 0) + 1
                          SetUIFlash(Color3.fromRGB(255, 255, 255), 0.6)
                    end
                end
                 enemyHealthCache[qID] = hum.Health

                  if hum.Health < (allyHealthCache[q.TeamName] or hum.MaxHealth) then
                    _G.DeathMsg = "Enemy " .. q.TeamName .. " Queen Under Attack!"
                    deathMsgColor = "#FFA500"
                     _G.DeathTimer = 2
                     SetUIFlash(Color3.fromRGB(255, 165, 0), 0.6)
                end
            end
            
             allyHealthCache[q.TeamName] = hum.Health

                 if hum.Health <= 0 and not queenDeadNotified[q.TeamName] then
                    queenDeadNotified[q.TeamName] = true
                 if q.TeamName == myTeamQueenName then
                    _G.DeathMsg = "Your Queen Is Died"
                 else
                           _G.DeathMsg = "Enemy " .. q.TeamName .. " Queen Is Died"
                    end
                deathMsgColor = "#FF0000"
                _G.DeathTimer = 2
              end

              if q.TeamName == myTeamQueenName then
                  if hum.Health < lastQueenHealth then _G.QueenAttackTimer = 2 end
                   lastQueenHealth = hum.Health
                 local col = pct > 50 and "#00FF00" or (pct > 25 and "#FFFF00" or "#FF0000")
                      display = display .. "👑 Queen HP: <font color='"..col.."'>" .. pct .. "%</font>\n"
             end
         end
    end

      if damageFlashTimer > 0 then
        display = display .. "<font color='#FFD700'>      [ DMG: " .. lastDamageDealt .. " ]</font>\n"
         damageFlashTimer = damageFlashTimer - 0.05
    end

     if _G.QueenAttackTimer > 0 then
         display = display .. "⚠️ <font color='#FF0000'>QUEEN UNDER ATTACK!</font>\n"
         _G.QueenAttackTimer = _G.QueenAttackTimer - 0.05
    end

    if enemiesQueen > 0 then
          display = display .. "❗ Enemies near Queen: <font color='#FFA500'>" .. enemiesQueen .. "</font>\n"
    end

    if enemiesMe > 0 then
         display = display .. "⚔️ <font color='#FF4500'>" .. enemiesMe .. " Enemy Nearby!</font>\n"
    end

    if allyDmg then allyAlertTimer = 2 end
    if allyAlertTimer > 0 then
         display = display .. "🛡️ <font color='#00BFFF'>Ally taking damage!</font>\n"
          allyAlertTimer = allyAlertTimer - 0.05
     end

    if _G.DeathTimer > 0 then
          display = display .. string.format("<font color='%s'>💀 %s</font>\n", deathMsgColor, _G.DeathMsg)
          _G.DeathTimer = _G.DeathTimer - 0.05
      end

    MonitorLabel.Text = MonitorLabel.Text .. display
end

task.spawn(function()
     while true do
         if _G.MonitorEnabled then
              UpdateMonitor()
        end
         task.wait(0.18) 
      end
end)

local isBlinking = false
local isTargetBlinking = false

task.spawn(function()
    _G.DelayedHP = 100
      _G.LastHP = 100
    _G.HPDelayTimer = 0

    _G.TargetDelayedHP = 100
    _G.TargetLastHP = 100
    _G.TargetHPDelayTimer = 0

    while task.wait(0.05) do
          if _G.MonitorEnabled and _G.AuraTarget and tick() - (_G.AuraTargetLastHit or 0) < 3 then
             if TargetBarBG then TargetBarBG.Visible = not _G.HideMonitorUI end
             local tHum = _G.AuraTarget.hum
             if tHum and tHum.Health > 0 then
                  if TargetNameLabel then TargetNameLabel.Text = "Targeting: " .. tostring(_G.AuraTarget.name) end
                  local tCurrentHP = tHum.Health
                 local tMaxHP = tHum.MaxHealth
                  local tPct = math.clamp(tCurrentHP / tMaxHP, 0, 1)

                 if tCurrentHP < _G.TargetLastHP then
                       _G.TargetHPDelayTimer = tick() + 2
                     if not isTargetBlinking then
                          task.spawn(function()
                              isTargetBlinking = true
                              if TargetBarFill then TargetBarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end
                               task.wait(0.1)
                              if TargetBarFill then TargetBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0) end
                              isTargetBlinking = false
                          end)
                      end
                  elseif tCurrentHP > _G.TargetLastHP then
                      _G.TargetDelayedHP = tCurrentHP
                 end
                 _G.TargetLastHP = tCurrentHP

                  if tick() > _G.TargetHPDelayTimer then
                      _G.TargetDelayedHP = _G.TargetDelayedHP + (tCurrentHP - _G.TargetDelayedHP) * 0.1
                     if math.abs(_G.TargetDelayedHP - tCurrentHP) < 0.5 then
                         _G.TargetDelayedHP = tCurrentHP
                     end
                  end

                  local tDelayedPct = math.clamp(_G.TargetDelayedHP / tMaxHP, 0, 1)

                 if TargetTextLabel then TargetTextLabel.Text = tostring(math.floor(tCurrentHP)) .. " / " .. tostring(math.floor(tMaxHP)) end
                  if TargetBarWhiteFill then TargetBarWhiteFill.Size = UDim2.new(tDelayedPct, 0, 1, 0) end
                  if not isTargetBlinking and TargetBarFill then
                      TargetBarFill.Size = UDim2.new(tPct, 0, 1, 0)
                 end
             else
                  if TargetBarBG then TargetBarBG.Visible = false end
              end
          else
               if TargetBarBG then TargetBarBG.Visible = false end
          end

          if _G.MonitorEnabled and HPBarBG then
              HPBarBG.Visible = not _G.HideMonitorUI
            local myChar = LP.Character
              local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
                if myHum then
                   local currentHP = myHum.Health
                   local maxHP = myHum.MaxHealth
                local pct = math.clamp(currentHP / maxHP, 0, 1)

                  if currentHP < _G.LastHP then
        _G.HPDelayTimer = tick() + 2
                  elseif currentHP > _G.LastHP then
                       _G.DelayedHP = currentHP
                 end
                  _G.LastHP = currentHP

                  if tick() > _G.HPDelayTimer then
                      _G.DelayedHP = _G.DelayedHP + (currentHP - _G.DelayedHP) * 0.1
                      if math.abs(_G.DelayedHP - currentHP) < 0.5 then
                            _G.DelayedHP = currentHP
                       end
                  end

                 local delayedPct = math.clamp(_G.DelayedHP / maxHP, 0, 1)

                 if HPTextLabel then
HPTextLabel.Text = tostring(math.floor(currentHP)) .. " / " .. tostring(math.floor(maxHP))
                 end

                 if HPBarWhiteFill then
                     HPBarWhiteFill.Size = UDim2.new(delayedPct, 0, 1, 0)
                 end

                  if not isBlinking and HPBarFill then
                       HPBarFill.Size = UDim2.new(pct, 0, 1, 0)
                    HPBarFill.BackgroundColor3 = Color3.fromRGB(255 * (1 - pct), 255 * pct, 0)
                end
             
                  if pct <= 0.25 and myHum.Health > 0 then
                       if not isBlinking then
                         task.spawn(function()
                                 isBlinking = true
                                   for i = 1, 5 do
                                    if HPBarFill then HPBarFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0) end
                                      task.wait(0.4)
                                     if HPBarFill then HPBarFill.BackgroundColor3 = Color3.fromRGB(50, 0, 0) end
                                    task.wait(0.4)
                               end
                                isBlinking = false
                           end)
                       end
                    end
               else
                if HPBarFill then HPBarFill.Size = UDim2.new(0, 0, 1, 0) end
                  if HPBarWhiteFill then HPBarWhiteFill.Size = UDim2.new(0, 0, 1, 0) end
                   if HPTextLabel then HPTextLabel.Text = "0 / 0" end
             end
          elseif HPBarBG then
            HPBarBG.Visible = false
        end
    end
end)

task.spawn(function()
    local RunService = game:GetService("RunService")
    RunService.RenderStepped:Connect(function()
        if not _G.MonitorEnabled then return end
   
        local activeFrame = _G.MonitorPosition == "Head" and MonitorHeadFrame or MonitorFrame
            if not activeFrame then return end
         
        local targetColor = _G.MonitorBaseColor
        local targetTransparency = _G.HideMonitorUI and 1 or 0.8
        
local t = tick()
       
         local myChar = LP.Character
        local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
         local isLowHP = myHum and myHum.Health > 0 and (myHum.Health / myHum.MaxHealth) <= 0.25
         
        local enemiesMe = false
         if myChar and myChar:FindFirstChild("HumanoidRootPart") then
              local myPos = myChar.HumanoidRootPart.Position
             for _, p in ipairs(Players:GetPlayers()) do
                   if p ~= LP and p.Team ~= LP.Team and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                      if (p.Character.HumanoidRootPart.Position - myPos).Magnitude <= Config.enemyNearMeDist then
                             enemiesMe = true
                              break
                       end
                  end
               end
         end
        
        if enemiesMe then
               local alpha = (math.sin(t * 3) + 1) / 2
             targetColor = Color3.fromRGB(255, 140, 0)
             if not _G.HideMonitorUI then targetTransparency = 0.8 - (alpha * 0.2) end
         end
         
         if isLowHP then
                if t % 1 < 0.2 then
                     targetColor = Color3.fromRGB(255, 0, 0)
                  if not _G.HideMonitorUI then targetTransparency = 0.8 end
             end
         end
   
          if allyAlertTimer > 0 then
              local alpha = (math.sin(t * 10) + 1) / 2
               targetColor = Color3.fromRGB(0, 100, 255)
             if not _G.HideMonitorUI then targetTransparency = 0.8 - (alpha * 0.3) end
         end
        
        if _G.QueenAttackTimer > 0 then
              local alpha = (math.sin(t * 15) + 1) / 2
                 targetColor = Color3.fromRGB(255, 0, 0)
                if not _G.HideMonitorUI then targetTransparency = 0.8 - (alpha * 0.3) end
         end
       
          if UIEventFlashTime > t then
              targetColor = UIEventFlashColor
              if not _G.HideMonitorUI then targetTransparency = 0.8 end
           end
         
         activeFrame.BackgroundColor3 = activeFrame.BackgroundColor3:Lerp(targetColor, 0.2)
          activeFrame.BackgroundTransparency = targetTransparency
    end)
end)

local function updateCurrentSize()
    local char = LP.Character
     if char then for s, _ in pairs(Config.sizeLimits) do if string.find(char.Name, s) then _G.CurrentSize = s return end end end
end

local function teleportAndSpamGather(targetLarvae, targetCFrame, duration)
    local character = LP.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
          local startTime = tick()
           while tick() - startTime < duration do
              if not _G.AutoFarm then break end 
             character.HumanoidRootPart.CFrame = targetCFrame
              LarvaeEvent:FireServer("Gather", targetLarvae)
             RunService.RenderStepped:Wait()
         end
    end
end

local function isPlayerNearby(larvae)
    local larvaePos = larvae:IsA("Model") and larvae:GetModelCFrame().Position or larvae.Position
     for _, player in pairs(Players:GetPlayers()) do
         if player ~= LP and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then 
             local dist = (player.Character.HumanoidRootPart.Position - larvaePos).Magnitude
              if dist <= 10 then return true end
        end
    end
    return false
end

local function stableTweenToTarget(targetCFrame)
    local character = LP.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dist = (hrp.Position - targetCFrame.Position).Magnitude
        local duration = dist / _G.TweenSpeed
        local wasAnchored = hrp.Anchored
        hrp.Anchored = true
        local tween = TweenService:Create(hrp, TweenInfo.new(duration, Enum.EasingStyle.Linear), {CFrame = targetCFrame})
        tween:Play()
        tween.Completed:Wait()
        hrp.Anchored = wasAnchored
    end
end

local function runFarmCycle()
     if not _G.HomePos then
          WindUI:Notify({Title = "Error", Content = "Please Save Home Position first!", Duration = 5})
         _G.AutoFarm = false
    return 
     end
    updateCurrentSize()
 
    local allLarvae = {}
     for _, v in pairs(WorldEntities.Larvae) do
            if v.Parent and not v:IsDescendantOf(LP.Character) then table.insert(allLarvae, v) end
    end
    
    if #allLarvae == 0 then
          local character = LP.Character
              if character and character:FindFirstChild("HumanoidRootPart") then 
                  if _G.FarmMode == "Tween" then
                      local hrp = character.HumanoidRootPart
                      local startPos = hrp.Position
                      local targetPos = _G.HomePos.Position
                      local safeY = math.max(startPos.Y, targetPos.Y) + _G.TweenHeight
                      
                      local upCFrame = CFrame.new(startPos.X, safeY, startPos.Z) * hrp.CFrame.Rotation
                      stableTweenToTarget(upCFrame)
                      task.wait(0.1)
                      
                      local overCFrame = CFrame.new(targetPos.X, safeY, targetPos.Z) * _G.HomePos.Rotation
                      stableTweenToTarget(overCFrame)
                      
                      stableTweenToTarget(_G.HomePos)
                      task.wait(_G.TweenWaitTime)
                  else
                       character.HumanoidRootPart.CFrame = _G.HomePos
                       task.wait(_G.InstantDelay)
                  end
              end
     return
  end

    local maxCount = _G.FarmMode == "Tween" and _G.TweenLarvaePerCycle or _G.InstantLarvaeLimit
    if maxCount == 51 then maxCount = 999999 end
    _G.GatherCount = 0

    for i, larvae in ipairs(allLarvae) do 
         if not _G.AutoFarm then break end
         if larvae.Parent and not isPlayerNearby(larvae) then
            local targetCFrame = larvae:IsA("Model") and larvae:GetModelCFrame() or larvae.CFrame
            
            if _G.FarmMode == "Tween" then
                 local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                  if hrp then
                     local startPos = hrp.Position
                     local targetPos = targetCFrame.Position
                     local safeY = math.max(startPos.Y, targetPos.Y) + _G.TweenHeight
                      
                     local upCFrame = CFrame.new(startPos.X, safeY, startPos.Z) * hrp.CFrame.Rotation
                     stableTweenToTarget(upCFrame)
                     task.wait(0.1)
                     
                      local overCFrame = CFrame.new(targetPos.X, safeY, targetPos.Z) * targetCFrame.Rotation
                     stableTweenToTarget(overCFrame)
                     
                     stableTweenToTarget(targetCFrame)
                 end
                teleportAndSpamGather(larvae, targetCFrame, 0.25)
            else
                teleportAndSpamGather(larvae, targetCFrame, _G.InstantLootSpeed / 1000)
            end

                 _G.GatherCount = _G.GatherCount + 1
            if _G.GatherCount >= maxCount then
                     local character = LP.Character 
                   if character and character:FindFirstChild("HumanoidRootPart") then 
                        if _G.FarmMode == "Tween" then
                            local hrp = character.HumanoidRootPart
                           local startPos = hrp.Position
                           local targetPos = _G.HomePos.Position
                           local safeY = math.max(startPos.Y, targetPos.Y) + _G.TweenHeight
                            
                           local upCFrame = CFrame.new(startPos.X, safeY, startPos.Z) * hrp.CFrame.Rotation
                           stableTweenToTarget(upCFrame)
                            task.wait(0.1)
                           
                           local overCFrame = CFrame.new(targetPos.X, safeY, targetPos.Z) * _G.HomePos.Rotation
                          stableTweenToTarget(overCFrame)
                           
                           stableTweenToTarget(_G.HomePos)
                           task.wait(_G.TweenWaitTime)
                        else
                           character.HumanoidRootPart.CFrame = _G.HomePos 
                           task.wait(_G.InstantDelay)
                       end
                    end
                 _G.GatherCount = 0
                updateCurrentSize()
                break
             end 
         end
    end
end

local function GetAuraTarget(hrp)
    local bestTarget = nil
    local minDistance = _G.BiteRange
  
    for _, p in ipairs(Players:GetPlayers()) do
         if p ~= LP and p.Team ~= LP.Team and p.Character then
              local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
            local targetPart = p.Character:FindFirstChild("HumanoidRootPart")
   
             if targetHum and targetPart and targetHum.Health > 0 then
                   local dist = (hrp.Position - targetPart.Position).Magnitude
                 if dist < minDistance then
                         local blocked = _G.BiteWallCheck and isBehindWall(targetPart, false) or false
                        if not blocked then
                            minDistance = dist
                             bestTarget = {hum = targetHum, part = targetPart, name = p.Name, char = p.Character}
                       end
                     end 
             end
         end
    end

    if not bestTarget and cachedChambersFolder then
          pcall(function()
               for _, chamber in ipairs(cachedChambersFolder:GetChildren()) do
                    if LP.Team and chamber.Name ~= LP.Team.Name then 
                      local queen = chamber:FindFirstChild("Queen")
                     if queen then
                           local qHum = queen:FindFirstChildOfClass("Humanoid")
                           local qPart = queen:FindFirstChild("HumanoidRootPart")
                           if qHum and qPart and qHum.Health > 0 then
                               local qDist = (hrp.Position - qPart.Position).Magnitude 
                                if qDist < minDistance then
                                    local blocked = _G.BiteWallCheck and isBehindWall(qPart, false) or false
                                       if not blocked then
                                         bestTarget = {hum = qHum, part = qPart, name = "Queen " .. chamber.Name, char = queen}
                                     end
                   end
                          end
                 end
                  end 
              end
  end)
     end
     return bestTarget
end

local function GetStingAuraTarget(hrp)
      local bestTarget = nil
    local minDistance = _G.StingRange
    
    for _, p in ipairs(Players:GetPlayers()) do
         if p ~= LP and p.Character then
            if _G.StingTeamCheck and p.Team == LP.Team then continue end
               local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild("HumanoidRootPart")
                
             if targetHum and targetPart and targetHum.Health > 0 and (targetHum.Health / targetHum.MaxHealth) * 100 <= _G.StingHPThreshold then
                  local dist = (hrp.Position - targetPart.Position).Magnitude
                   if dist < minDistance then
                       local blocked = _G.StingWallCheck and isBehindWall(targetPart, _G.StingTeamCheck) or false
                       if not blocked then
                          minDistance = dist
             bestTarget = {hum = targetHum, part = targetPart, name = p.Name, char = p.Character}
                            end
                  end 
             end
         end
  end

    if not bestTarget and cachedChambersFolder then
         pcall(function()
               for _, chamber in ipairs(cachedChambersFolder:GetChildren()) do
                     if LP.Team and chamber.Name ~= LP.Team.Name then 
                    local queen = chamber:FindFirstChild("Queen")
                     if queen then
                            local qHum = queen:FindFirstChildOfClass("Humanoid")
                              local qPart = queen:FindFirstChild("HumanoidRootPart")
                   if qHum and qPart and qHum.Health > 0 and (qHum.Health / qHum.MaxHealth) * 100 <= _G.StingHPThreshold then
                                 local qDist = (hrp.Position - qPart.Position).Magnitude 
                                      if qDist < minDistance then
                     local blocked = _G.StingWallCheck and isBehindWall(qPart, false) or false
                                        if not blocked then
            bestTarget = {hum = qHum, part = qPart, name = "Queen " .. chamber.Name, char = queen}
                                     end
                       end
                       end
                     end
                   end 
               end
           end)
    end
    return bestTarget
end

task.spawn(function()
 while task.wait(0.05) do
           pcall(function()
              UpdateESP()
         end)
     end
end)

RunService.Heartbeat:Connect(function()
      local char = LP.Character
    if not char then return end
    
     local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
     if not hum or not hrp then return end

     if _G.SpeedBypassEnabled and hum.WalkSpeed ~= _G.TargetWalkSpeed then 
          hum.WalkSpeed = _G.TargetWalkSpeed 
     end

    local isBitingAnim = false
    local blockBiteForSting = false
    
    local playingAnims = hum.Animator and hum.Animator:GetPlayingAnimationTracks() or hum:GetPlayingAnimationTracks()
 
    for _, track in ipairs(playingAnims) do
          local id = track.Animation.AnimationId:match("%d+")
         if Config.biteAnims[id] then isBitingAnim = true end
    end 
    
     for _, obj in ipairs(char:GetDescendants()) do
         if obj:IsA("Sound") and obj.SoundId:match("9119749145") and obj.IsPlaying then
            blockBiteForSting = true
            break
        end
    end

     local currentTime = tick()
     
    if _G.StingAuraEnabled then
          local gaster = char:FindFirstChild("Gaster", true)
          if gaster and gaster:FindFirstChild("Stinger", true) then
              if not _G.IsStingSpamming and (currentTime - _G.LastStingAuraTime >= 3.6) then
                  local stingTarget = GetStingAuraTarget(hrp)
                   if stingTarget then
                       _G.IsStingSpamming = true
                  _G.StingSpamEndTime = currentTime + 0.25
                      local anim = Instance.new("Animation")
                         anim.AnimationId = "rbxassetid://11157256255"
                          local track = hum:LoadAnimation(anim)
                        track:Play()
                   end
               end

                if _G.IsStingSpamming then
                     if currentTime < _G.StingSpamEndTime then
                   local stingTarget = GetStingAuraTarget(hrp)
                      if stingTarget then
                           pcall(function()
                                 MyDamageTargets[stingTarget.hum] = tick()
                               StingEvent:FireServer("Sting", stingTarget.hum, stingTarget.part)
                           end)
                           end
           else
                        _G.IsStingSpamming = false
                      _G.LastStingAuraTime = currentTime
               end
               end
    end
     end

    if _G.IsStingSpamming then blockBiteForSting = true end

    if _G.AuraEnabled and (isBitingAnim or not _G.BiteAnimCheck) and not blockBiteForSting then
         if tick() - lastBiteTime >= _G.BiteInterval then
              local target = GetAuraTarget(hrp)
                 if target then
                   _G.AuraTarget = target
                    _G.AuraTargetLastHit = tick()
                   MyDamageTargets[target.hum] = tick()
                 BiteEvent:FireServer("Bite", target.hum, target.part)
                  lastBiteTime = tick()
          end 
 end
    end

     if _G.DigAuraEnabled then
          if _G.ShowHUD and DigFrame then DigFrame.Visible = true end
         if currentTime - lastDigTime >= Config.digInterval then
               local targetPos = hrp.Position + (hrp.CFrame.LookVector * Config.digForwardDist)
                  pcall(function() DigEvent:FireServer(Vector3.new(targetPos.X, targetPos.Y - 1, targetPos.Z)) end)
        lastDigTime = currentTime 
            end
     elseif DigFrame then DigFrame.Visible = false 
end
end)


-- ============================================================
-- UI TABS (WindUI)
-- ============================================================

-- INFO
local gameName = "Unknown"
pcall(function()
    local info = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    if info then gameName = info.Name end
end)

InfoTab:Section({
    Title = "Info",
    Desc = "Owner: Lavatrapgaming1\nRoblox: Anjaboss11\nTikTok: lavatrapgaming1\nDiscord: Lavatrapgaming",
    Box = true,
    BoxBorder = true,
})

InfoTab:Section({
    Title = "Current Game",
    Desc = "Game: " .. gameName .. "\nPlaceId: " .. tostring(game.PlaceId),
    Box = true,
    BoxBorder = true,
})

InfoTab:Section({
    Title = "Discord Group",
    Desc = "If u want to support Join our discord",
    Box = true,
    BoxBorder = true,
})

InfoTab:Button({
    Title = "Copy Discord Link",
    Icon = "copy",
    Callback = function()
        setclipboard("https://discord.gg/vAHRXGdkG")
        WindUI:Notify({
            Title = "Copied!",
            Content = "Discord link has been copied to clipboard",
            Duration = 3
        })
    end
})

InfoTab:Section({
    Title = "Credits",
    Desc = "Original Script: Edzefd (MeHub)\nConverted to WindUI for elyxionHub",
    Box = true,
    BoxBorder = true,
})

-- MAIN (Combat)
MainTab:Section({ Title = "Bite" })

MainTab:Toggle({
    Title = "Bite Aura",
    Value = true,
    Callback = function(v) _G.AuraEnabled = v end
})

MainTab:Slider({
    Title = "Bite Range",
    Value = { Min = 1, Max = 20, Default = 20 },
    Step = 1,
    Callback = function(v) _G.BiteRange = v end
})

MainTab:Input({
    Title = "Bite Interval (Speed)",
    Value = tostring(_G.BiteInterval),
    Placeholder = "0",
    Callback = function(t) _G.BiteInterval = tonumber(t) or 0 end
})

MainTab:Toggle({
    Title = "Bite Wall Check",
    Value = true,
    Callback = function(v) _G.BiteWallCheck = v end
})

MainTab:Toggle({
    Title = "Bite Animation Check",
    Value = true,
    Callback = function(v) _G.BiteAnimCheck = v end
})

MainTab:Section({ Title = "Acid" })

MainTab:Toggle({
    Title = "Acid Camera Aimbot",
    Value = false,
    Callback = function(v) _G.AcidAimEnabled = v end
})

MainTab:Toggle({
    Title = "Acid Team Check",
    Value = true,
    Callback = function(v) _G.AcidTeamCheck = v end
})

MainTab:Toggle({
    Title = "Acid Wall Check",
    Value = false,
    Callback = function(v) _G.AcidWallCheck = v end
})

MainTab:Slider({
    Title = "Prediction Intensity",
    Value = { Min = 1, Max = 10, Default = 5 },
    Step = 1,
    Callback = function(v) _G.AcidPredIntensity = v end
})

MainTab:Slider({
    Title = "Acid HP % Threshold",
    Value = { Min = 1, Max = 100, Default = 100 },
    Step = 1,
    Callback = function(v) _G.AcidHPThreshold = v end
})

MainTab:Slider({
    Title = "Aim Offset X",
    Value = { Min = -500, Max = 500, Default = 0 },
    Step = 1,
    Callback = function(v) _G.AcidAimOffsetX = v end
})

MainTab:Slider({
    Title = "Aim Offset Y",
    Value = { Min = -500, Max = 500, Default = -100 },
    Step = 1,
    Callback = function(v) _G.AcidAimOffsetY = v end
})

MainTab:Section({ Title = "Sting" })

MainTab:Toggle({
    Title = "Sting Aura",
    Value = false,
    Callback = function(v) _G.StingAuraEnabled = v end
})

MainTab:Slider({
    Title = "Sting Range",
    Value = { Min = 1, Max = 30, Default = 13 },
    Step = 1,
    Callback = function(v) _G.StingRange = v end
})

MainTab:Toggle({
    Title = "Sting Team Check",
    Value = true,
    Callback = function(v) _G.StingTeamCheck = v end
})

MainTab:Toggle({
    Title = "Sting Wall Check",
    Value = true,
    Callback = function(v) _G.StingWallCheck = v end
})

MainTab:Slider({
    Title = "Sting HP Threshold",
    Value = { Min = 1, Max = 100, Default = 100 },
    Step = 1,
    Callback = function(v) _G.StingHPThreshold = v end
})

MainTab:Toggle({
    Title = "Sting Hitbox",
    Value = true,
    Callback = function(v) _G.StingHitboxEnabled = v end
})

MainTab:Slider({
    Title = "Sting Hitbox Size",
    Value = { Min = 5, Max = 50, Default = 25 },
    Step = 1,
    Callback = function(v) _G.StingHitboxSize = v end
})

MainTab:Section({ Title = "Dig" })

MainTab:Toggle({
    Title = "Dig Aura",
    Value = false,
    Callback = function(v) _G.DigAuraEnabled = v end
})

-- FARM
FarmTab:Section({ Title = "Auto Farm" })

FarmTab:Toggle({
    Title = "Enable Auto Farm",
    Value = false,
    Callback = function(v) _G.AutoFarm = v end
})

FarmTab:Dropdown({
    Title = "Farm Mode",
    Values = {"Instant Teleport", "Tween"},
    Value = "Instant Teleport",
    Callback = function(v) _G.FarmMode = v end
})

FarmTab:Slider({
    Title = "Tween Speed",
    Value = { Min = 10, Max = 100, Default = 30 },
    Step = 1,
    Callback = function(v) _G.TweenSpeed = v end
})

FarmTab:Slider({
    Title = "Tween Height",
    Value = { Min = 0, Max = 50, Default = 10 },
    Step = 1,
    Callback = function(v) _G.TweenHeight = v end
})

FarmTab:Slider({
    Title = "Larvae Per Cycle",
    Value = { Min = 1, Max = 10, Default = 3 },
    Step = 1,
    Callback = function(v) _G.TweenLarvaePerCycle = v end
})

FarmTab:Slider({
    Title = "Wait Time",
    Value = { Min = 5, Max = 60, Default = 15 },
    Step = 1,
    Callback = function(v) _G.TweenWaitTime = v end
})

FarmTab:Slider({
    Title = "Instant Delay",
    Value = { Min = 5, Max = 60, Default = 25 },
    Step = 1,
    Callback = function(v) _G.InstantDelay = v end
})

FarmTab:Button({
    Title = "Save Home / Loot Dropoff Position",
    Callback = function()
        local char = LP.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            _G.HomePos = char.HumanoidRootPart.CFrame
            WindUI:Notify({ Title = "Saved", Content = "Home position saved!", Duration = 3 })
        else
            WindUI:Notify({ Title = "Error", Content = "No character found", Duration = 3 })
        end
    end
})

-- MOVEMENT
MovementTab:Section({ Title = "Speed" })

MovementTab:Toggle({
    Title = "Speed Bypass",
    Value = false,
    Callback = function(v) _G.SpeedBypassEnabled = v end
})

MovementTab:Slider({
    Title = "Walk Speed",
    Value = { Min = 16, Max = 40, Default = 16 },
    Step = 1,
    Callback = function(v) _G.TargetWalkSpeed = v end
})

MovementTab:Section({ Title = "Jump" })

MovementTab:Toggle({
    Title = "Jump Power",
    Value = false,
    Callback = function(v) _G.JumpPowerEnabled = v end
})

MovementTab:Slider({
    Title = "Jump Power Value",
    Value = { Min = 50, Max = 200, Default = 50 },
    Step = 1,
    Callback = function(v) _G.JumpPowerValue = v end
})

MovementTab:Section({ Title = "Other" })

MovementTab:Toggle({
    Title = "Walk Fling",
    Value = false,
    Callback = function(v) _G.WalkFlingEnabled = v end
})

-- VISUALS (ESP FIXED)
VisualTab:Section({ Title = "ESP Settings" })

VisualTab:Toggle({
    Title = "Enable Enemy ESP",
    Value = true,
    Callback = function(v)
        _G.ESPEnabled = v
        if not v then
            pcall(CleanESP)
        end
    end
})

VisualTab:Toggle({
    Title = "Enable Queen ESP",
    Value = true,
    Callback = function(v) _G.ESPQueenEnabled = v end
})

VisualTab:Toggle({
    Title = "Enable Larvae ESP",
    Value = true,
    Callback = function(v) _G.ESPLarvaeEnabled = v end
})

VisualTab:Toggle({
    Title = "Show ESP Names",
    Value = true,
    Callback = function(v) _G.ESPShowNames = v end
})

VisualTab:Slider({
    Title = "ESP Name Size",
    Value = { Min = 5, Max = 20, Default = 8 },
    Step = 1,
    Callback = function(v) _G.ESPNameSize = v end
})

VisualTab:Slider({
    Title = "Fill Transparency",
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Step = 0.1,
    Callback = function(v) _G.ESPFillTransparency = v end
})

VisualTab:Slider({
    Title = "Outline Transparency",
    Value = { Min = 0, Max = 1, Default = 0.1 },
    Step = 0.1,
    Callback = function(v) _G.ESPOutlineTransparency = v end
})

VisualTab:Button({
    Title = "Refresh ESP",
    Callback = function()
        pcall(CleanESP)
        WindUI:Notify({ Title = "ESP", Content = "Refreshed", Duration = 2 })
    end
})

VisualTab:Section({ Title = "Custom ESP Colors" })

VisualTab:Toggle({
    Title = "Use Custom Colors",
    Value = false,
    Callback = function(v) _G.UseCustomESPColors = v end
})

VisualTab:Section({ Title = "HUD & Monitor" })

VisualTab:Toggle({
    Title = "Show Enemy Status HUD",
    Value = true,
    Callback = function(v) _G.ShowHUD = v end
})

VisualTab:Toggle({
    Title = "Enable Monitor",
    Value = false,
    Callback = function(v) _G.MonitorEnabled = v end
})

VisualTab:Section({ Title = "World" })

VisualTab:Toggle({
    Title = "Fullbright",
    Value = false,
    Callback = function(v)
        _G.Fullbright = v
        if v then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        else
            -- restore roughly
            Lighting.Brightness = 1
            Lighting.GlobalShadows = true
        end
    end
})

VisualTab:Toggle({
    Title = "No Fog",
    Value = false,
    Callback = function(v)
        _G.NoFog = v
        if v then
            Lighting.FogEnd = 100000
        end
    end
})

-- MISC
MiscTab:Section({ Title = "Sounds" })

MiscTab:Toggle({
    Title = "Sound Effects",
    Value = true,
    Callback = function(v) _G.SoundEffectsEnabled = v end
})

MiscTab:Section({ Title = "Queen" })

MiscTab:Toggle({
    Title = "Queen Protect / Guard",
    Value = false,
    Callback = function(v) _G.QueenProtectEnabled = v end
})

MiscTab:Slider({
    Title = "Patrol Radius",
    Value = { Min = 20, Max = 150, Default = 50 },
    Step = 5,
    Callback = function(v) _G.PatrolRadius = v end
})

-- TELEPORT
TPTab:Section({ Title = "Quick Actions" })

TPTab:Button({
    Title = "Refresh Lists / Cache",
    Callback = function()
        pcall(UpdateQueenCache)
        pcall(CleanESP)
        WindUI:Notify({ Title = "Updated", Content = "Lists & ESP refreshed", Duration = 2 })
    end
})

TPTab:Button({
    Title = "Server Hop (Random)",
    Callback = function()
        WindUI:Notify({ Title = "Server Hop", Content = "Searching...", Duration = 3 })
        pcall(function()
            local servers = {}
            local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            local data = HttpService:JSONDecode(req)
            for _, s in pairs(data.data or {}) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    table.insert(servers, s.id)
                end
            end
            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LP)
            else
                WindUI:Notify({ Title = "Failed", Content = "No servers found", Duration = 3 })
            end
        end)
    end
})

print("elyxionHub (WindUI) fully loaded - ESP & all systems active!")
