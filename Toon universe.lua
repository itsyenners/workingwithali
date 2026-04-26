local RunService = game:GetService("RunService")
local cloneref = (cloneref or clonereference or function(instance) return instance end)
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

local WindUI
do
    local ok, result = pcall(function() return require("./src/Init") end)
    if ok then
        WindUI = result
    else
        if cloneref(RunService):IsStudio() then
            WindUI = require(cloneref(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init")))
        else
            WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
        end
    end
end

-- */ Window /* --
local Window = WindUI:CreateWindow({
    Title = "Toon Universe  |  Farm Script",
    Folder = "ToonUniverseHub",
    Icon = "zap",
    NewElements = true,
    HideSearchBar = false,
    OpenButton = {
        Title = "Toon Universe",
        CornerRadius = UDim.new(1, 0),
        StrokeThickness = 3,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        Scale = 0.5,
        Color = ColorSequence.new(Color3.fromHex("#00ff50"), Color3.fromHex("#00cfff")),
    },
    Topbar = { Height = 44, ButtonsType = "Windows" },
})

Window:EditOpenButton({
    Title = "Toon Universe",
    Icon = "monitor",
    CornerRadius = UDim.new(0, 16),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("FF0F7B"), Color3.fromHex("F89B29")),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({ Title = "by Myllo & Ali", Color = Color3.fromHex("#1c1c1c"), Border = true })

-- */ Colors /* --
local Green  = Color3.fromHex("#10C550")
local Yellow = Color3.fromHex("#ECA201")
local Blue   = Color3.fromHex("#257AF7")
local Red    = Color3.fromHex("#EF4F1D")
local Purple = Color3.fromHex("#7775F2")
local Grey   = Color3.fromHex("#83889E")

-- */ Player refs /* --
local player = game.Players.LocalPlayer
local char   = player.Character or player.CharacterAdded:Wait()
local root   = char:FindFirstChild("HumanoidRootPart")
local speedValue = 16

player.CharacterAdded:Connect(function(c)
    char = c
    root = c:WaitForChild("HumanoidRootPart")
    local hum = c:WaitForChild("Humanoid")
    hum.WalkSpeed = speedValue
end)

-- */ ESP Helpers /* --
local function createHighlight(adornee, fillColor, tag)
    if adornee:FindFirstChild(tag) then return end
    local h = Instance.new("Highlight")
    h.Name = tag
    h.Adornee = adornee
    h.FillColor = fillColor
    h.OutlineColor = Color3.new(1, 1, 1)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = adornee
end

local function clearTag(tag)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == tag then obj:Destroy() end
    end
end

-- */ Tabs /* --
local TabMain  = Window:Tab({ Title = "Main",     Icon = "eye",     IconColor = Blue,   IconShape = "Square", Border = true })
local TabPlayer = Window:Tab({ Title = "Player",   Icon = "user",    IconColor = Green,  IconShape = "Square", Border = true })
local TabFarm  = Window:Tab({ Title = "Farm",     Icon = "zap",     IconColor = Yellow, IconShape = "Square", Border = true })
local TabTele  = Window:Tab({ Title = "Teleport", Icon = "map-pin", IconColor = Purple, IconShape = "Square", Border = true })
local TabCredits = Window:Tab({ Title = "Credits", Icon = "star",   IconColor = Grey,   IconShape = "Square", Border = true })

-- ============================================================
-- */ Main Tab (ESP) /* --
-- ============================================================
local espCaps, espItens, espMaq, espComp, espMons, espBig = false, false, false, false, false, false

TabMain:Toggle({
    Title = "ESP Capsules",
    Desc = "Highlights all capsules on the map",
    Value = false, Flag = "ESPCaps",
    Callback = function(val) espCaps = val if not val then clearTag("ESP_Caps") end end,
})
TabMain:Space()
TabMain:Toggle({
    Title = "ESP Items",
    Desc = "Highlights all items on the map",
    Value = false, Flag = "ESPItens",
    Callback = function(val) espItens = val if not val then clearTag("ESP_Itens") end end,
})
TabMain:Space()
TabMain:Toggle({
    Title = "ESP Machines",
    Desc = "Highlights all oil machines on the map",
    Value = false, Flag = "ESPMaq",
    Callback = function(val) espMaq = val if not val then clearTag("ESP_Maq") end end,
})
TabMain:Space()
TabMain:Toggle({
    Title = "ESP Computers",
    Desc = "Highlights all computers on the map",
    Value = false, Flag = "ESPComp",
    Callback = function(val) espComp = val if not val then clearTag("ESP_Comp") end end,
})
TabMain:Space()
TabMain:Toggle({
    Title = "ESP Monsters",
    Desc = "Highlights all monsters on the map",
    Value = false, Flag = "ESPMons",
    Callback = function(val) espMons = val if not val then clearTag("ESP_Mons") end end,
})
TabMain:Space()
TabMain:Toggle({
    Title = "ESP Main Machine",
    Desc = "Highlights the main machine on the map",
    Value = false, Flag = "ESPBig",
    Callback = function(val) espBig = val if not val then clearTag("ESP_Big") end end,
})

-- ESP Loop
local monstersSemRoot = { "TSquid", "TDiscardd", "TNimbus" }

task.spawn(function()
    while task.wait(3) do
        if espCaps then
            for _, model in ipairs(workspace.Capsules:GetChildren()) do
                createHighlight(model, Color3.fromRGB(0, 255, 80), "ESP_Caps")
            end
        end
        if espItens then
            for _, item in ipairs(workspace.Items:GetChildren()) do
                createHighlight(item, Color3.fromRGB(255, 220, 0), "ESP_Itens")
            end
        end
        if espMaq then
            for _, machine in ipairs(workspace.OilMachines:GetChildren()) do
                createHighlight(machine, Color3.fromRGB(255, 120, 0), "ESP_Maq")
            end
        end
        if espComp then
            for _, comp in ipairs(workspace.Computers:GetChildren()) do
                createHighlight(comp, Color3.fromRGB(0, 180, 255), "ESP_Comp")
            end
        end
        if espMons then
            for _, folder in ipairs(workspace.MonsterFolder:GetChildren()) do
                local noRoot = false
                for _, name in ipairs(monstersSemRoot) do
                    if folder.Name == name then noRoot = true break end
                end
                if noRoot then
                    for _, obj in ipairs(folder:GetChildren()) do
                        createHighlight(obj, Color3.fromRGB(255, 0, 0), "ESP_Mons")
                    end
                elseif folder:FindFirstChild("RootPart") then
                    createHighlight(folder, Color3.fromRGB(255, 0, 0), "ESP_Mons")
                else
                    for _, monster in ipairs(folder:GetChildren()) do
                        if monster:FindFirstChild("RootPart") then
                            createHighlight(monster, Color3.fromRGB(255, 0, 0), "ESP_Mons")
                        end
                    end
                end
            end
        end
        if espBig then
            local ok2, big = pcall(function()
                return workspace.Map.SpecialFolder.BigMachine.Computer
            end)
            if not ok2 then
                ok2, big = pcall(function()
                    return workspace.Map.SpecialFolder.BigMachine.Machine
                end)
            end
            if ok2 and big then
                createHighlight(big, Color3.fromRGB(255, 0, 255), "ESP_Big")
            end
        end
    end
end)

-- ============================================================
-- */ Player Tab /* --
-- ============================================================
TabPlayer:Slider({
    Title = "Walk Speed",
    Desc = "Adjust your walking speed",
    Flag = "Speed", Step = 1,
    Value = { Min = 16, Max = 150, Default = 16 },
    Callback = function(val)
        speedValue = val
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end,
})

TabPlayer:Space()

TabPlayer:Toggle({
    Title = "Infinite Stamina",
    Desc = "Prevents stamina from draining",
    Value = false, Flag = "infinite_stamina", Icon = "zap",
    Callback = function(state)
        if state then
            if _G.staminaConn then return end
            _G.staminaConn = RunService.Heartbeat:Connect(function()
                if not char or not char.Parent then return end
                local staminaIncrease = workspace:GetAttribute("StaminaIncrease") or 0
                local staminaInt = char:GetAttribute("StaminaInt") or 1
                local staminaBonus = char:GetAttribute("StaminaBonus") or 0
                local maxStam = 25 * staminaInt + 75 + staminaIncrease + staminaBonus
                char:SetAttribute("Stamina", maxStam)
                char:SetAttribute("NoStaminaDrain", 999)
            end)
        else
            if _G.staminaConn then
                _G.staminaConn:Disconnect()
                _G.staminaConn = nil
            end
        end
    end,
})

TabPlayer:Space()

local noclipActive = false
TabPlayer:Toggle({
    Title = "Noclip",
    Desc = "Walk through walls and objects",
    Value = false, Flag = "Noclip",
    Callback = function(val) noclipActive = val end,
})

RunService.RenderStepped:Connect(function()
    if noclipActive and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- ============================================================
-- */ Farm Tab /* --
-- ============================================================
local farmCapsulesActive = false
TabFarm:Toggle({
    Title = "Pick Up All Capsules",
    Desc = "Teleports to and collects all capsules",
    Value = false, Flag = "FarmCaps",
    Callback = function(val)
        farmCapsulesActive = val
        task.spawn(function()
            while farmCapsulesActive do
                for _, model in ipairs(workspace.Capsules:GetChildren()) do
                    if not farmCapsulesActive then break end
                    local r = model:FindFirstChild("Root")
                    local prompt = model:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if r and prompt and root then
                        root.CFrame = r.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.3)
                    end
                end
                task.wait(1)
            end
        end)
    end,
})

TabFarm:Space()

local farmItemsActive = false
TabFarm:Toggle({
    Title = "Pick Up All Items",
    Desc = "Teleports to and collects all items",
    Value = false, Flag = "FarmItens",
    Callback = function(val)
        farmItemsActive = val
        task.spawn(function()
            while farmItemsActive do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not farmItemsActive then break end
                    if item.Name == "Parts" then continue end
                    local part = item:FindFirstChild("Cube") or item:FindFirstChild("Cubee.003")
                    local prompt = item:FindFirstChild("ProximityPrompt")
                    if part and prompt and root then
                        root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.3)
                    end
                end
                task.wait(1)
            end
        end)
    end,
})

TabFarm:Space()

local farmPartsActive = false
TabFarm:Toggle({
    Title = "Pick Up All Parts",
    Desc = "Teleports to and collects all parts",
    Value = false, Flag = "FarmParts",
    Callback = function(val)
        farmPartsActive = val
        task.spawn(function()
            while farmPartsActive do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not farmPartsActive then break end
                    if item.Name ~= "Parts" then continue end
                    local part = item:FindFirstChild("Cube") or item:FindFirstChild("Cubee.003")
                    local prompt = item:FindFirstChild("ProximityPrompt")
                    if part and prompt and root then
                        root.CFrame = part.CFrame + Vector3.new(0, 3, 0)
                        task.wait(0.3)
                        fireproximityprompt(prompt)
                        task.wait(0.3)
                    end
                end
                task.wait(1)
            end
        end)
    end,
})

-- ============================================================
-- */ Teleport Tab /* --
-- ============================================================
TabTele:Button({
    Title = "Teleport to Machine",
    Desc = "Teleports to each oil machine",
    Icon = "cpu", Justify = "Center",
    Callback = function()
        for _, machine in ipairs(workspace.OilMachines:GetChildren()) do
            local prompt = machine:FindFirstChild("PromptPart")
            if prompt and root then
                root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.5)
            end
        end
    end,
})

TabTele:Space()

TabTele:Button({
    Title = "Teleport to Computer",
    Desc = "Teleports to each computer",
    Icon = "monitor", Justify = "Center",
    Callback = function()
        for _, comp in ipairs(workspace.Computers:GetChildren()) do
            local prompt = comp:FindFirstChild("PromptPart")
            if prompt and root then
                root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
                task.wait(0.5)
            end
        end
    end,
})

TabTele:Space()

TabTele:Button({
    Title = "Teleport to Main Machine",
    Desc = "Teleports to the main machine",
    Icon = "building", Justify = "Center", Color = Purple,
    Callback = function()
        local ok2, prompt = pcall(function()
            return workspace.Map.SpecialFolder.BigMachine.Computer.PromptPart
        end)
        if not ok2 then
            ok2, prompt = pcall(function()
                return workspace.Map.SpecialFolder.BigMachine.Machine.PromptPart
            end)
        end
        if ok2 and prompt and root then
            root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
        end
    end,
})

TabTele:Space()

TabTele:Button({
    Title = "Teleport to Electric Box",
    Desc = "Teleports to the electric box during blackouts",
    Icon = "zap", Justify = "Center", Color = Yellow,
    Callback = function()
        local ok2, prompt = pcall(function()
            return workspace.Map.SpecialFolder.ElectricBoxes.ElectricBox.PromptPart
        end)
        if ok2 and prompt and root then
            root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
        end
    end,
})

TabTele:Space()

-- Auto Elevator
local MapStats = workspace:WaitForChild("MapStats")
local FloorValue = MapStats:WaitForChild("IsFloorCompleted")
local Elevator = workspace:WaitForChild("Elevator")
local elevRunning = false
local elevEnabled = false
local elevConnection

local function getElevCFrame()
    if Elevator.PrimaryPart then
        return Elevator.PrimaryPart.CFrame
    else
        local part = Elevator:FindFirstChildWhichIsA("BasePart")
        return part and part.CFrame or nil
    end
end

local function elevTeleportLoop()
    if elevRunning then return end
    elevRunning = true
    while elevEnabled and FloorValue.Value do
        local cf = getElevCFrame()
        if char and char:FindFirstChild("HumanoidRootPart") and cf then
            char.HumanoidRootPart.CFrame = cf
        end
        task.wait(0.1)
    end
    elevRunning = false
end

local function elevStart()
    -- Remove barreiras
    local barrier = workspace.Elevator:FindFirstChild("Barrier")
    local safetyBarrier = workspace:FindFirstChild("SafteyBarrier")
    if barrier then barrier.CanCollide = false end
    if safetyBarrier then safetyBarrier.CanCollide = false end

    if elevConnection then elevConnection:Disconnect() end
    elevConnection = FloorValue:GetPropertyChangedSignal("Value"):Connect(function()
        if elevEnabled and FloorValue.Value then
            -- Remove barreiras novamente quando floor completa
            if barrier then barrier.CanCollide = false end
            if safetyBarrier then safetyBarrier.CanCollide = false end
            elevTeleportLoop()
        end
    end)
    if FloorValue.Value then elevTeleportLoop() end
end

local function elevStop()
    elevEnabled = false
    elevRunning = false
    if elevConnection then
        elevConnection:Disconnect()
        elevConnection = nil
    end
end

TabTele:Toggle({
    Title = "Auto Teleport to Elevator",
    Desc = "Teleports to elevator when the floor is complete",
    Icon = "power", Value = false, Flag = "auto_elevator",
    Callback = function(state)
        elevEnabled = state
        if state then elevStart() else elevStop() end
    end,
})

TabTele:Space()

-- Auto Hide
local ChaseRemote = ReplicatedStorage.Remotes.Chase
local TeleportPart = workspace.Elevator.Model:GetChildren()[20]
local teleportEnabled = false

local function loopHide()
    if not teleportEnabled then return end
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local originalCFrame = hrp.CFrame
    local startTime = tick()
    while tick() - startTime < 2 and teleportEnabled do
        if TeleportPart and TeleportPart:IsA("BasePart") then
            hrp.CFrame = TeleportPart.CFrame + Vector3.new(0, 5, 0)
        end
        task.wait(0.1)
    end
    if teleportEnabled then hrp.CFrame = originalCFrame end
end

ChaseRemote.OnClientEvent:Connect(function(monster, state)
    if state == "Started" and teleportEnabled then
        loopHide()
    end
end)

TabTele:Toggle({
    Title = "Auto Hide",
    Desc = "Automatically hides when a monster chases you",
    Icon = "shield", Value = false, Flag = "teleport_toggle",
    Callback = function(state)
        teleportEnabled = state
    end,
})

-- ============================================================
-- */ Credits Tab /* --
-- ============================================================
TabCredits:Label({ Title = "Myllo", Desc = "Creator of Toon Universe's Script (Coder)" })
TabCredits:Space()
TabCredits:Label({ Title = "Ali", Desc = "Helper of Toon Universe's Script and Creator of Dolly's Factory Script" })
TabCredits:Space()
TabCredits:Label({ Title = "WindUI", Desc = "UI Library by Footagesus — github.com/Footagesus/WindUI" })

print("Toon Universe | v1.0.0 loaded!")
