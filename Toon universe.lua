local RunService = game:GetService("RunService")

local cloneref = (cloneref or clonereference or function(instance) return instance end)
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

local WindUI
do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)
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

-- */  Window  /* --
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
        Color = ColorSequence.new(
            Color3.fromHex("#00ff50"),
            Color3.fromHex("#00cfff")
        ),
    },
    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})

Window:Tag({
    Title = "by Myllooo",
    Color = Color3.fromHex("#1c1c1c"),
    Border = true,
})

-- */  Colors  /* --
local Green  = Color3.fromHex("#10C550")
local Yellow = Color3.fromHex("#ECA201")
local Orange = Color3.fromHex("#FF7800")
local Blue   = Color3.fromHex("#257AF7")
local Red    = Color3.fromHex("#EF4F1D")
local Purple = Color3.fromHex("#7775F2")
local Grey   = Color3.fromHex("#83889E")

-- */  Player refs  /* --
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

-- */  ESP Helpers  /* --
local function createHighlight(adornee, fillColor, tag)
    if adornee:FindFirstChild(tag) then return end
    local h = Instance.new("Highlight")
    h.Name               = tag
    h.Adornee            = adornee
    h.FillColor          = fillColor
    h.OutlineColor       = Color3.new(1, 1, 1)
    h.FillTransparency   = 0.5
    h.OutlineTransparency = 0
    h.DepthMode          = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent             = adornee
end

local function clearTag(tag)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == tag then obj:Destroy() end
    end
end

-- */  Sections  /* --
local ESPSection  = Window:Section({ Title = "ESP" })
local FarmSection = Window:Section({ Title = "Farm" })
local TeleSection = Window:Section({ Title = "Teleport" })
local MiscSection = Window:Section({ Title = "Misc" })

-- ============================================================
-- */  ESP Tab  /* --
-- ============================================================
local TabESP = ESPSection:Tab({
    Title     = "ESP",
    Icon      = "eye",
    IconColor = Blue,
    IconShape = "Square",
    Border    = true,
})

local espCaps, espItens, espMaq, espComp, espMons, espBig = false, false, false, false, false, false

TabESP:Toggle({
    Title    = "ESP Capsules",
    Value    = false,
    Flag     = "ESPCaps",
    Callback = function(val)
        espCaps = val
        if not val then clearTag("ESP_Caps") end
    end,
})
TabESP:Space()

TabESP:Toggle({
    Title    = "ESP Items",
    Value    = false,
    Flag     = "ESPItens",
    Callback = function(val)
        espItens = val
        if not val then clearTag("ESP_Itens") end
    end,
})
TabESP:Space()

TabESP:Toggle({
    Title    = "ESP Machines",
    Value    = false,
    Flag     = "ESPMaq",
    Callback = function(val)
        espMaq = val
        if not val then clearTag("ESP_Maq") end
    end,
})
TabESP:Space()

TabESP:Toggle({
    Title    = "ESP Computers",
    Value    = false,
    Flag     = "ESPComp",
    Callback = function(val)
        espComp = val
        if not val then clearTag("ESP_Comp") end
    end,
})
TabESP:Space()

TabESP:Toggle({
    Title    = "ESP Monsters",
    Value    = false,
    Flag     = "ESPMons",
    Callback = function(val)
        espMons = val
        if not val then clearTag("ESP_Mons") end
    end,
})
TabESP:Space()

TabESP:Toggle({
    Title    = "ESP Big Machine",
    Value    = false,
    Flag     = "ESPBig",
    Callback = function(val)
        espBig = val
        if not val then clearTag("ESP_Big") end
    end,
})

-- ESP loop
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
            if ok2 and big then
                createHighlight(big, Color3.fromRGB(255, 0, 255), "ESP_Big")
            end
        end
    end
end)

-- ============================================================
-- */  Farm Tab  /* --
-- ============================================================
local TabFarm = FarmSection:Tab({
    Title     = "Farm",
    Icon      = "zap",
    IconColor = Yellow,
    IconShape = "Square",
    Border    = true,
})

local farmCapsulesActive = false
TabFarm:Toggle({
    Title    = "Farm Capsules",
    Value    = false,
    Flag     = "FarmCaps",
    Callback = function(val)
        farmCapsulesActive = val
        task.spawn(function()
            while farmCapsulesActive do
                for _, model in ipairs(workspace.Capsules:GetChildren()) do
                    if not farmCapsulesActive then break end
                    local r      = model:FindFirstChild("Root")
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
    Title    = "Farm Items",
    Value    = false,
    Flag     = "FarmItens",
    Callback = function(val)
        farmItemsActive = val
        task.spawn(function()
            while farmItemsActive do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not farmItemsActive then break end
                    local part   = item:FindFirstChild("Cube") or item:FindFirstChild("Cubee.003")
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

TabFarm:Button({
    Title    = "Clear All ESP",
    Color    = Red,
    Icon     = "trash",
    Justify  = "Center",
    Callback = function()
        for _, tag in ipairs({ "ESP_Caps", "ESP_Itens", "ESP_Maq", "ESP_Comp", "ESP_Mons", "ESP_Big" }) do
            clearTag(tag)
        end
        WindUI:Notify({
            Title   = "ESP",
            Content = "All ESP highlights removed!",
            Icon    = "check",
            Duration = 3,
        })
    end,
})

-- ============================================================
-- */  Teleport Tab  /* --
-- ============================================================
local TabTele = TeleSection:Tab({
    Title     = "Teleport",
    Icon      = "map-pin",
    IconColor = Green,
    IconShape = "Square",
    Border    = true,
})

TabTele:Button({
    Title    = "Teleport to All Machines",
    Icon     = "cpu",
    Justify  = "Center",
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
    Title    = "Teleport to All Computers",
    Icon     = "monitor",
    Justify  = "Center",
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
    Title    = "Teleport to Big Machine",
    Icon     = "building",
    Justify  = "Center",
    Color    = Purple,
    Callback = function()
        local ok2, prompt = pcall(function()
            return workspace.Map.SpecialFolder.BigMachine.Computer.PromptPart
        end)
        if ok2 and prompt and root then
            root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
        end
    end,
})

-- ============================================================
-- */  Misc Tab  /* --
-- ============================================================
local TabMisc = MiscSection:Tab({
    Title     = "Misc",
    Icon      = "settings",
    IconColor = Grey,
    IconShape = "Square",
    Border    = true,
})

TabMisc:Slider({
    Title    = "Walk Speed",
    Flag     = "Speed",
    Step     = 1,
    Value    = {
        Min     = 16,
        Max     = 150,
        Default = 16,
    },
    Callback = function(val)
        speedValue = val
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end,
})

TabMisc:Space()

local noclipActive = false
TabMisc:Toggle({
    Title    = "Noclip",
    Value    = false,
    Flag     = "Noclip",
    Callback = function(val)
        noclipActive = val
    end,
})

RunService.RenderStepped:Connect(function()
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipActive
            end
        end
    end
end)
local RunService = game:GetService("RunService")
local Folder = workspace:WaitForChild("MonsterFolder")

local Highlights = {}
local Enabled = false
local Connections = {}

local function createHighlight(obj)
    if Highlights[obj] then return end
    if not obj:IsA("Model") and not obj:IsA("BasePart") then return end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Adornee = obj
    highlight.Parent = obj

    Highlights[obj] = highlight
end

local function removeAll()
    for obj, h in pairs(Highlights) do
        if h then h:Destroy() end
        Highlights[obj] = nil
    end
end

local function start()
    for _, v in ipairs(Folder:GetChildren()) do
        createHighlight(v)
    end

    Connections.Added = Folder.ChildAdded:Connect(createHighlight)

    Connections.Removed = Folder.ChildRemoved:Connect(function(obj)
        if Highlights[obj] then
            Highlights[obj]:Destroy()
            Highlights[obj] = nil
        end
    end)

    Connections.Loop = RunService.RenderStepped:Connect(function()
        for obj in pairs(Highlights) do
            if not obj or not obj.Parent then
                if Highlights[obj] then
                    Highlights[obj]:Destroy()
                    Highlights[obj] = nil
                end
            end
        end
    end)
end

local function stop()
    for _, c in pairs(Connections) do
        if c then c:Disconnect() end
    end
    table.clear(Connections)
    removeAll()
end

local Toggle = TabESP:Toggle({
    Title = "Monster Highlight",
    Desc = "",
    Value = false,
    Flag = "monster_highlight",
    Callback = function(state)
        Enabled = state
        if state then
            start()
        else
            stop()
        end
    end
})
print("Toon Universe | WindUI loaded!")
