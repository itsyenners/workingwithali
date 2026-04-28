local baseplate = Instance.new("Part")
baseplate.Name = "ClientAntiVoid"
baseplate.Size = Vector3.new(2048, 10, 2048)
baseplate.Position = Vector3.new(0, -200, 0)
baseplate.Anchored = true
baseplate.CanCollide = true
baseplate.BrickColor = BrickColor.new("Really black")
baseplate.Material = Enum.Material.ForceField
baseplate.Parent = game:GetService("Workspace")

task.spawn(function()
    while task.wait(1) do
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            baseplate.Position = Vector3.new(character.HumanoidRootPart.Position.X, -200, character.HumanoidRootPart.Position.Z)
        end
    end
end)

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

local lang = "EN"

local T = {
    EN = {
        title = "Toon Universe  |  Farm Script",
        author = "Thanks for using the script!",
        tab_main = "Main", tab_player = "Player", tab_farm = "Farm",
        tab_teleport = "Teleport", tab_settings = "Settings",
        tab_changelog = "Changelog", tab_credits = "Credits",
        esp_caps = "ESP Capsules", esp_caps_desc = "Highlights all capsules on the map",
        esp_items = "ESP Items", esp_items_desc = "Highlights all items on the map",
        esp_machines = "ESP Machines", esp_machines_desc = "Highlights all oil machines on the map",
        esp_computers = "ESP Computers", esp_computers_desc = "Highlights all computers on the map",
        esp_monsters = "ESP Monsters", esp_monsters_desc = "Highlights all monsters on the map",
        esp_main = "ESP Main Machine", esp_main_desc = "Highlights the main machine on the map",
        walkspeed = "Walk Speed", walkspeed_desc = "Adjust your walking speed",
        stamina = "Infinite Stamina", stamina_desc = "Prevents stamina from draining",
        noclip = "Noclip", noclip_desc = "Walk through walls and objects",
        farm_caps = "Pick Up All Capsules", farm_caps_desc = "Teleports to and collects all capsules",
        farm_items = "Pick Up All Items", farm_items_desc = "Teleports to and collects all items",
        farm_parts = "Pick Up All Parts", farm_parts_desc = "Teleports to and collects all parts",
        tele_machine = "Teleport to Machine", tele_machine_desc = "Teleports to each oil machine",
        tele_computer = "Teleport to Computer", tele_computer_desc = "Teleports to each computer",
        tele_main = "Teleport to Main Machine", tele_main_desc = "Teleports to the main machine",
        tele_electric = "Teleport to Electric Box", tele_electric_desc = "Teleports to the electric box during blackouts",
        tele_elevator = "Auto Teleport to Elevator", tele_elevator_desc = "Teleports to elevator when the floor is complete",
        auto_hide = "Auto Hide", auto_hide_desc = "Automatically hides when a monster chases you",
        esp_fill = "ESP Fill Transparency", esp_fill_desc = "Adjust the transparency of ESP highlights",
        esp_outline = "ESP Outline Transparency", esp_outline_desc = "Adjust the outline transparency of ESP highlights",
        esp_refresh = "ESP Refresh Rate", esp_refresh_desc = "How often ESP updates (in seconds)",
        farm_delay = "Farm Delay", farm_delay_desc = "Delay between collecting each item",
        language = "Language", language_desc = "Change the script language",
        v101_title = "v1.0.1 (Current)", v101_desc = "Subtitle changed to: Thanks for using the script!\nDiscord hint added in Credits\nDiscord notification on startup\nLanguage option removed from Settings\nErrors now shown in console\nChangelog reformatted\nBy Myllo and Ali now only appears as a side tag\nSubtitle changed from: By Myllo and Ali",
        v100_title = "v1.0.0", v100_desc = "Revamped UI\nAll tabs added\nPick Up All Parts\nTeleport to Electric Box\nAuto Hide (by Ali)\nInfinite Stamina (by Ali)\nFixed elevator barriers\nFixed Noclip\nBilingual EN/PT-BR",
        v09_title = "v0.9", v09_desc = "Initial WindUI version\nESP, Farm, Teleport, Misc tabs",
        myllo_title = "mynameismyllo (Myllo)", myllo_desc = "Creator of Toon Universe's Script (Coder)",
        ali_title = "ali_hhjjj (Ali)", ali_desc = "Helper of Toon Universe Script and Creator of Dolly's Factory Script/TZ Hub",
        windui_title = "WindUI", windui_desc = "UI Library by Footagesus",
        discord_hint = "For questions and bugs, join Ali's server and ping @mynameismyllo",
    },
    ["PT-BR"] = {
        title = "Toon Universe  |  Script de Farm",
        author = "Thanks for using the script!",
        tab_main = "Principal", tab_player = "Jogador", tab_farm = "Farm",
        tab_teleport = "Teleporte", tab_settings = "Configuracoes",
        tab_changelog = "Changelog", tab_credits = "Creditos",
        esp_caps = "ESP Capsulas", esp_caps_desc = "Destaca todas as capsulas no mapa",
        esp_items = "ESP Itens", esp_items_desc = "Destaca todos os itens no mapa",
        esp_machines = "ESP Maquinas", esp_machines_desc = "Destaca todas as maquinas no mapa",
        esp_computers = "ESP Computadores", esp_computers_desc = "Destaca todos os computadores no mapa",
        esp_monsters = "ESP Monstros", esp_monsters_desc = "Destaca todos os monstros no mapa",
        esp_main = "ESP Maquina Principal", esp_main_desc = "Destaca a maquina principal no mapa",
        walkspeed = "Velocidade", walkspeed_desc = "Ajuste sua velocidade de caminhada",
        stamina = "Stamina Infinita", stamina_desc = "Impede que a stamina diminua",
        noclip = "Noclip", noclip_desc = "Atravesse paredes e objetos",
        farm_caps = "Pegar Todas as Capsulas", farm_caps_desc = "Teleporta e coleta todas as capsulas",
        farm_items = "Pegar Todos os Itens", farm_items_desc = "Teleporta e coleta todos os itens",
        farm_parts = "Pegar Todas as Pecas", farm_parts_desc = "Teleporta e coleta todas as pecas",
        tele_machine = "Teleportar para Maquina", tele_machine_desc = "Teleporta para cada maquina",
        tele_computer = "Teleportar para Computador", tele_computer_desc = "Teleporta para cada computador",
        tele_main = "Teleportar para Maquina Principal", tele_main_desc = "Teleporta para a maquina principal",
        tele_electric = "Teleportar para Caixa Eletrica", tele_electric_desc = "Teleporta para a caixa eletrica durante apagoes",
        tele_elevator = "Teleporte Automatico para Elevador", tele_elevator_desc = "Teleporta para o elevador quando o andar e concluido",
        auto_hide = "Esconder Automaticamente", auto_hide_desc = "Esconde automaticamente quando um monstro te persegue",
        esp_fill = "Transparencia de Preenchimento ESP", esp_fill_desc = "Ajuste a transparencia do preenchimento do ESP",
        esp_outline = "Transparencia do Contorno ESP", esp_outline_desc = "Ajuste a transparencia do contorno do ESP",
        esp_refresh = "Taxa de Atualizacao ESP", esp_refresh_desc = "Com que frequencia o ESP atualiza (em segundos)",
        farm_delay = "Delay do Farm", farm_delay_desc = "Delay entre coletar cada item",
        language = "Idioma", language_desc = "Mude o idioma do script",
        v101_title = "v1.0.1 (Atual)", v101_desc = "Subtitulo alterado para: Thanks for using the script!\nDica do Discord adicionada nos Creditos\nNotificacao do Discord ao iniciar\nOpcao de idioma removida das Configuracoes\nErros agora aparecem no console\nChangelog reformatado\nBy Myllo and Ali agora aparece apenas como tag lateral\nSubtitulo alterado de: By Myllo and Ali",
        v100_title = "v1.0.0", v100_desc = "UI Reformulada\nTodas as abas\nPegar Todas as Pecas\nTeleporte Caixa Eletrica\nEsconder Automatico (Ali)\nStamina Infinita (Ali)\nElevador corrigido\nNoclip corrigido\nEN/PT-BR",
        v09_title = "v0.9", v09_desc = "Versao inicial WindUI\nAbas ESP, Farm, Teleporte, Misc",
        myllo_title = "mynameismyllo (Myllo)", myllo_desc = "Criador do Script do Toon Universe (Programador)",
        ali_title = "ali_hhjjj (Ali)", ali_desc = "Ajudante do Script do Toon Universe e Criador do Script do Dollys Factory",
        windui_title = "WindUI", windui_desc = "Biblioteca de UI por Footagesus",
        discord_hint = "Em caso de questoes e bugs, entre no servidor do Ali e de ping no @mynameismyllo",
    },
}

