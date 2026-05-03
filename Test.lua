--this is auto teleport to elevator
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local HRP
local function refreshHRP()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HRP = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
end
if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end
refreshHRP()
LocalPlayer.CharacterAdded:Connect(refreshHRP)

local function deepFindValues(parent, namesSet)
    local found = {}
    if not parent then return found end
    for _, obj in ipairs(parent:GetDescendants()) do
        if (obj:IsA("IntValue") or obj:IsA("NumberValue")) and namesSet[obj.Name] then
            table.insert(found, obj)
        end
    end
    return found
end

local function allAre100(values)
    for _, v in ipairs(values) do
        if not v or v.Value < 100 then
            return false
        end
    end
    return #values > 0
end

local function teleportToModel(model)
    if not model or not HRP then return false end
    local part = model:FindFirstChildWhichIsA("BasePart")
    if part then
        HRP.CFrame = part.CFrame + Vector3.new(0, 3, 0)
        return true
    end
    return false
end

task.spawn(function()
    local targets = { OilValue = true, ComputerPercentage = true }

    while true do
        task.wait(0.25)

        local mapStats = workspace:FindFirstChild("MapStats")
        local floorCompleted = mapStats and mapStats:FindFirstChild("IsFloorCompleted")
        if not floorCompleted or floorCompleted.Value ~= true then
            continue
        end

        local allValues = {}
        local containers = {}

        if workspace:FindFirstChild("OilMachines") then table.insert(containers, workspace.OilMachines) end
        if workspace:FindFirstChild("Computers") then table.insert(containers, workspace.Computers) end
        if workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("SpecialFolder") then
            table.insert(containers, workspace.Map.SpecialFolder)
        end

        for _, container in ipairs(containers) do
            local found = deepFindValues(container, targets)
            for _, v in ipairs(found) do
                table.insert(allValues, v)
            end
        end

        if not allAre100(allValues) then
            continue
        end

        local exitFolder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("SpecialFolder")
        local function getExitElevator()
            if exitFolder then
                return exitFolder:FindFirstChild("ExitElevator")
            end
            return nil
        end

        while true do
            task.wait(0.12)
            if not floorCompleted.Value then
                break
            end

            local exitElevator = getExitElevator()
            local elevator = workspace:FindFirstChild("Elevator")

            if not exitElevator and not elevator then
                break
            end

            if exitElevator and elevator then
                teleportToModel(exitElevator)
                task.wait(0.12)
                if not floorCompleted.Value then break end
                if not exitElevator.Parent then break end
                teleportToModel(elevator)
                task.wait(0.12)
                continue
            end

            break
        end

        while true do
            task.wait(0.12)
            if not floorCompleted.Value then
                break
            end

            local exitElevator = getExitElevator()
            local elevator = workspace:FindFirstChild("Elevator")

            if exitElevator and not elevator then
                teleportToModel(exitElevator)
                if not exitElevator.Parent then
                    break
                end
            elseif elevator and not exitElevator then
                teleportToModel(elevator)
                if not elevator.Parent then
                    break
                end
            else
                break
            end
        end
    end
end)
--end of auto teleport to elevator I'll fix auto skillcheck maybe
--here is the auto pickup items it also check your slots
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local ItemsFolder = LocalPlayer:WaitForChild("ItemsFolder")
local workspaceItems = workspace:WaitForChild("Items")

local MAX_SLOTS = 3
local TELEPORT_OFFSET = Vector3.new(0, 3, 0)
local SCAN_DELAY = 0.15
local RETURN_WAIT = 0.5

local running = true

local function isInventoryFull()
    local used = {}
    for _, child in ipairs(ItemsFolder:GetChildren()) do
        local idx = child:GetAttribute("Index")
        if idx then used[idx] = true end
    end
    for i = 1, MAX_SLOTS do
        if not used[i] then return false end
    end
    return true
end

local function tp(pos)
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    HRP = Character:WaitForChild("HumanoidRootPart")
    HRP.CFrame = CFrame.new(pos + TELEPORT_OFFSET)
end

local function getPos(item)
    if item.PrimaryPart then return item.PrimaryPart.Position end
    for _, d in ipairs(item:GetDescendants()) do
        if d:IsA("BasePart") then return d.Position end
    end
    return nil
end

local function loopFirePrompt(item)
    local prompt = item:FindFirstChildOfClass("ProximityPrompt") or item:FindFirstChildWhichIsA("ProximityPrompt", true)
    if not prompt then return end

    while item.Parent and running do
        if prompt.Enabled then
            fireproximityprompt(prompt)
        end
        task.wait(0.05)
    end
end

local function scan()
    local originalPos = HRP.Position

    while running do
        for _, item in ipairs(workspaceItems:GetChildren()) do
            if not running then break end
            if not item or not item.Parent then continue end

            if isInventoryFull() then
                tp(originalPos)
                repeat task.wait(RETURN_WAIT) until not isInventoryFull() or not running
            end

            local pos = getPos(item)
            if pos then
                tp(pos)
                task.wait(SCAN_DELAY)
                loopFirePrompt(item)
            end
        end

        task.wait(0.2)
    end
end

task.spawn(scan)

_G.StopCollector = function()
    running = false
end

print("Running.")
--end of auto pickup items