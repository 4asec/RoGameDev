--!strict
--[[
    EnvironmentService.luau
    Builds and manages the 3D Indonesian open city environment:
    Asphalt roads, sidewalks, Tugu Monas landmark, Stasiun Gambir, KAI executive train,
    Sudirman skyscrapers, Warung Madura, Warkop Cuan, Pos Ronda, and tropical vegetation.
]]

local Workspace = game:GetService("Workspace")

local EnvironmentService = {}
EnvironmentService.__index = EnvironmentService

local function makePart(parent: Instance, name: string, size: Vector3, cf: CFrame, color: Color3, material: Enum.Material?, anchored: boolean?, canCollide: boolean?): Part
    local p = Instance.new("Part")
    p.Name = name
    p.Size = size
    p.CFrame = cf
    p.Color = color
    p.Material = material or Enum.Material.SmoothPlastic
    p.Anchored = (anchored == nil) and true or anchored
    p.CanCollide = (canCollide == nil) and true or canCollide
    p.Parent = parent
    return p
end

function EnvironmentService.BuildJakartaCity()
    if Workspace:FindFirstChild("WargaPartyEnvironment") then
        Workspace.WargaPartyEnvironment:Destroy()
    end
    if Workspace:FindFirstChild("Baseplate") then
        local bp = Workspace.Baseplate :: BasePart
        bp.Transparency = 1
        bp.CanCollide = false
    end

    local envFolder = Instance.new("Folder")
    envFolder.Name = "WargaPartyEnvironment"

    -- 1. Base City Grass
    makePart(envFolder, "CityBaseGrass", Vector3.new(400, 2, 450), CFrame.new(0, 0, 140), Color3.fromRGB(74, 120, 60), Enum.Material.Grass)

    -- 2. Road Network
    local roadsFolder = Instance.new("Folder")
    roadsFolder.Name = "Roads"
    roadsFolder.Parent = envFolder

    local function buildRoadSegment(startPos: Vector3, endPos: Vector3, width: number?)
        local roadWidth = width or 18
        local delta = endPos - startPos
        local distance = delta.Magnitude
        local midPos = (startPos + endPos) / 2
        local lookCF = CFrame.lookAt(midPos, endPos)

        makePart(roadsFolder, "AsphaltRoad", Vector3.new(roadWidth, 1.2, distance), lookCF * CFrame.new(0, 0.4, 0), Color3.fromRGB(35, 39, 42), Enum.Material.Concrete)
        makePart(roadsFolder, "Sidewalk_L", Vector3.new(4, 1.8, distance), lookCF * CFrame.new(-(roadWidth/2 + 2), 0.7, 0), Color3.fromRGB(180, 185, 190), Enum.Material.SmoothPlastic)
        makePart(roadsFolder, "Sidewalk_R", Vector3.new(4, 1.8, distance), lookCF * CFrame.new((roadWidth/2 + 2), 0.7, 0), Color3.fromRGB(180, 185, 190), Enum.Material.SmoothPlastic)

        local numDashes = math.floor(distance / 12)
        for i = 0, numDashes do
            local offsetZ = -distance/2 + (i + 0.5) * (distance / (numDashes + 1))
            makePart(roadsFolder, "LaneDivider", Vector3.new(0.8, 1.25, 4), lookCF * CFrame.new(0, 0.42, offsetZ), Color3.fromRGB(245, 200, 35), Enum.Material.Neon)
        end
    end

    buildRoadSegment(Vector3.new(0, 0, -10), Vector3.new(0, 0, 20))
    buildRoadSegment(Vector3.new(0, 0, 20), Vector3.new(0, 0, 40))
    buildRoadSegment(Vector3.new(0, 0, 40), Vector3.new(0, 0, 60))
    buildRoadSegment(Vector3.new(0, 0, 60), Vector3.new(-30, 0, 80))
    buildRoadSegment(Vector3.new(-30, 0, 80), Vector3.new(-30, 0, 110))
    buildRoadSegment(Vector3.new(-30, 0, 110), Vector3.new(-20, 0, 140))
    buildRoadSegment(Vector3.new(-20, 0, 140), Vector3.new(0, 0, 170))
    buildRoadSegment(Vector3.new(0, 0, 60), Vector3.new(30, 0, 80), 14)
    buildRoadSegment(Vector3.new(30, 0, 80), Vector3.new(20, 0, 120), 14)
    buildRoadSegment(Vector3.new(20, 0, 120), Vector3.new(0, 0, 170), 14)
    buildRoadSegment(Vector3.new(0, 0, 170), Vector3.new(0, 0, 200))
    buildRoadSegment(Vector3.new(0, 0, 200), Vector3.new(0, 0, 230))
    buildRoadSegment(Vector3.new(0, 0, 230), Vector3.new(0, 0, 270))

    -- 3. Tugu Monas (Finish)
    local monasFolder = Instance.new("Folder")
    monasFolder.Name = "Landmark_Monas"
    monasFolder.Parent = envFolder
    local monasCenter = Vector3.new(0, 1, 280)
    makePart(monasFolder, "MonasPlaza", Vector3.new(90, 2, 90), CFrame.new(monasCenter), Color3.fromRGB(220, 225, 230), Enum.Material.Cobblestone)
    makePart(monasFolder, "MonasBaseLevel1", Vector3.new(54, 6, 54), CFrame.new(monasCenter + Vector3.new(0, 4, 0)), Color3.fromRGB(235, 238, 240), Enum.Material.Concrete)
    makePart(monasFolder, "MonasCawan", Vector3.new(40, 5, 40), CFrame.new(monasCenter + Vector3.new(0, 9.5, 0)), Color3.fromRGB(240, 242, 245), Enum.Material.Concrete)
    makePart(monasFolder, "MonasSpire", Vector3.new(10, 85, 10), CFrame.new(monasCenter + Vector3.new(0, 54.5, 0)), Color3.fromRGB(245, 245, 248), Enum.Material.SmoothPlastic)
    makePart(monasFolder, "MonasTopDeck", Vector3.new(16, 4, 16), CFrame.new(monasCenter + Vector3.new(0, 98, 0)), Color3.fromRGB(230, 232, 235), Enum.Material.Concrete)
    local flame = makePart(monasFolder, "MonasFlame", Vector3.new(8, 16, 8), CFrame.new(monasCenter + Vector3.new(0, 108, 0)), Color3.fromRGB(255, 215, 0), Enum.Material.Neon)
    local flameLight = Instance.new("PointLight")
    flameLight.Color = Color3.fromRGB(255, 200, 50)
    flameLight.Range = 60
    flameLight.Brightness = 4
    flameLight.Parent = flame

    -- 4. Stasiun Gambir & Executive Train (Start)
    local gambirFolder = Instance.new("Folder")
    gambirFolder.Name = "Landmark_StasiunGambir"
    gambirFolder.Parent = envFolder
    local stationPos = Vector3.new(-32, 1, 0)
    makePart(gambirFolder, "Platform", Vector3.new(20, 4, 70), CFrame.new(stationPos + Vector3.new(0, 2, 0)), Color3.fromRGB(150, 155, 160), Enum.Material.Concrete)
    for z = -25, 25, 15 do
        makePart(gambirFolder, "Pillar", Vector3.new(1.5, 14, 1.5), CFrame.new(stationPos + Vector3.new(-8, 9, z)), Color3.fromRGB(60, 65, 70), Enum.Material.Metal)
        makePart(gambirFolder, "Pillar", Vector3.new(1.5, 14, 1.5), CFrame.new(stationPos + Vector3.new(8, 9, z)), Color3.fromRGB(60, 65, 70), Enum.Material.Metal)
    end
    makePart(gambirFolder, "StationCanopy", Vector3.new(24, 1, 72), CFrame.new(stationPos + Vector3.new(0, 16, 0)), Color3.fromRGB(30, 41, 59), Enum.Material.SmoothPlastic)
    local trackX = stationPos.X - 14
    makePart(gambirFolder, "GravelBed", Vector3.new(14, 1, 90), CFrame.new(trackX, 1, stationPos.Z), Color3.fromRGB(90, 85, 80), Enum.Material.Cobblestone)
    for z = -40, 40, 4 do
        makePart(gambirFolder, "WoodenTie", Vector3.new(10, 0.8, 1.5), CFrame.new(trackX, 1.6, z), Color3.fromRGB(75, 50, 30), Enum.Material.Wood)
    end
    makePart(gambirFolder, "RailLeft", Vector3.new(0.6, 1, 90), CFrame.new(trackX - 3.5, 2.2, stationPos.Z), Color3.fromRGB(180, 185, 190), Enum.Material.Metal)
    makePart(gambirFolder, "RailRight", Vector3.new(0.6, 1, 90), CFrame.new(trackX + 3.5, 2.2, stationPos.Z), Color3.fromRGB(180, 185, 190), Enum.Material.Metal)
    makePart(gambirFolder, "TrainCarriage", Vector3.new(9, 10, 45), CFrame.new(trackX, 7.8, stationPos.Z - 5), Color3.fromRGB(240, 242, 245), Enum.Material.SmoothPlastic)
    makePart(gambirFolder, "TrainStripeBlue", Vector3.new(9.2, 1.2, 45), CFrame.new(trackX, 8, stationPos.Z - 5), Color3.fromRGB(30, 64, 175), Enum.Material.SmoothPlastic)
    makePart(gambirFolder, "TrainStripeOrange", Vector3.new(9.2, 0.6, 45), CFrame.new(trackX, 9, stationPos.Z - 5), Color3.fromRGB(249, 115, 22), Enum.Material.SmoothPlastic)

    -- 5. Sudirman District (Skyscrapers & Bank)
    local sudirmanFolder = Instance.new("Folder")
    sudirmanFolder.Name = "District_Sudirman"
    sudirmanFolder.Parent = envFolder
    makePart(sudirmanFolder, "SudirmanTower1", Vector3.new(35, 120, 35), CFrame.new(-65, 60, 95), Color3.fromRGB(30, 58, 138), Enum.Material.Glass)
    for floorY = 15, 110, 12 do
        makePart(sudirmanFolder, "WindowBand", Vector3.new(35.5, 2, 35.5), CFrame.new(-65, floorY, 95), Color3.fromRGB(241, 245, 249), Enum.Material.Neon)
    end
    makePart(sudirmanFolder, "SudirmanTower2", Vector3.new(32, 90, 32), CFrame.new(-60, 45, 135), Color3.fromRGB(51, 65, 85), Enum.Material.Concrete)
    local bankPos = Vector3.new(-48, 0, 78)
    makePart(sudirmanFolder, "BankMainBuilding", Vector3.new(22, 16, 20), CFrame.new(bankPos + Vector3.new(0, 8, 0)), Color3.fromRGB(226, 232, 240), Enum.Material.Concrete)
    makePart(sudirmanFolder, "BankRoof", Vector3.new(24, 4, 22), CFrame.new(bankPos + Vector3.new(0, 18, 0)), Color3.fromRGB(15, 23, 42), Enum.Material.Concrete)
    for x = -8, 8, 5 do
        makePart(sudirmanFolder, "BankPillar", Vector3.new(2, 14, 2), CFrame.new(bankPos + Vector3.new(x, 7, 11)), Color3.fromRGB(255, 255, 255), Enum.Material.Marble)
    end
    makePart(sudirmanFolder, "ATMSign", Vector3.new(6, 3, 1), CFrame.new(bankPos + Vector3.new(0, 14, 11.5)), Color3.fromRGB(59, 130, 246), Enum.Material.Neon)

    -- 6. Gang Senggol (Warung Madura, Warkop, Pos Ronda)
    local gangFolder = Instance.new("Folder")
    gangFolder.Name = "District_GangSenggol"
    gangFolder.Parent = envFolder
    local wmPos = Vector3.new(46, 0, 80)
    makePart(gangFolder, "WarungMaduraBuilding", Vector3.new(14, 10, 14), CFrame.new(wmPos + Vector3.new(0, 5, 0)), Color3.fromRGB(245, 158, 11), Enum.Material.Wood)
    makePart(gangFolder, "AwningRed", Vector3.new(15, 1, 6), CFrame.new(wmPos + Vector3.new(0, 9, -8)) * CFrame.Angles(math.rad(25), 0, 0), Color3.fromRGB(220, 38, 38), Enum.Material.SmoothPlastic)
    makePart(gangFolder, "AwningWhite", Vector3.new(15, 1.1, 2), CFrame.new(wmPos + Vector3.new(0, 9, -8)) * CFrame.Angles(math.rad(25), 0, 0), Color3.fromRGB(255, 255, 255), Enum.Material.SmoothPlastic)
    for gx = -3, 3, 2.5 do
        makePart(gangFolder, "Gas3KG", Vector3.new(1.8, 2.2, 1.8), CFrame.new(wmPos + Vector3.new(gx, 1.1, -8)), Color3.fromRGB(34, 197, 94), Enum.Material.SmoothPlastic)
    end
    local prPos = Vector3.new(35, 0, 120)
    makePart(gangFolder, "PosPillar1", Vector3.new(1.2, 9, 1.2), CFrame.new(prPos + Vector3.new(-5, 4.5, -5)), Color3.fromRGB(180, 140, 90), Enum.Material.Wood)
    makePart(gangFolder, "PosPillar2", Vector3.new(1.2, 9, 1.2), CFrame.new(prPos + Vector3.new(5, 4.5, -5)), Color3.fromRGB(180, 140, 90), Enum.Material.Wood)
    makePart(gangFolder, "PosPillar3", Vector3.new(1.2, 9, 1.2), CFrame.new(prPos + Vector3.new(-5, 4.5, 5)), Color3.fromRGB(180, 140, 90), Enum.Material.Wood)
    makePart(gangFolder, "PosPillar4", Vector3.new(1.2, 9, 1.2), CFrame.new(prPos + Vector3.new(5, 4.5, 5)), Color3.fromRGB(180, 140, 90), Enum.Material.Wood)
    makePart(gangFolder, "PosDeck", Vector3.new(12, 1.5, 12), CFrame.new(prPos + Vector3.new(0, 2, 0)), Color3.fromRGB(160, 120, 70), Enum.Material.WoodPlanks)
    makePart(gangFolder, "PosRoof", Vector3.new(14, 3, 14), CFrame.new(prPos + Vector3.new(0, 10, 0)), Color3.fromRGB(180, 83, 9), Enum.Material.Wood)
    makePart(gangFolder, "Kentongan", Vector3.new(1, 4, 1), CFrame.new(prPos + Vector3.new(4, 7, 0)), Color3.fromRGB(115, 65, 30), Enum.Material.Wood)

    envFolder.Parent = Workspace
    return envFolder
end

return EnvironmentService