local function tr(key)
    return T[lang][key] or T["EN"][key] or key
end

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

local espFillTransparency = 0.5
local espOutlineTransparency = 0
local espRefreshRate = 3
local farmDelayValue = 0.3

local function createHighlight(adornee, fillColor, tag)
    if adornee:FindFirstChild(tag) then
        local h = adornee:FindFirstChild(tag)
        h.FillTransparency = espFillTransparency
        h.OutlineTransparency = espOutlineTransparency
        return
    end
    local h = Instance.new("Highlight")
    h.Name = tag
    h.Adornee = adornee
    h.FillColor = fillColor
    h.OutlineColor = Color3.new(1, 1, 1)
    h.FillTransparency = espFillTransparency
    h.OutlineTransparency = espOutlineTransparency
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = adornee
end

local function clearTag(tag)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == tag then obj:Destroy() end
    end
end

local function addText(tab, title, desc)
    local ok, err
    ok, err = pcall(function() tab:Paragraph({ Title = title, Desc = desc }) end)
    if not ok then
        ok, err = pcall(function() tab:Label({ Title = title, Desc = desc }) end)
    end
    if not ok then
        ok, err = pcall(function() tab:Button({ Title = title, Desc = desc, Justify = "Left", Callback = function() end }) end)
    end
    if not ok then warn("[ToonUniverse] addText error: " .. tostring(err)) end
