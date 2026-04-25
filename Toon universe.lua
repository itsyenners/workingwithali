local ok, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not ok or not Rayfield then
    print("Erro ao carregar Rayfield!")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "Toon Universe",
    LoadingTitle = "Farm Script",
    LoadingSubtitle = "by Myllooo",
    Theme = "Default",
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
})

local TabESP = Window:CreateTab("ESP", "eye")
local TabFarm = Window:CreateTab("Farm", "zap")
local TabTele = Window:CreateTab("Teleport", "map-pin")
local TabMisc = Window:CreateTab("Misc", "settings")

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local root = char:FindFirstChild("HumanoidRootPart")
local speedValue = 16

player.CharacterAdded:Connect(function(c)
    char = c
    root = c:WaitForChild("HumanoidRootPart")
    local hum = c:WaitForChild("Humanoid")
    hum.WalkSpeed = speedValue
end)

local function criarHighlight(adornee, fillColor, tag)
    if adornee:FindFirstChild(tag) then return end
    local h = Instance.new("Highlight")
    h.Name = tag
    h.Adornee = adornee
    h.FillColor = fillColor
    h.OutlineColor = Color3.new(1,1,1)
    h.FillTransparency = 0.5
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = adornee
end

local function limparTag(tag)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == tag then obj:Destroy() end
    end
end

local espCaps, espItens, espMaq, espComp, espMons, espBig = false,false,false,false,false,false

TabESP:CreateToggle({ Name = "ESP Capsulas", CurrentValue = false, Flag = "ESPCaps",
    Callback = function(val) espCaps = val if not val then limparTag("ESP_Caps") end end })

TabESP:CreateToggle({ Name = "ESP Itens", CurrentValue = false, Flag = "ESPItens",
    Callback = function(val) espItens = val if not val then limparTag("ESP_Itens") end end })

TabESP:CreateToggle({ Name = "ESP Maquinas", CurrentValue = false, Flag = "ESPMaq",
    Callback = function(val) espMaq = val if not val then limparTag("ESP_Maq") end end })

TabESP:CreateToggle({ Name = "ESP Computadores", CurrentValue = false, Flag = "ESPComp",
    Callback = function(val) espComp = val if not val then limparTag("ESP_Comp") end end })

TabESP:CreateToggle({ Name = "ESP Monstros", CurrentValue = false, Flag = "ESPMons",
    Callback = function(val) espMons = val if not val then limparTag("ESP_Mons") end end })

TabESP:CreateToggle({ Name = "ESP Big Machine", CurrentValue = false, Flag = "ESPBig",
    Callback = function(val) espBig = val if not val then limparTag("ESP_Big") end end })

local monstersSemRoot = {"TSquid", "TDiscardd", "TNimbus"}

task.spawn(function()
    while task.wait(3) do
        if espCaps then
            for _, model in ipairs(workspace.Capsules:GetChildren()) do
                criarHighlight(model, Color3.fromRGB(0, 255, 80), "ESP_Caps")
            end
        end
        if espItens then
            for _, item in ipairs(workspace.Items:GetChildren()) do
                criarHighlight(item, Color3.fromRGB(255, 220, 0), "ESP_Itens")
            end
        end
        if espMaq then
            for _, machine in ipairs(workspace.OilMachines:GetChildren()) do
                criarHighlight(machine, Color3.fromRGB(255, 120, 0), "ESP_Maq")
            end
        end
        if espComp then
            for _, comp in ipairs(workspace.Computers:GetChildren()) do
                criarHighlight(comp, Color3.fromRGB(0, 180, 255), "ESP_Comp")
            end
        end
        if espMons then
            for _, folder in ipairs(workspace.MonsterFolder:GetChildren()) do
                local semRoot = false
                for _, nome in ipairs(monstersSemRoot) do
                    if folder.Name == nome then semRoot = true break end
                end
                if semRoot then
                    for _, obj in ipairs(folder:GetChildren()) do
                        criarHighlight(obj, Color3.fromRGB(255, 0, 0), "ESP_Mons")
                    end
                elseif folder:FindFirstChild("RootPart") then
                    criarHighlight(folder, Color3.fromRGB(255, 0, 0), "ESP_Mons")
                else
                    for _, monster in ipairs(folder:GetChildren()) do
                        if monster:FindFirstChild("RootPart") then
                            criarHighlight(monster, Color3.fromRGB(255, 0, 0), "ESP_Mons")
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
                criarHighlight(big, Color3.fromRGB(255, 0, 255), "ESP_Big")
            end
        end
    end
end)

local farmCapsulasAtivo = false
TabFarm:CreateToggle({
    Name = "Farm Capsulas", CurrentValue = false, Flag = "FarmCaps",
    Callback = function(val)
        farmCapsulasAtivo = val
        task.spawn(function()
            while farmCapsulasAtivo do
                for _, model in ipairs(workspace.Capsules:GetChildren()) do
                    if not farmCapsulasAtivo then break end
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

local farmItensAtivo = false
TabFarm:CreateToggle({
    Name = "Farm Itens", CurrentValue = false, Flag = "FarmItens",
    Callback = function(val)
        farmItensAtivo = val
        task.spawn(function()
            while farmItensAtivo do
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if not farmItensAtivo then break end
                    local parte = item:FindFirstChild("Cube") or item:FindFirstChild("Cubee.003")
                    local prompt = item:FindFirstChild("ProximityPrompt")
                    if parte and prompt and root then
                        root.CFrame = parte.CFrame + Vector3.new(0, 3, 0)
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

TabFarm:CreateButton({
    Name = "Limpar Todo ESP",
    Callback = function()
        for _, tag in ipairs({"ESP_Caps","ESP_Itens","ESP_Maq","ESP_Comp","ESP_Mons","ESP_Big"}) do
            limparTag(tag)
        end
        Rayfield:Notify({ Title = "ESP", Content = "ESP removido!", Duration = 3 })
    end,
})

TabTele:CreateButton({
    Name = "Teleportar todas Maquinas",
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

TabTele:CreateButton({
    Name = "Teleportar todos Computadores",
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

TabTele:CreateButton({
    Name = "Teleportar Big Machine",
    Callback = function()
        local ok2, prompt = pcall(function()
            return workspace.Map.SpecialFolder.BigMachine.Computer.PromptPart
        end)
        if ok2 and prompt and root then
            root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
        end
    end,
})

TabMisc:CreateSlider({
    Name = "Velocidade",
    Range = {16, 150},
    Increment = 1,
    Suffix = " WalkSpeed",
    CurrentValue = 16,
    Flag = "Speed",
    Callback = function(val)
        speedValue = val
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = val end
    end,
})

local noclipAtivo = false
TabMisc:CreateToggle({
    Name = "Noclip", CurrentValue = false, Flag = "Noclip",
    Callback = function(val)
        noclipAtivo = val
    end,
})

game:GetService("RunService").RenderStepped:Connect(function()
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipAtivo
            end
        end
    end
end)

print("Script carregado!")