end

local function createWindow()
    local Window = WindUI:CreateWindow({
        Title = tr("title"),
        Icon = "zap",
        Author = tr("author"),
        Folder = "ToonUniverseHub",
        Size = UDim2.fromOffset(580, 460),
    })

    Window:Tag({ Title = "by Myllo & Ali", Color = Color3.fromHex("#1c1c1c"), Border = true })

    local Green  = Color3.fromHex("#10C550")
    local Yellow = Color3.fromHex("#ECA201")
    local Blue   = Color3.fromHex("#257AF7")
    local Purple = Color3.fromHex("#7775F2")
    local Grey   = Color3.fromHex("#83889E")
    local Orange = Color3.fromHex("#FF7800")

    local TabMain      = Window:Tab({ Title = tr("tab_main"),      Icon = "eye",      IconColor = Blue,   IconShape = "Square", Border = true })
    local TabPlayer    = Window:Tab({ Title = tr("tab_player"),    Icon = "user",     IconColor = Green,  IconShape = "Square", Border = true })
    local TabFarm      = Window:Tab({ Title = tr("tab_farm"),      Icon = "zap",      IconColor = Yellow, IconShape = "Square", Border = true })
    local TabTele      = Window:Tab({ Title = tr("tab_teleport"),  Icon = "map-pin",  IconColor = Purple, IconShape = "Square", Border = true })
    local TabSettings  = Window:Tab({ Title = tr("tab_settings"),  Icon = "settings", IconColor = Grey,   IconShape = "Square", Border = true })
    local TabChangelog = Window:Tab({ Title = tr("tab_changelog"), Icon = "clock",    IconColor = Orange, IconShape = "Square", Border = true })
    local TabCredits   = Window:Tab({ Title = tr("tab_credits"),   Icon = "star",     IconColor = Yellow, IconShape = "Square", Border = true })

    -- MAIN TAB
    local espCaps, espItens, espMaq, espComp, espMons, espBig = false, false, false, false, false, false

    TabMain:Toggle({ Title = tr("esp_caps"),      Desc = tr("esp_caps_desc"),      Value = false, Flag = "ESPCaps",
        Callback = function(val) espCaps  = val if not val then clearTag("ESP_Caps")  end end })
    TabMain:Space()
    TabMain:Toggle({ Title = tr("esp_items"),     Desc = tr("esp_items_desc"),     Value = false, Flag = "ESPItens",
        Callback = function(val) espItens = val if not val then clearTag("ESP_Itens") end end })
    TabMain:Space()
    TabMain:Toggle({ Title = tr("esp_machines"),  Desc = tr("esp_machines_desc"),  Value = false, Flag = "ESPMaq",
        Callback = function(val) espMaq   = val if not val then clearTag("ESP_Maq")   end end })
    TabMain:Space()
    TabMain:Toggle({ Title = tr("esp_computers"), Desc = tr("esp_computers_desc"), Value = false, Flag = "ESPComp",
        Callback = function(val) espComp  = val if not val then clearTag("ESP_Comp")  end end })
    TabMain:Space()
    TabMain:Toggle({ Title = tr("esp_monsters"),  Desc = tr("esp_monsters_desc"),  Value = false, Flag = "ESPMons",
        Callback = function(val) espMons  = val if not val then clearTag("ESP_Mons")  end end })
    TabMain:Space()
    TabMain:Toggle({ Title = tr("esp_main"),      Desc = tr("esp_main_desc"),      Value = false, Flag = "ESPBig",
        Callback = function(val) espBig   = val if not val then clearTag("ESP_Big")   end end })

    local monstersSemRoot = { "TSquid", "TDiscardd", "TNimbus" }

    task.spawn(function()
        while task.wait(espRefreshRate) do
            if espCaps then
                for _, model in ipairs(workspace.Capsules:GetChildren()) do
                    createHighlight(model, Color3.fromRGB(0, 255, 80), "ESP_Caps")
                end
            end
            if espItens then
                for _, item in ipairs(workspace.Items:GetChildren()) do
                    if item.Name ~= "Parts" then
                        createHighlight(item, Color3.fromRGB(255, 220, 0), "ESP_Itens")
                    end
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
                local ok2, big = pcall(function() return workspace.Map.SpecialFolder.BigMachine.Computer end)
                if not ok2 then ok2, big = pcall(function() return workspace.Map.SpecialFolder.BigMachine.Machine end) end
                if ok2 and big then createHighlight(big, Color3.fromRGB(255, 0, 255), "ESP_Big")
                elseif not ok2 then warn("[ToonUniverse] ESP Main Machine: nao foi possivel encontrar a maquina principal") end
            end
        end
    end)

    -- PLAYER TAB
    TabPlayer:Slider({
        Title = tr("walkspeed"), Desc = tr("walkspeed_desc"), Flag = "Speed", Step = 1,
        Value = { Min = 16, Max = 150, Default = 16 },
        Callback = function(val)
            speedValue = val
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.WalkSpeed = val end
        end,
    })
    TabPlayer:Space()
    TabPlayer:Toggle({
        Title = tr("stamina"), Desc = tr("stamina_desc"), Value = false, Flag = "InfStamina", Icon = "zap",
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
                if _G.staminaConn then _G.staminaConn:Disconnect() _G.staminaConn = nil end
            end
        end,
    })
    TabPlayer:Space()
    local noclipActive = false
    TabPlayer:Toggle({
        Title = tr("noclip"), Desc = tr("noclip_desc"), Value = false, Flag = "Noclip",
        Callback = function(val) noclipActive = val end,
    })
    RunService.RenderStepped:Connect(function()
        if noclipActive and char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    -- FARM TAB
    local farmCapsulesActive = false
    TabFarm:Toggle({
        Title = tr("farm_caps"), Desc = tr("farm_caps_desc"), Value = false, Flag = "FarmCaps",
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
                            task.wait(farmDelayValue)
                            fireproximityprompt(prompt)
                            task.wait(farmDelayValue)
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
        Title = tr("farm_items"), Desc = tr("farm_items_desc"), Value = false, Flag = "FarmItens",
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
                            task.wait(farmDelayValue)
                            fireproximityprompt(prompt)
                            task.wait(farmDelayValue)
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
        Title = tr("farm_parts"), Desc = tr("farm_parts_desc"), Value = false, Flag = "FarmParts",
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
                            task.wait(farmDelayValue)
                            fireproximityprompt(prompt)
                            task.wait(farmDelayValue)
                        end
                    end
                    task.wait(1)
                end
            end)
        end,
    })

    -- TELEPORT TAB
    TabTele:Button({
        Title = tr("tele_machine"), Desc = tr("tele_machine_desc"), Icon = "cpu", Justify = "Center",
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
        Title = tr("tele_computer"), Desc = tr("tele_computer_desc"), Icon = "monitor", Justify = "Center",
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
        Title = tr("tele_main"), Desc = tr("tele_main_desc"), Icon = "building", Justify = "Center", Color = Purple,
        Callback = function()
            local ok2, prompt = pcall(function() return workspace.Map.SpecialFolder.BigMachine.Computer.PromptPart end)
            if not ok2 then ok2, prompt = pcall(function() return workspace.Map.SpecialFolder.BigMachine.Machine.PromptPart end) end
            if ok2 and prompt and root then root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
            elseif not ok2 then warn("[ToonUniverse] Teleport Main Machine: nao foi possivel encontrar o PromptPart") end
        end,
    })
    TabTele:Space()
    TabTele:Button({
        Title = tr("tele_electric"), Desc = tr("tele_electric_desc"), Icon = "zap", Justify = "Center", Color = Yellow,
        Callback = function()
            local ok2, prompt = pcall(function() return workspace.Map.SpecialFolder.ElectricBoxes.ElectricBox.PromptPart end)
            if ok2 and prompt and root then root.CFrame = prompt.CFrame + Vector3.new(0, 3, 0)
            elseif not ok2 then warn("[ToonUniverse] Teleport Electric Box: nao foi possivel encontrar o PromptPart") end
        end,
    })
    TabTele:Space()

    local MapStats, FloorValue, Elevator
    local elevRunning, elevEnabled = false, false
    local elevConnection

    local function getElevCFrame()
        if not Elevator then return nil end
        if Elevator.PrimaryPart then return Elevator.PrimaryPart.CFrame end
        local part = Elevator:FindFirstChildWhichIsA("BasePart")
        return part and part.CFrame or nil
    end

    local function removeBarriers()
        if not Elevator then return end
        local barrier = Elevator:FindFirstChild("Barrier")
        local safetyBarrier = workspace:FindFirstChild("SafteyBarrier")
        if barrier then barrier.CanCollide = false end
        if safetyBarrier then safetyBarrier.CanCollide = false end
    end

    local function elevTeleportLoop()
        if elevRunning or not FloorValue then return end
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
        if not FloorValue then return end
        removeBarriers()
        if elevConnection then elevConnection:Disconnect() end
        elevConnection = FloorValue:GetPropertyChangedSignal("Value"):Connect(function()
            if elevEnabled and FloorValue.Value then
                removeBarriers()
                elevTeleportLoop()
            end
        end)
        if FloorValue.Value then elevTeleportLoop() end
    end

    local function elevStop()
        elevEnabled = false
        elevRunning = false
        if elevConnection then elevConnection:Disconnect() elevConnection = nil end
    end

    task.spawn(function()
        MapStats   = workspace:WaitForChild("MapStats", 30)
        if not MapStats then return end
        FloorValue = MapStats:WaitForChild("IsFloorCompleted", 30)
        Elevator   = workspace:WaitForChild("Elevator", 30)
    end)

    TabTele:Toggle({
        Title = tr("tele_elevator"), Desc = tr("tele_elevator_desc"), Icon = "power", Value = false, Flag = "AutoElev",
        Callback = function(state)
            elevEnabled = state
            if state then elevStart() else elevStop() end
        end,
    })
    TabTele:Space()

    local teleportEnabled = false
    local TeleportPart = nil

    task.spawn(function()
        local elev = workspace:WaitForChild("Elevator", 30)
        if elev then
            local model = elev:FindFirstChild("Model")
            if model then TeleportPart = model:GetChildren()[20] end
        end
    end)

    local ok3, ChaseRemote = pcall(function() return ReplicatedStorage.Remotes.Chase end)
    if not ok3 then warn("[ToonUniverse] Auto Hide: nao foi possivel encontrar o Chase remote - " .. tostring(ChaseRemote)) end
    if ok3 and ChaseRemote then
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
            if state == "Started" and teleportEnabled then loopHide() end
        end)
    end

    TabTele:Toggle({
        Title = tr("auto_hide"), Desc = tr("auto_hide_desc"), Icon = "shield", Value = false, Flag = "AutoHide",
        Callback = function(state) teleportEnabled = state end,
    })
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local AutoSkillcheck = false

local function FireConnections(signal)
	local ok, conns = pcall(getconnections, signal)
	if ok then
		for _, c in conns do
			pcall(function() c:Fire() end)
		end
	end
end

local function NormRot(r)
	return (r + 180) % 360 - 180
end

local Toggle = TabFarm:Toggle({
	Title = "Auto Skillcheck\Verificação automática de habilidades",
	Desc = "",
	Icon = "cpu",
	Value = false,
	Type = "Toggle",
	Color = Color3.fromRGB(100, 200, 100),
	Flag = "auto_skillcheck",
	Callback = function(state)
		AutoSkillcheck = state
	end
})

-- Computer Skillcheck
task.spawn(function()
	local RoundSkillcheck = LocalPlayer.PlayerGui:WaitForChild("RoundSkillcheck", 15)
	if not RoundSkillcheck then return end

	local Container = RoundSkillcheck:WaitForChild("Container")
	local Normal = Container:WaitForChild("Normal")
	local AimImage = Normal:WaitForChild("AimImage")
	local Target = Normal:WaitForChild("Target")
	local HitBtn = Normal:WaitForChild("Hit")

	local fired = false
	local lastV7 = nil
	local lastVisible = false

	RunService.Heartbeat:Connect(function()
		if not AutoSkillcheck then return end

		local visible = Normal.Visible
		if visible ~= lastVisible then
			if visible then
				fired = false
				lastV7 = nil
			end
			lastVisible = visible
		end
		if not visible or fired then return end

		local aim = NormRot(AimImage.Rotation + 180)
		local zoneStart = NormRot(Target.Rotation - 30)
		local v7 = math.abs(((aim - zoneStart) + 180) % 360 - 180) / 60

		if lastV7 ~= nil and lastV7 < 0.5 and v7 >= 0.5 then
			fired = true
			FireConnections(HitBtn.MouseButton1Down)
		end

		lastV7 = v7
	end)
end)

-- OilMachine Skillcheck
task.spawn(function()
	local LockUI = LocalPlayer.PlayerGui:WaitForChild("LockUI", 15)
	if not LockUI then return end

	local HUD = LockUI:WaitForChild("HUD")
	local Skillcheck = HUD:WaitForChild("Skillcheck")
	local Main = Skillcheck:WaitForChild("Main")
	local Marker = Main:WaitForChild("Marker")
	local Objective = Main:WaitForChild("Objective")
	local MobileBtn = Main:WaitForChild("MobileButtonClick")

	local fired = false
	local lastDist = nil
	local lastVisible = false

	RunService.Heartbeat:Connect(function()
		if not AutoSkillcheck then return end

		local visible = Marker.Visible
		if visible ~= lastVisible then
			if visible then
				fired = false
				lastDist = nil
			end
			lastVisible = visible
		end
		if not visible or fired then return end

		local mCenter = Marker.AbsolutePosition.X + Marker.AbsoluteSize.X * 0.5
		local oCenter = Objective.AbsolutePosition.X + Objective.AbsoluteSize.X * 0.5
		local dist = mCenter - oCenter

		if lastDist ~= nil and lastDist < 0 and dist >= 0 then
			fired = true
			FireConnections(MobileBtn.MouseButton1Down)
		end

		lastDist = dist
	end)
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local originalComputerSkillcheck
local originalOilStart
local patched = false

local function safeRequire(path)
    local ok, mod = pcall(function() return require(path) end)
    if not ok then
        warn("[Skillcheck] require failed for", tostring(path), ":", mod)
        return false, nil
    end
    return true, mod
end

local function applyPatches()
    if patched then return end

    do
        local ok, ComputerModule = safeRequire(ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck)
        if ok and type(ComputerModule) == "table" and type(ComputerModule.Skillcheck) == "function" then
            originalComputerSkillcheck = ComputerModule.Skillcheck
            ComputerModule.Skillcheck = function(p1, p2, p3, p4)
                local startTime = tick()
                local okCall, resultOrErr = pcall(originalComputerSkillcheck, p1, p2, p3, p4)
                local elapsed = tick() - startTime

                if not okCall then
                    warn(string.format("[Skillcheck] Computer original errored after %.3fs: %s", elapsed, tostring(resultOrErr)))
                else
                    print(string.format("[Skillcheck] Computer original finished in %.3fs, original returned: %s", elapsed, tostring(resultOrErr)))
                end

                print("[Skillcheck] Computer: Perfect!")
                return "Perfect"
            end
        else
            warn("[Skillcheck] ComputerModule.Skillcheck not found; creating fallback that returns 'Perfect'.")
            ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck = ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck or {}
            ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck.Skillcheck = function()
                print("[Skillcheck] Computer fallback: Perfect!")
                return "Perfect"
            end
        end
    end

    do
        local ok, OilModule = safeRequire(ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck)
        if ok and type(OilModule) == "table" and type(OilModule.Start) == "function" then
            originalOilStart = OilModule.Start
            OilModule.Start = function(p1, p2, p3)
                local startTime = tick()

                if p2 ~= nil and type(p2) ~= "number" then
                    warn("[Skillcheck] Oil Start received non-number p2; coercing to 0.")
                    p2 = 0
                end

                local okCall, resultOrErr = pcall(originalOilStart, p1, p2, p3)
                local elapsed = tick() - startTime

                if not okCall then
                    warn(string.format("[Skillcheck] Oil original errored after %.3fs: %s", elapsed, tostring(resultOrErr)))
                else
                    print(string.format("[Skillcheck] Oil original finished in %.3fs, original returned: %s", elapsed, tostring(resultOrErr)))
                end

                print("[Skillcheck] Oil Machine: Perfect!")
                return "Perfect"
            end
        else
            warn("[Skillcheck] OilModule.Start not found; creating fallback that returns 'Perfect'.")
            ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck = ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck or {}
            ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck.Start = function()
                print("[Skillcheck] Oil fallback: Perfect!")
                return "Perfect"
            end
        end
    end

    patched = true
    print("Skillcheck Loaded. All checks will now return 'Perfect'.")
end

local function removePatches()
    if not patched then return end

    local ok, ComputerModule = pcall(function() return ReplicatedStorage.Modules.SkillChecks.ComputerSkillCheck end)
    if ok and type(ComputerModule) == "table" and originalComputerSkillcheck then
        ComputerModule.Skillcheck = originalComputerSkillcheck
        originalComputerSkillcheck = nil
    end

    local ok2, OilModule = pcall(function() return ReplicatedStorage.Modules.SkillChecks.OilMachineSkillCheck end)
    if ok2 and type(OilModule) == "table" and originalOilStart then
        OilModule.Start = originalOilStart
        originalOilStart = nil
    end

    patched = false
    print("Skillcheck patches removed. Originals restored where available.")
end

local Toggle = TabFarm:Toggle({
    Title = "Instant auto skillcheck\Verificação automática instantânea de habilidades",
    Desc = "Complete skillcheck without clicking\Conclua o teste de habilidade sem clicar",
    Icon = "power",
    Value = false,
    Type = "Toggle",
    Color = Color3.fromRGB(100, 200, 100),
    Locked = false,
    Flag = "instantskill_toggle",
    Callback = function(state)
        print("State changed:", state)
        if state then
            local ok, err = pcall(applyPatches)
            if not ok then
                warn("[Skillcheck] Failed to apply patches:", err)
            end
        else
            local ok, err = pcall(removePatches)
            if not ok then
                warn("[Skillcheck] Failed to remove patches:", err)
            end
        end
    end
})

    -- SETTINGS TAB
    TabSettings:Slider({
        Title = tr("esp_fill"), Desc = tr("esp_fill_desc"), Flag = "ESPFill", Step = 0.1,
        Value = { Min = 0, Max = 1, Default = 0.5 },
        Callback = function(val) espFillTransparency = val end,
    })
    TabSettings:Space()
    TabSettings:Slider({
        Title = tr("esp_outline"), Desc = tr("esp_outline_desc"), Flag = "ESPOutline", Step = 0.1,
        Value = { Min = 0, Max = 1, Default = 0 },
        Callback = function(val) espOutlineTransparency = val end,
    })
    TabSettings:Space()
    TabSettings:Slider({
        Title = tr("esp_refresh"), Desc = tr("esp_refresh_desc"), Flag = "ESPRefresh", Step = 1,
        Value = { Min = 1, Max = 10, Default = 3 },
        Callback = function(val) espRefreshRate = val end,
    })
    TabSettings:Space()
    TabSettings:Slider({
        Title = tr("farm_delay"), Desc = tr("farm_delay_desc"), Flag = "FarmDelay", Step = 0.1,
        Value = { Min = 0.1, Max = 2, Default = 0.3 },
        Callback = function(val) farmDelayValue = val end,
    })


    -- CHANGELOG TAB
    addText(TabChangelog, tr("v101_title"), tr("v101_desc"))
    TabChangelog:Space()
    addText(TabChangelog, tr("v100_title"), tr("v100_desc"))
    TabChangelog:Space()
    addText(TabChangelog, tr("v09_title"), tr("v09_desc"))

    -- CREDITS TAB
    addText(TabCredits, tr("myllo_title"), tr("myllo_desc"))
    TabCredits:Space()
    addText(TabCredits, tr("ali_title"), tr("ali_desc"))
    TabCredits:Space()
    TabCredits:Button({
        Title = "Ali's Discord Server",
        Desc = "discord.gg/NKUefuSfqb",
        Icon = "message-circle",
        Justify = "Center",
        Callback = function()
            setclipboard("https://discord.gg/NKUefuSfqb")
            WindUI:Notify({
                Title = "Discord",
                Content = "Link copied to clipboard!",
                Icon = "message-circle",
                Duration = 3,
            })
        end,
    })
    TabCredits:Space()
    addText(TabCredits, "💬 " .. tr("discord_hint"), "")
    TabCredits:Space()
    addText(TabCredits, tr("windui_title"), tr("windui_desc"))

    print("Toon Universe | v1.0.1 | " .. lang .. " | loaded!")
end

WindUI:Popup({
    Title = "Language / Idioma",
    Content = "What language do you want? / Qual idioma voce quer?",
    Buttons = {
        {
            Title = "English",
            Callback = function()
                lang = "EN"
                local ok, err = pcall(createWindow)
                if not ok then warn("WindUI Error: " .. tostring(err)) end
                WindUI:Notify({
                    Title = "Welcome!",
                    Content = "Don't forget to join the Discord server in the Credits!",
                    Icon = "message-circle",
                    Duration = 6,
                })
            end,
        },
        {
            Title = "Portugues (BR)",
            Callback = function()
                lang = "PT-BR"
                local ok, err = pcall(createWindow)
                if not ok then warn("WindUI Error: " .. tostring(err)) end
                WindUI:Notify({
                    Title = "Bem-vindo!",
                    Content = "Nao esqueca de entrar no servidor do Discord nos Creditos!",
                    Icon = "message-circle",
                    Duration = 6,
                })
            end,
        },
    },
})
