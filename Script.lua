-- CRACK BY LVZZ ULTRA OPTIMIZED + AI PEEK V6

-- ========== СЕРВИСЫ ==========
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Light = game:GetService("Lighting")
local Plrs = game:GetService("Players")
local WS = game:GetService("Workspace")
local HTTP = game:GetService("HttpService")
local TS = game:GetService("TextService")
local TweenS = game:GetService("TweenService")
local LP = Plrs.LocalPlayer

-- ========== КОНСТАНТЫ ==========
local FLOOR, CLAMP, TICK = math.floor, math.clamp, tick
local V3, V3_ZERO = Vector3.new, Vector3.zero
local COS, SIN, RAD = math.cos, math.sin, math.rad
local MAX, MIN, CEIL = math.max, math.min, math.ceil
local HUGE, ABS, SQRT = math.huge, math.abs, math.sqrt
local CF, CF_ANG = CFrame.new, CFrame.Angles
local PAIRS, IPAIRS, TYPE = pairs, ipairs, typeof
local RANDOM = math.random
local INSERT = table.insert
local FORMAT = string.format

local FD_DIST = 200
local PLAYER_CACHE_INTERVAL = 0.15  -- Было 0.4, ускорено для лучшей реакции
local AP_SHOOT_DELAY = 0.05
local AP_GROUND_OFFSET = 2.8

-- ========== THEME ==========
local T = {
    Main = Color3.fromRGB(12, 12, 12),
    Group = Color3.fromRGB(19, 19, 19),
    Stroke = Color3.fromRGB(45, 45, 45),
    Accent = Color3.fromRGB(168, 247, 50),
    Text = Color3.fromRGB(220, 220, 220),
    Dim = Color3.fromRGB(140, 140, 140),
    Font = Enum.Font.Code,
    Dark = Color3.fromRGB(25, 25, 25),
    Darker = Color3.fromRGB(20, 20, 20),
    Border = Color3.fromRGB(60, 60, 60)
}

-- ========== CONFIG ==========
local Cfg = {
    Folder = "Crack By Lvzz",
    List = {},
    Selected = "",
    FS = (writefile and readfile and isfile and listfiles and makefolder and isfolder) ~= nil
}


-- ========== SETTINGS ==========
local S = {
    menuKey = Enum.KeyCode.Delete,
    rbEnabled = false, rbResolver = false, rbPrediction = true, rbTeamCheck = true,
    rbAutoFire = true, rbHitbox = "Head", rbMaxDist = 500, rbFireRate = 0.1,
    rbPredMulti = 1.0, rbNoAir = true, rbWallCheck = true, rbSmartAim = true,
    rbAirShoot = false, rbAirShootKey = Enum.KeyCode.H,
    btEnabled = true, btTime = 500,
    dtEnabled = false, dtKey = Enum.KeyCode.E, dtDist = 6, dtMode = "Defensive",
    fdEnabled = false, fdTeamCheck = true, fdKey = Enum.KeyCode.X, fdLockKey = Enum.KeyCode.V,
    epEnabled = false, epKey = Enum.KeyCode.C, epDist = 3,
    ijEnabled = false, ijKey = Enum.KeyCode.Space,
    beEnabled = false, beKey = Enum.KeyCode.G, beMode = "Hold", beDist = 5,
    avEnabled = false,
    apEnabled = false, apKey = Enum.KeyCode.LeftAlt, apMode = "Hold",
    apShowPoints = false, apTeamCheck = true, apESP = false,
    apHeight = 2.0, apSpeed = 500, apRange = 80, apPeekDist = 8,
    apRings = 3, apPointsPerRing = 12, apRingSpacing = 3, apRandomOffset = 0.3,
    apWeightDist = 1.0, apWeightEnemy = 0.8, apWeightCover = 2.5,
    apWeightAngle = 2.0, apWeightHeight = 1.2,
    bhEnabled = false, bhKey = Enum.KeyCode.F, bhGroundSpeed = 35, bhAirSpeed = 39,
    wbEnabled = false, wmEnabled = false, rcEnabled = false,
    tpEnabled = false, tpCTKey = Enum.KeyCode.One, tpTKey = Enum.KeyCode.Two,
    wmVisible = true, hkVisible = true, timeVisible = true,
    hlEnabled = true, hlMaxLogs = 8,
    killEffects = true, killParticleType = "Binary",
    killScreenType = "CS:GO", killScreenDuration = 0.5, killScreenColor = "Red",  -- Расширено до 5 сек
    ghostEffectEnabled = true, ghostColor = Color3.fromRGB(100, 200, 255),
    scopeEnabled = false, scopeColor = Color3.fromRGB(255, 50, 50), scopeSize = 15, scopeGap = 5, scopeThickness = 1, scopeOffsetY = -36,
    bloomEnabled = false, bloomIntensity = 1.5, bloomSize = 40, bloomThreshold = 0.9,
    blurEnabled = false, blurSize = 10,
    colorEnabled = false, ccBrightness = 0, ccContrast = 0.1, ccSaturation = 0.2,
    ccTintColor = Color3.new(1, 1, 1),
    sunRaysEnabled = false, sunRaysIntensity = 0.1, sunRaysSpread = 0.5,
    fogEnabled = false, fogStart = 0, fogEnd = 500, fogColor = Color3.new(0.5, 0.5, 0.5),
    selectedModel = "None"
}

-- ========== RUNTIME ==========
local R = {
    gui = nil, main = nil, hkFrame = nil, wmFrame = nil, timeFrame = nil, hlFrame = nil, visible = true,
    drag = false, dragStart = nil, startPos = nil,
    conns = {}, fx = {}, hotkeys = {}, hitLogs = {},
    cfgDropdown = nil, cfgDropdownList = nil,
    fdTarget = nil, fdCrouch = false, fdLock = false, fdIdleAnim = nil, fdWalkAnim = nil,
    bloomEffect = nil, blurEffect = nil, colorEffect = nil, sunRaysEffect = nil,
    rbLast = 0, rbAirPart = nil, asCanJump = true,
    epDecoy = nil, epActive = false, epOriginalPos = nil, epOriginalNeckC0 = nil, epHealthConn = nil,
    ijPart = nil, ijCanJump = true,
    beActive = false, beDecoy = nil, beUpdateConn = nil,
    avLine = nil, dtLastPeek = 0,
    apActive = false, apTeleporting = false, apPoints = {}, apPointCount = 0,
    mainConn = nil, running = true, sliderDrag = nil,
    bhOrigSpeed = 16, bhInAir = false, bhLastReset = 0, bhResetting = false,
    bhLastPos = nil, bhPosCheckTime = 0, bhCircling = false,
    myChar = nil, myHRP = nil, myHead = nil, myHum = nil,
    fireShot = nil, fireShotTime = 0,
    playerData = {}, playerDataTime = 0, cam = nil
}

-- ========== RAYCAST PARAMS ==========
local RayP = RaycastParams.new()
RayP.FilterType = Enum.RaycastFilterType.Exclude

local APRayP = RaycastParams.new()
APRayP.FilterType = Enum.RaycastFilterType.Exclude

-- ========== FORWARD DECLARATIONS ==========
local UpdateHotkeyList, ApplySettings, teleportTo, TrackShot, AddHitLog, SetupKillTracking

-- ========== CACHES ==========
local wallbangCache, collisionCache, wallbangMapCache = {}, {}, {}
local apESPCache, apLastUpdate = {}, 0
local apLastPeekTime = 0


-- ========== WALLBANG DATA ==========
local wallbangWalls = {
    {n = "hamik", p = V3(97.46, 36.63, -2.82)}, {n = "hamik", p = V3(97.46, 36.63, 0.46)},
    {n = "hamik", p = V3(97.46, 36.65, -1.18)}, {n = "hamik", p = V3(97.20, 38.47, -1.18)},
    {n = "hamik", p = V3(96.52, 41.89, -1.18)}, {n = "hamik", p = V3(98.34, 41.89, -1.18)},
    {n = "hamik", p = V3(97.46, 34.80, -1.18)}, {n = "hamik", p = V3(152.46, 35.57, -6.88)},
    {n = "hamik", p = V3(150.34, 33.86, 134.91)}, {n = "hamik", p = V3(153.05, 33.91, 134.90)},
    {n = "hamik", p = V3(151.95, 33.74, 134.93)}, {n = "hamik", p = V3(161.36, 40.47, 153.08)},
    {n = "hamik", p = V3(108.23, 34.15, 94.53)}, {n = "hamik", p = V3(108.73, 38.13, 93.78)},
    {n = "hamik", p = V3(71.21, 37.96, -18.74)}, {n = "hamik", p = V3(71.21, 43.09, -18.96)},
    {n = "Part", p = V3(96.63, 41.21, -3.74)}, {n = "Part", p = V3(96.63, 41.21, 1.38)},
    {n = "Part", p = V3(205.19, 38.08, 187.89)}, {n = "Part", p = V3(209.46, 30.75, 180.54)},
    {n = "Part", p = V3(153.66, 33.63, 135.62)}, {n = "Part", p = V3(149.04, 33.91, 135.60)},
    {n = "Part", p = V3(108.23, 30.38, 83.15)}, {n = "Part", p = V3(108.23, 38.33, 72.24)},
    {n = "Part", p = V3(108.23, 43.15, 88.36)}, {n = "Part", p = V3(108.74, 38.13, 72.24)},
    {n = "Part", p = V3(108.73, 42.61, 83.07)}, {n = "Part", p = V3(108.73, 30.48, 83.07)},
    {n = "Part", p = V3(109.42, 30.04, 93.90)}, {n = "Part", p = V3(88.31, 34.68, 122.17)},
    {n = "Part", p = V3(87.91, 31.80, 122.17)}, {n = "Part", p = V3(87.28, 33.18, 118.75)},
    {n = "Part", p = V3(87.28, 33.18, 120.63)}, {n = "Part", p = V3(88.31, 34.68, 98.91)},
    {n = "Part", p = V3(87.91, 32.32, 100.28)}, {n = "Part", p = V3(65.08, 31.62, 91.62)},
    {n = "Part", p = V3(127.95, 46.97, 0.99)}, {n = "Part", p = V3(67.02, 37.96, -18.74)},
    {n = "paletka", p = V3(61.81, 35.08, 90.42)}, {n = "paletka", p = V3(61.81, 39.58, 91.62)},
    {n = "paletka", p = V3(143.97, 32.34, 199.64)}, {n = "paletka", p = V3(141.99, 32.43, 200.56)},
    {n = "paletka", p = V3(139.40, 32.34, 198.31)}, {n = "paletka", p = V3(142.04, 32.34, 203.99)},
    {n = "paletka", p = V3(145.88, 32.43, 198.74)}, {n = "paletka", p = V3(148.51, 32.34, 200.97)},
    {n = "paletka", p = V3(145.86, 32.34, 195.29)}, {n = "paletka", p = V3(143.96, 36.87, 199.64)},
    {n = "paletka", p = V3(143.97, 27.64, 199.64)}, {n = "nowallbang1", p = V3(67.38, 43.09, -18.96)},
}

-- ========== UTILITY FUNCTIONS ==========
local function CacheChar()
    local c = LP.Character
    if c then
        R.myChar, R.myHRP = c, c:FindFirstChild("HumanoidRootPart")
        R.myHead, R.myHum = c:FindFirstChild("Head"), c:FindFirstChildOfClass("Humanoid")
    else
        R.myChar, R.myHRP, R.myHead, R.myHum = nil, nil, nil, nil
    end
    R.cam = WS.CurrentCamera
end

local function GetFireShot()
    local now = TICK()
    if R.fireShot and R.fireShot.Parent and now - R.fireShotTime < 5 then return R.fireShot end
    if not R.myChar then return nil end

    for _, child in IPAIRS(R.myChar:GetChildren()) do
        if child:IsA("Tool") then
            local remotes = child:FindFirstChild("Remotes")
            if remotes then
                local fs = remotes:FindFirstChild("FireShot") or remotes:FindFirstChild("fireShot")
                if fs then R.fireShot, R.fireShotTime = fs, now return fs end
            end
        end
    end
    return nil
end

local function UpdatePlayerData()
    local now = TICK()
    if now - R.playerDataTime < PLAYER_CACHE_INTERVAL then return end
    R.playerDataTime = now

    local count = 0
    if not R.myHRP then 
        for k in PAIRS(R.playerData) do R.playerData[k] = nil end
        return 
    end

    local myPos, myTeam, myColor = R.myHRP.Position, LP.Team, LP.TeamColor
    local players = Plrs:GetPlayers()
    local numPlayers = #players

    for i = 1, numPlayers do
        local p = players[i]
        if p ~= LP then
            local c = p.Character
            if c then
                local r = c:FindFirstChild("HumanoidRootPart")
                if r then
                    local h = c:FindFirstChildOfClass("Humanoid")
                    if h and h.Health > 0 then
                        local dist = (myPos - r.Position).Magnitude
                        if dist < 500 then
                            count = count + 1
                            local data = R.playerData[count]
                            if not data then
                                data = {}
                                R.playerData[count] = data
                            end
                            data.p = p
                            data.c = c
                            data.h = h
                            data.r = r
                            data.head = c:FindFirstChild("Head")
                            data.torso = c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso")
                            data.dist = dist
                            data.team = myTeam and (p.Team == myTeam or p.TeamColor == myColor)
                        end
                    end
                end
            end
        end
    end

    for i = count + 1, #R.playerData do
        R.playerData[i] = nil
    end

    if count > 1 then
        for i = 1, count - 1 do
            local minIdx = i
            for j = i + 1, count do
                if R.playerData[j].dist < R.playerData[minIdx].dist then
                    minIdx = j
                end
            end
            if minIdx ~= i then
                R.playerData[i], R.playerData[minIdx] = R.playerData[minIdx], R.playerData[i]
            end
        end
    end
end


-- ========== WALLBANG FUNCTIONS ==========
local function findWallObject(name, targetPos)
    local closest, closestDist = nil, HUGE
    for _, obj in IPAIRS(WS:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name == name then
            local dist = (obj.Position - targetPos).Magnitude
            if dist < closestDist then closestDist, closest = dist, obj end
        end
    end
    return closest and closestDist < 5 and closest or nil
end

local function enableWallbangHelper()
    wallbangCache = {}
    for i, data in IPAIRS(wallbangWalls) do
        local obj = findWallObject(data.n, data.p)
        if obj then
            wallbangCache[i] = {obj = obj, orig = obj.Transparency}
            obj.Transparency = 0.8
        end
    end
end

local function disableWallbangHelper()
    for _, c in PAIRS(wallbangCache) do
        if c and c.obj and c.obj.Parent then pcall(function() c.obj.Transparency = c.orig end) end
    end
    wallbangCache = {}
end

local function enableRemoveCollision()
    collisionCache = {}
    local map = WS:FindFirstChild("Map")
    if not map then return end

    local folders = {map:FindFirstChild("Clips"), map:FindFirstChild("Doors"), map:FindFirstChild("Ignore")}
    for _, folder in IPAIRS(folders) do
        if folder then
            for _, obj in IPAIRS(folder:GetDescendants()) do
                if obj:IsA("BasePart") then
                    INSERT(collisionCache, {obj = obj, col = obj.CanCollide, tr = obj.Transparency})
                    obj.CanCollide, obj.Transparency = false, 1
                end
            end
        end
    end
end

local function disableRemoveCollision()
    for _, c in PAIRS(collisionCache) do
        if c and c.obj and c.obj.Parent then
            pcall(function() c.obj.CanCollide, c.obj.Transparency = c.col, c.tr end)
        end
    end
    collisionCache = {}
end

local function enableWallbangMap()
    wallbangMapCache = {}
    local map = WS:FindFirstChild("Map")
    local geometry = map and map:FindFirstChild("Geometry")
    if not geometry then return end

    for _, obj in IPAIRS(geometry:GetDescendants()) do
        if obj:IsA("BasePart") then
            INSERT(wallbangMapCache, {obj = obj, orig = obj.Transparency})
            obj.Transparency = 0.5
        end
    end
end

local function disableWallbangMap()
    for _, c in PAIRS(wallbangMapCache) do
        if c and c.obj and c.obj.Parent then pcall(function() c.obj.Transparency = c.orig end) end
    end
    wallbangMapCache = {}
end


-- ========== AI PEEK V6 - OPTIMIZED ==========

local function AP_SpeedToCooldown()
    local speed = S.apSpeed
    if speed <= 333 then
        return 0.6 - (speed / 333) * 0.3
    elseif speed <= 666 then
        return 0.3 - ((speed - 333) / 333) * 0.18
    else
        return 0.12 - ((speed - 666) / 334) * 0.08
    end
end

local function AP_GetCooldownMs()
    return FLOOR(AP_SpeedToCooldown() * 1000)
end

local function AP_GetSpeedMode()
    local speed = S.apSpeed
    if speed <= 333 then return "Slow"
    elseif speed <= 666 then return "Medium"
    else return "Fast" end
end

local function AP_ClearESP()
    for _, hl in PAIRS(apESPCache) do
        pcall(function() hl:Destroy() end)
    end
    apESPCache = {}
end

local function AP_CanSee(from, to, ignore)
    APRayP.FilterDescendantsInstances = ignore
    local r = WS:Raycast(from, to - from, APRayP)
    return not r or not r.Instance.CanCollide
end

local function AP_GetGround(pos, char, baseY)
    APRayP.FilterDescendantsInstances = {char}
    local r = WS:Raycast(pos + V3(0, 6, 0), V3(0, -18, 0), APRayP)
    if r then
        local gy = r.Position.Y + 0.3
        local maxH = S.apHeight
        local diff = gy - baseY
        if diff > maxH then gy = baseY + maxH
        elseif diff < -maxH then gy = baseY - maxH end
        return gy, true
    end
    return baseY, false
end

local function AP_ValidateHeight(startY, endY)
    local maxH = S.apHeight
    local diff = endY - startY
    if diff > maxH then return startY + maxH end
    if diff < -maxH then return startY - maxH end
    return endY
end

local function AP_CanReach(from, to, char)
    APRayP.FilterDescendantsInstances = {char}
    for _, h in IPAIRS({1, 2, 3}) do
        local s = from + V3(0, h, 0)
        local e = to + V3(0, h, 0)
        local r = WS:Raycast(s, e - s, APRayP)
        if r and r.Instance.CanCollide then return false end
    end
    return true
end

local function AP_EnemySeesPoint(enemyRoot, pointPos, myChar, enemyChar)
    APRayP.FilterDescendantsInstances = {myChar, enemyChar}
    local enemyEye = enemyRoot.Position + V3(0, 1.5, 0)

    for _, h in IPAIRS({1, 2.5}) do
        local target = pointPos + V3(0, h, 0)
        local result = WS:Raycast(enemyEye, target - enemyEye, APRayP)
        if not result or not result.Instance.CanCollide then return true end
    end
    return false
end

local function AP_CanShootFrom(pointPos, enemyHead, myChar, enemyChar)
    if not enemyHead then return false end
    return AP_CanSee(pointPos + V3(0, 1.6, 0), enemyHead.Position, {myChar, enemyChar})
end

local function AP_EnemyVisible(myRoot, myChar, enemyChar)
    local head = enemyChar:FindFirstChild("Head")
    local torso = enemyChar:FindFirstChild("UpperTorso") or enemyChar:FindFirstChild("Torso")
    local eye = myRoot.Position + V3(0, 1.6, 0)
    local ignore = {myChar, enemyChar}
    return (head and AP_CanSee(eye, head.Position, ignore)) or
           (torso and AP_CanSee(eye, torso.Position, ignore))
end

local function AP_CanPeekPlayer(myRoot, myChar, targetChar)
    local targetHead = targetChar:FindFirstChild("Head")
    if not targetHead then return false end

    for i = 1, R.apPointCount do
        local pt = R.apPoints[i]
        if pt and pt.canReach then
            APRayP.FilterDescendantsInstances = {myChar, targetChar}
            local eyePos = pt.pos + V3(0, 1.6, 0)
            local r = WS:Raycast(eyePos, targetHead.Position - eyePos, APRayP)
            if not r or not r.Instance.CanCollide then return true end
        end
    end
    return false
end

local function AP_UpdateESP()
    if not S.apESP or not R.apActive then AP_ClearESP() return end

    local char, root = LP.Character, R.myHRP
    if not char or not root then return end

    local myTeam, myColor = LP.Team, LP.TeamColor
    local processed = {}

    for _, p in IPAIRS(Plrs:GetPlayers()) do
        if p == LP then continue end
        if S.apTeamCheck and myTeam and (p.Team == myTeam or p.TeamColor == myColor) then continue end
        
        local c = p.Character
        if not c then continue end
        
        local h = c:FindFirstChildOfClass("Humanoid")
        if not h or h.Health <= 0 then continue end
        
        processed[p.UserId] = true
        local canPeek = AP_CanPeekPlayer(root, char, c)
        local existing = apESPCache[p.UserId]
        
        if existing and existing.Parent then
            local col = canPeek and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            existing.OutlineColor = col
            existing.FillColor = col
        else
            local hl = Instance.new("Highlight")
            hl.Name = "AP_ESP"
            hl.Adornee = c
            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            hl.FillTransparency = 0.85
            hl.OutlineTransparency = 0
            local col = canPeek and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
            hl.OutlineColor = col
            hl.FillColor = col
            hl.Parent = c
            apESPCache[p.UserId] = hl
        end
    end

    for id, hl in PAIRS(apESPCache) do
        if not processed[id] then 
            pcall(function() hl:Destroy() end) 
            apESPCache[id] = nil 
        end
    end
end


local function AP_CreatePoints()
    for i = 1, #R.apPoints do
        if R.apPoints[i] and R.apPoints[i].part then
            R.apPoints[i].part:Destroy()
        end
        R.apPoints[i] = nil
    end

    local rings = S.apRings or 3
    local ppr = S.apPointsPerRing or 12
    local ringSpacing = S.apRingSpacing or 3
    local randomOffset = S.apRandomOffset or 0.3
    local baseSpacing = S.apPeekDist / rings
    local idx = 0

    for ring = 1, rings do
        local baseDist = ring * baseSpacing * (ringSpacing / 3)
        for i = 1, ppr do
            idx = idx + 1
            local baseAngle = (i - 1) * (360 / ppr) + (ring * (360 / ppr / 2))
            
            R.apPoints[idx] = {
                ring = ring,
                dist = baseDist + (RANDOM() - 0.5) * 2 * randomOffset,
                angle = baseAngle + (RANDOM() - 0.5) * 20 * randomOffset,
                pos = V3_ZERO,
                groundY = 0,
                canReach = false,
                canShoot = false,
                enemySees = false,
                coverScore = 0,
                angleScore = 0,
                heightAdvantage = 0,
                score = 0,
                part = nil
            }
            
            if S.apShowPoints then
                local p = Instance.new("Part")
                p.Name = "AP_P"
                p.Size = V3(0.5, 0.5, 0.5)
                p.Shape = Enum.PartType.Ball
                p.Anchored = true
                p.CanCollide = false
                p.CastShadow = false
                p.Material = Enum.Material.Neon
                p.Transparency = 0.3
                p.Color = Color3.new(1, 1, 1)
                p.Parent = WS
                R.apPoints[idx].part = p
            end
        end
    end
    R.apPointCount = idx
end

local function AP_RemovePoints()
    for i = 1, #R.apPoints do
        if R.apPoints[i] and R.apPoints[i].part then
            R.apPoints[i].part:Destroy()
        end
        R.apPoints[i] = nil
    end
    R.apPointCount = 0
    AP_ClearESP()
end

local function AP_UpdatePoints(rootPos, char, baseY)
    for i = 1, R.apPointCount do
        local pt = R.apPoints[i]
        if pt then
            local ang = RAD(pt.angle)
            local basePos = rootPos + V3(COS(ang) * pt.dist, 0, SIN(ang) * pt.dist)
            
            pt.groundY = AP_GetGround(basePos, char, baseY)
            pt.pos = V3(basePos.X, pt.groundY, basePos.Z)
            pt.canReach = AP_CanReach(rootPos, pt.pos, char)
            pt.canShoot = false
            pt.enemySees = false
            pt.coverScore = 0
            pt.angleScore = 0
            pt.heightAdvantage = 0
            pt.score = 0
            
            if pt.part then
                pt.part.Position = pt.pos + V3(0, 0.7, 0)
                pt.part.Color = pt.canReach and Color3.new(0.5, 0.5, 0.5) or Color3.fromRGB(90, 30, 30)
                pt.part.Transparency = pt.canReach and 0.4 or 0.7
                pt.part.Size = pt.canReach and V3(0.5, 0.5, 0.5) or V3(0.35, 0.35, 0.35)
            end
        end
    end
end

local function AP_InstantTeleport(root, target, lookDir)
    if not root or not root.Parent then return false end

    local currentVelY = root.AssemblyLinearVelocity.Y
    root.CFrame = CF(target, target + lookDir)
    root.AssemblyLinearVelocity = V3(0, CLAMP(currentVelY, -50, 50), 0)

    return true
end

local coverDirs = {
    V3(1, 0, 0), V3(-1, 0, 0), V3(0, 0, 1), V3(0, 0, -1),
    V3(0.7, 0, 0.7), V3(-0.7, 0, 0.7), V3(0.7, 0, -0.7), V3(-0.7, 0, -0.7)
}

local function AP_FindBest(myRoot, myChar, enemyRoot, enemyChar)
    local enemyHead = enemyChar:FindFirstChild("Head")
    if not enemyHead then return nil end

    local best, bestScore = nil, -999999
    local myPos = myRoot.Position
    local enemyPos = enemyRoot.Position
    local wDist = S.apWeightDist
    local wEnemy = S.apWeightEnemy
    local wCover = S.apWeightCover
    local wAngle = S.apWeightAngle
    local wHeight = S.apWeightHeight

    local toEnemy = (enemyPos - myPos).Unit
    local toEnemyFlat = V3(toEnemy.X, 0, toEnemy.Z).Unit
    local enemyLookFlat = V3(enemyRoot.CFrame.LookVector.X, 0, enemyRoot.CFrame.LookVector.Z).Unit

    APRayP.FilterDescendantsInstances = {myChar, enemyChar}

    for i = 1, R.apPointCount do
        local pt = R.apPoints[i]
        if not pt or not pt.canReach then continue end
        
        pt.canShoot = AP_CanShootFrom(pt.pos, enemyHead, myChar, enemyChar)
        pt.enemySees = AP_EnemySeesPoint(enemyRoot, pt.pos, myChar, enemyChar)
        
        if pt.enemySees and pt.canShoot then
            local distMe = (pt.pos - myPos).Magnitude
            local distEnemy = (pt.pos - enemyPos).Magnitude
            
            pt.score = 1000 - distMe * 8 * wDist - ABS(distEnemy - 15) * 3 * wEnemy
            pt.score = pt.score + (S.apRings - pt.ring + 1) * 30
            
            local toPoint = (pt.pos - myPos).Unit
            local toPointFlat = V3(toPoint.X, 0, toPoint.Z).Unit
            pt.score = pt.score + (1 - ABS(toEnemyFlat:Dot(toPointFlat))) * 100 * wAngle
            
            local coverCount = 0
            for j = 1, 4 do
                local result = WS:Raycast(pt.pos + V3(0, 1, 0), coverDirs[j] * 3, APRayP)
                if result and result.Instance.CanCollide then coverCount = coverCount + 1 end
            end
            pt.score = pt.score + coverCount * 15 * wCover
            
            local toPointFromEnemy = (pt.pos - enemyPos).Unit
            local enemySeesAngle = V3(toPointFromEnemy.X, 0, toPointFromEnemy.Z).Unit:Dot(enemyLookFlat)
            if enemySeesAngle < 0.5 then pt.score = pt.score + 60 end
            if enemySeesAngle < 0 then pt.score = pt.score + 40 end
            
            local heightDiff = pt.pos.Y - enemyPos.Y
            if heightDiff > 1 then
                pt.score = pt.score + MIN(heightDiff, 3) * 20 * wHeight
            end
            
            if pt.score > bestScore then 
                bestScore = pt.score
                best = pt 
            end
        end
    end

    return best
end


local function AP_HasPossiblePath(myRoot, myChar, enemyRoot, enemyChar)
    local enemyHead = enemyChar:FindFirstChild("Head")
    if not enemyHead then return false end

    APRayP.FilterDescendantsInstances = {myChar, enemyChar}
    local myEye = myRoot.Position + V3(0, 1.6, 0)

    if not WS:Raycast(myEye, enemyHead.Position - myEye, APRayP) then 
        return true 
    end

    for i = 1, R.apPointCount do
        local pt = R.apPoints[i]
        if pt and pt.canReach then
            local result = WS:Raycast(
                pt.pos + V3(0, 1.6, 0), 
                enemyHead.Position - (pt.pos + V3(0, 1.6, 0)), 
                APRayP
            )
            if not result or not result.Instance.CanCollide then 
                return true 
            end
        end
    end
    return false
end

local function AP_FindEnemy(myChar, myRoot)
    local best, bestDist, bestChar = nil, S.apRange, nil
    local myTeam, myColor = LP.Team, LP.TeamColor

    for _, p in IPAIRS(Plrs:GetPlayers()) do
        if p ~= LP then
            if S.apTeamCheck and myTeam and (p.Team == myTeam or p.TeamColor == myColor) then continue end
            
            local c = p.Character
            if not c then continue end
            
            local r = c:FindFirstChild("HumanoidRootPart")
            local h = c:FindFirstChildOfClass("Humanoid")
            local head = c:FindFirstChild("Head")
            
            if not r or not h or h.Health <= 0 or not head then continue end
            
            local dist = (r.Position - myRoot.Position).Magnitude
            if dist < bestDist and AP_HasPossiblePath(myRoot, myChar, r, c) then
                bestDist = dist
                best = r
                bestChar = c
            end
        end
    end
    return best, bestChar, bestDist
end

local function AP_DoPeek(root, point, char, enemyRoot, enemyChar)
    if R.apTeleporting then return end

    local cooldown = AP_SpeedToCooldown()
    if TICK() - apLastPeekTime < cooldown then return end

    local enemyHead = enemyChar:FindFirstChild("Head")
    if not AP_CanShootFrom(point.pos, enemyHead, char, enemyChar) then return end

    local enemyHum = enemyChar:FindFirstChildOfClass("Humanoid")
    if not enemyHum or enemyHum.Health <= 0 then return end

    R.apTeleporting = true
    apLastPeekTime = TICK()

    local baseY = root.Position.Y
    local origin = root.CFrame
    local originPos = root.Position
    local look = root.CFrame.LookVector

    local targetY = AP_ValidateHeight(baseY, point.groundY + AP_GROUND_OFFSET)
    local targetPos = V3(point.pos.X, targetY, point.pos.Z)

    if point.part then
        point.part.Color = Color3.fromRGB(255, 0, 255)
        point.part.Size = V3(1.2, 1.2, 1.2)
        point.part.Transparency = 0
    end

    AP_InstantTeleport(root, targetPos, look)

    if root.Parent and enemyRoot.Parent then
        local lookAtEnemy = V3(enemyRoot.Position.X, root.Position.Y, enemyRoot.Position.Z)
        root.CFrame = CF(root.Position, lookAtEnemy)
        root.AssemblyLinearVelocity = V3(0, 0, 0)
    end

    -- Используем task.delay вместо task.wait для неблокирующего возврата
    task.delay(AP_SHOOT_DELAY, function()
        if root and root.Parent then
            AP_InstantTeleport(root, originPos, look)
            root.CFrame = origin
            root.AssemblyLinearVelocity = V3(0, 0, 0)
        end

        if point and point.part then 
            point.part.Size = V3(0.5, 0.5, 0.5) 
        end

        R.apTeleporting = false
    end)
end

local function AP_MainLoop()
    while R.apActive and R.running do
        RS.Heartbeat:Wait()  -- Синхронизация с кадрами вместо task.wait

        if R.apTeleporting then continue end
        
        local char = LP.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        
        if not root or not hum or hum.Health <= 0 then continue end
        
        AP_UpdatePoints(root.Position, char, root.Position.Y)
        
        if TICK() - apLastUpdate > 0.2 then
            apLastUpdate = TICK()
            AP_UpdateESP()
        end
        
        local enemyRoot, enemyChar = AP_FindEnemy(char, root)
        
        if not enemyRoot or not enemyChar then
            for i = 1, R.apPointCount do
                local pt = R.apPoints[i]
                if pt and pt.part then
                    pt.part.Color = pt.canReach and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 40, 40)
                    pt.part.Transparency = pt.canReach and 0.5 or 0.75
                    pt.part.Size = pt.canReach and V3(0.5, 0.5, 0.5) or V3(0.35, 0.35, 0.35)
                end
            end
            continue
        end
        
        if AP_EnemyVisible(root, char, enemyChar) then
            for i = 1, R.apPointCount do
                local pt = R.apPoints[i]
                if pt and pt.part then
                    pt.part.Color = Color3.fromRGB(100, 200, 100)
                    pt.part.Transparency = 0.6
                    pt.part.Size = V3(0.45, 0.45, 0.45)
                end
            end
            continue
        end
        
        local best = AP_FindBest(root, char, enemyRoot, enemyChar)
        if best and best.canShoot then 
            AP_DoPeek(root, best, char, enemyRoot, enemyChar) 
        end
    end

    AP_ClearESP()
end

local function AP_Enable()
    if R.apActive then return end

    local char = LP.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    R.apActive = true
    R.apTeleporting = false
    R.apPointCount = 0
    apLastUpdate = 0
    apLastPeekTime = 0

    AP_CreatePoints()

    R.hotkeys["AI Peek v6"] = {active = true, key = S.apKey and S.apKey.Name or "None"}
    UpdateHotkeyList()

    task.spawn(AP_MainLoop)
end

local function AP_Disable()
    R.apActive = false
    R.apTeleporting = false
    AP_RemovePoints()
    AP_ClearESP()
    R.hotkeys["AI Peek v6"] = nil
    UpdateHotkeyList()
end


-- ========== EXPLOIT POSITION SYSTEM ==========
local function EP_SpawnDecoy()
    if R.epActive or not R.myChar or not R.myHRP or not R.myHum then return end

    R.epActive, R.epOriginalPos = true, R.myHRP.CFrame
    if R.epDecoy then pcall(function() R.epDecoy:Destroy() end) end

    local cam = WS.CurrentCamera
    local camLook = cam and cam.CFrame.LookVector or R.myHRP.CFrame.LookVector
    camLook = V3(camLook.X, 0, camLook.Z).Unit

    R.myHRP.CFrame = CF(R.epOriginalPos.Position + camLook * S.epDist) * CF_ANG(0, math.atan2(-camLook.X, -camLook.Z), 0)

    local newModel = Instance.new("Model")
    newModel.Name, newModel.Parent = "ShadowDecoy", WS
    R.epDecoy = newModel

    for _, obj in IPAIRS(R.myChar:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
            local partClone = obj:Clone()
            partClone.Name, partClone.Parent = obj.Name, R.epDecoy
            partClone.Transparency, partClone.Color = 0.3, Color3.fromRGB(20, 20, 20)
            partClone.CanCollide, partClone.Material, partClone.Anchored = false, Enum.Material.ForceField, false
        end
    end

    local hrpClone = R.myHRP:Clone()
    hrpClone.Name, hrpClone.Anchored, hrpClone.CFrame = "HumanoidRootPart", true, R.epOriginalPos
    hrpClone.Transparency, hrpClone.Color, hrpClone.CanCollide = 0.3, Color3.fromRGB(20, 20, 20), false
    hrpClone.Parent = R.epDecoy

    local hum = Instance.new("Humanoid", R.epDecoy)
    hum.MaxHealth, hum.Health = 0, 0
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

    for _, part in IPAIRS(R.epDecoy:GetChildren()) do
        if part:IsA("BasePart") and part ~= hrpClone then
            local weld = Instance.new("WeldConstraint", hrpClone)
            weld.Part0, weld.Part1 = hrpClone, part
        end
    end

    local torso = R.myChar:FindFirstChild("Torso") or R.myChar:FindFirstChild("UpperTorso")
    if torso then
        local neck = torso:FindFirstChild("Neck")
        if neck and neck:IsA("Motor6D") then
            R.epOriginalNeckC0 = neck.C0
            neck.C0 = neck.C0 * CF(0, -2, 0)
        end
    end

    R.epHealthConn = R.myHum.HealthChanged:Connect(function(health)
        if R.epActive and health < R.myHum.MaxHealth then
            pcall(function() R.myHum.Health = R.myHum.MaxHealth end)
        end
    end)

    R.hotkeys["Exploit Pos"] = {active = true, key = S.epKey.Name}
    UpdateHotkeyList()
end

local function EP_DestroyDecoy()
    if not R.epActive then return end

    if R.epDecoy then pcall(function() R.epDecoy:Destroy() end) R.epDecoy = nil end
    if R.epOriginalPos and R.myHRP then R.myHRP.CFrame = R.epOriginalPos end

    local torso = R.myChar and (R.myChar:FindFirstChild("Torso") or R.myChar:FindFirstChild("UpperTorso"))
    if torso then
        local neck = torso:FindFirstChild("Neck")
        if neck and neck:IsA("Motor6D") and R.epOriginalNeckC0 then neck.C0 = R.epOriginalNeckC0 end
    end

    R.epOriginalNeckC0 = nil
    if R.epHealthConn then R.epHealthConn:Disconnect() R.epHealthConn = nil end
    R.epOriginalPos, R.epActive = nil, false
    R.hotkeys["Exploit Pos"] = nil
    UpdateHotkeyList()
end

local function EP_Free()
    EP_DestroyDecoy()
    if R.myHum then pcall(function() R.myHum.WalkSpeed = 16 end) end
    if R.myHRP then pcall(function() R.myHRP.Anchored = false end) end
end

-- ========== BARREL EXTEND SYSTEM ==========
local function BE_GetHole()
    if not LP.Character then return nil end
    local playerFolder = WS:FindFirstChild(LP.Name)
    if playerFolder then
        local ssg = playerFolder:FindFirstChild("SSG-08")
        if ssg then
            local hole = ssg:FindFirstChild("Hole")
            if hole and hole:IsA("BasePart") then return hole end
        end
    end
    return nil
end

local function BE_Enable()
    if R.beActive or not R.myChar or not R.myHRP then return end

    local hole = BE_GetHole()
    if not hole then return end

    if R.beDecoy then pcall(function() R.beDecoy:Destroy() end) R.beDecoy = nil end

    local decoy = Instance.new("Model")
    decoy.Name, decoy.Parent = "BarrelDecoy", WS
    R.beDecoy = decoy

    local hrpClone = Instance.new("Part", decoy)
    hrpClone.Name, hrpClone.Size = "HumanoidRootPart", V3(2, 2, 1)
    hrpClone.Transparency, hrpClone.Color = 0.3, Color3.fromRGB(20, 20, 20)
    hrpClone.CanCollide, hrpClone.Anchored = false, true
    hrpClone.CFrame = CF(hole.Position)

    local hum = Instance.new("Humanoid", decoy)
    hum.MaxHealth, hum.Health = 0, 0
    hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

    R.beActive = true
    R.hotkeys["Barrel Ext"] = {active = true, key = S.beKey.Name .. " [" .. S.beMode .. "]"}
    UpdateHotkeyList()

    if R.beUpdateConn then R.beUpdateConn:Disconnect() end
    R.beUpdateConn = RS.Heartbeat:Connect(function()
        if R.beActive and R.beDecoy then
            local h = BE_GetHole()
            if h then
                local hrp = R.beDecoy:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = CF(h.Position) end
            end
        end
    end)
end

local function BE_Disable()
    if not R.beActive then return end

    if R.beUpdateConn then R.beUpdateConn:Disconnect() R.beUpdateConn = nil end
    if R.beDecoy then pcall(function() R.beDecoy:Destroy() end) R.beDecoy = nil end

    R.beActive = false
    R.hotkeys["Barrel Ext"] = nil
    UpdateHotkeyList()
end

local function BE_GetShootOrigin(defaultOrigin)
    if not R.beActive then return defaultOrigin end
    local hole = BE_GetHole()
    return hole and hole.Position or defaultOrigin
end


-- ========== AIR SHOOT SYSTEM ==========
local function AS_CreatePart()
    if R.rbAirPart or not R.myHRP then return end

    local part = Instance.new("Part")
    part.Name, part.Size = "AirShootPlatform", V3(4, 0.5, 4)
    part.Anchored, part.CanCollide, part.Transparency = true, true, 1
    part.CFrame, part.Parent = R.myHRP.CFrame * CF(0, -3, 0), WS
    R.rbAirPart = part
end

local function AS_RemovePart()
    if R.rbAirPart then pcall(function() R.rbAirPart:Destroy() end) R.rbAirPart = nil end
end

local function AS_Update()
    if not S.rbAirShoot then
        AS_RemovePart()
        R.asCanJump = true
        if R.myHum then R.myHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end
        return
    end
    if not R.myHRP or not R.myHum then return end

    local state = R.myHum:GetState()
    local isInAir = state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Jumping

    RayP.FilterDescendantsInstances = {R.myChar, R.rbAirPart}
    local onRealGround = WS:Raycast(R.myHRP.Position, V3(0, -4, 0), RayP) ~= nil

    if isInAir or not onRealGround then
        if not R.rbAirPart then AS_CreatePart() end
        if R.rbAirPart then
            R.rbAirPart.CFrame = CF(R.myHRP.Position - V3(0, 3, 0))
            R.rbAirPart.CanCollide, R.rbAirPart.Anchored = true, true
        end
        if not S.ijEnabled then
            R.asCanJump = false
            R.myHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
        end
    else
        AS_RemovePart()
        R.asCanJump = true
        R.myHum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
    end
end

-- ========== INFINITY JUMP SYSTEM ==========
local function IJ_CreatePart()
    if R.ijPart or not R.myHRP then return end

    local part = Instance.new("Part")
    part.Name, part.Size = "InfinityJumpPlatform", V3(4, 0.5, 4)
    part.Anchored, part.CanCollide, part.Transparency = true, true, 1
    part.CFrame, part.Parent = R.myHRP.CFrame * CF(0, -3, 0), WS
    R.ijPart = part
end

local function IJ_RemovePart()
    if R.ijPart then pcall(function() R.ijPart:Destroy() end) R.ijPart = nil end
end

local function IJ_Update()
    if not S.ijEnabled then IJ_RemovePart() return end
    if not R.myHRP or not R.myHum then return end

    local state = R.myHum:GetState()
    local isInAir = state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Jumping

    if isInAir then
        IJ_CreatePart()
        if R.ijPart then R.ijPart.CFrame = R.myHRP.CFrame * CF(0, -3, 0) end
        R.ijCanJump = true
    else
        IJ_RemovePart()
        R.ijCanJump = true
    end
end

-- ========== AIMVIEW SYSTEM ==========
local function AV_CreateLine()
    if R.avLine then pcall(function() R.avLine:Destroy() end) R.avLine = nil end

    local line = Instance.new("Part")
    line.Name, line.Anchored, line.CanCollide = "AimViewLine", true, false
    line.Material, line.Color, line.Transparency = Enum.Material.Neon, Color3.fromRGB(255, 0, 0), 0.3
    line.Parent = WS
    R.avLine = line
end

local function AV_RemoveLine()
    if R.avLine then pcall(function() R.avLine:Destroy() end) R.avLine = nil end
end

local function AV_Update(targetPos, fromPos)
    if not S.avEnabled or not targetPos then AV_RemoveLine() return end

    if not R.avLine or not R.avLine.Parent then AV_CreateLine() end
    if not R.avLine then return end

    local startPos = fromPos or (R.myHRP and (R.myHRP.Position + R.myHRP.CFrame.LookVector * 1))
    if not startPos then AV_RemoveLine() return end

    local distance = (targetPos - startPos).Magnitude
    local midPoint = (startPos + targetPos) / 2

    R.avLine.Size = V3(0.1, 0.1, distance)
    R.avLine.CFrame = CFrame.lookAt(midPoint, targetPos)
end

-- ========== DOUBLE TAP SYSTEM ==========
local DT_DIRECTIONS = {
    Forward = V3(0, 0, -1), Back = V3(0, 0, 1),
    Left = V3(-1, 0, 0), Right = V3(1, 0, 0)
}

local function DT_Peek(direction)
    if not R.myHRP or not R.myChar or not R.myHum then return end

    local cam = WS.CurrentCamera
    if not cam then return end

    local myPos, origCF = R.myHRP.Position, R.myHRP.CFrame
    RayP.FilterDescendantsInstances = {R.myChar}

    if S.dtMode == "Off" or S.dtMode == "Defensive" then
        if TICK() - R.dtLastPeek < 5 then return end
        
        local moveDir = R.myHum.MoveDirection
        if moveDir.Magnitude < 0.1 then return end
        
        moveDir = V3(moveDir.X, 0, moveDir.Z).Unit
        if WS:Raycast(myPos, moveDir * S.dtDist, RayP) then return end
        
        R.myHRP.CFrame = CF(myPos + moveDir * S.dtDist) * origCF.Rotation
        R.dtLastPeek = TICK()
    else
        if TICK() - R.dtLastPeek < 0.3 then return end
        
        local dirVec = DT_DIRECTIONS[direction]
        if not dirVec then return end
        
        local worldDir = cam.CFrame:VectorToWorldSpace(dirVec)
        worldDir = V3(worldDir.X, 0, worldDir.Z).Unit
        
        if WS:Raycast(myPos, worldDir * S.dtDist, RayP) then return end
        
        R.myHRP.CFrame = CF(myPos + worldDir * S.dtDist) * origCF.Rotation
        R.dtLastPeek = TICK()
        
        -- Неблокирующая стрельба и возврат
        task.delay(0.05, function()
            local fs = GetFireShot()
            if fs and R.myHead then
                for i = 1, 4 do
                    local d = R.playerData[i]
                    if d and not d.team and d.dist < 200 then
                        local tgt = S.rbHitbox == "Head" and d.head or d.torso or d.r
                        if tgt then
                            RayP.FilterDescendantsInstances = {R.myChar}
                            local res = WS:Raycast(R.myHead.Position, tgt.Position - R.myHead.Position, RayP)
                            if not res or res.Instance:IsDescendantOf(d.c) then
                                pcall(fs.FireServer, fs, R.myHead.Position, (tgt.Position - R.myHead.Position).Unit, tgt)
                                break
                            end
                        end
                    end
                end
            end
            
            task.delay(0.1, function()
                if R.myHRP and R.myHRP.Parent then R.myHRP.CFrame = origCF end
            end)
        end)
    end
end


-- ========== VISUAL EFFECTS ==========
local function ApplyBloom()
    if R.bloomEffect then pcall(function() R.bloomEffect:Destroy() end) R.bloomEffect = nil end
    if S.bloomEnabled then
        local bloom = Instance.new("BloomEffect")
        bloom.Intensity, bloom.Size, bloom.Threshold = S.bloomIntensity, S.bloomSize, S.bloomThreshold
        bloom.Parent = Light
        R.bloomEffect = bloom
    end
end

local function ApplyBlur()
    if R.blurEffect then pcall(function() R.blurEffect:Destroy() end) R.blurEffect = nil end
    if S.blurEnabled then
        local blur = Instance.new("BlurEffect")
        blur.Size = S.blurSize
        blur.Parent = Light
        R.blurEffect = blur
    end
end

local function ApplyColorCorrection()
    if R.colorEffect then pcall(function() R.colorEffect:Destroy() end) R.colorEffect = nil end
    if S.colorEnabled then
        local cc = Instance.new("ColorCorrectionEffect")
        cc.Brightness, cc.Contrast, cc.Saturation = S.ccBrightness, S.ccContrast, S.ccSaturation
        cc.TintColor = S.ccTintColor
        cc.Parent = Light
        R.colorEffect = cc
    end
end

local function ApplySunRays()
    if R.sunRaysEffect then pcall(function() R.sunRaysEffect:Destroy() end) R.sunRaysEffect = nil end
    if S.sunRaysEnabled then
        local sr = Instance.new("SunRaysEffect")
        sr.Intensity, sr.Spread = S.sunRaysIntensity, S.sunRaysSpread
        sr.Parent = Light
        R.sunRaysEffect = sr
    end
end

local function ApplyFog()
    if S.fogEnabled then
        Light.FogStart, Light.FogEnd, Light.FogColor = S.fogStart, S.fogEnd, S.fogColor
    else
        Light.FogStart, Light.FogEnd = 0, 100000
    end
end

-- ========== FAKEDUCK SYSTEM ==========
local function ToggleFakeduck()
    S.fdEnabled = not S.fdEnabled

    if S.fdEnabled then
        local hum = R.myHum
        if hum then
            local anim = hum:FindFirstChildOfClass("Animator")
            if not anim then anim = Instance.new("Animator", hum) end
            
            pcall(function()
                local a1 = Instance.new("Animation")
                a1.AnimationId = "rbxassetid://102226306945117"
                R.fdIdleAnim = anim:LoadAnimation(a1)
                R.fdIdleAnim.Priority = Enum.AnimationPriority.Action4
                R.fdIdleAnim.Looped = true
                
                local a2 = Instance.new("Animation")
                a2.AnimationId = "rbxassetid://124458965304788"
                R.fdWalkAnim = anim:LoadAnimation(a2)
                R.fdWalkAnim.Priority = Enum.AnimationPriority.Action4
                R.fdWalkAnim.Looped = true
            end)
        end
    else
        pcall(function()
            if R.fdIdleAnim and R.fdIdleAnim.IsPlaying then R.fdIdleAnim:Stop() end
            if R.fdWalkAnim and R.fdWalkAnim.IsPlaying then R.fdWalkAnim:Stop() end
        end)
        R.fdCrouch, R.fdTarget = false, nil
        R.fdIdleAnim, R.fdWalkAnim = nil, nil
    end

    ApplySettings()
end


-- ========== MAIN LOOP (OPTIMIZED) ==========
local frame = 0
local lastPlayerUpdate = 0
local PLAYER_UPDATE_INTERVAL = 0.1  -- Было 0.35, ускорено

local function MainLoop()
    if not R.running then return end
    frame = frame + 1

    -- Кэш персонажа каждые 10 кадров (было 15)
    if frame % 10 == 0 then CacheChar() end
    if not R.myChar or not R.myHRP then return end

    local now = TICK()
    
    if now - lastPlayerUpdate > PLAYER_UPDATE_INTERVAL then
        UpdatePlayerData()
        lastPlayerUpdate = now
    end

    local hrp, head, cam = R.myHRP, R.myHead, R.cam

    -- Infinite Jump и Air Shoot - каждый кадр (было 2)
    if S.ijEnabled then IJ_Update() end
    if S.rbAirShoot then AS_Update() end

    -- RAGEBOT - каждые 2 кадра (было 3)
    if S.rbEnabled and S.rbAutoFire and frame % 2 == 0 and head then
        if now - R.rbLast >= S.rbFireRate then
            RayP.FilterDescendantsInstances = {R.myChar}
            local best, bestScore = nil, -9999
            local bulletOrigin = hrp.Position + hrp.CFrame.LookVector
            
            local maxCheck = MIN(10, #R.playerData)  -- Увеличено с 6 до 10
            for i = 1, maxCheck do
                local d = R.playerData[i]
                if not d or d.team or d.dist >= S.rbMaxDist then continue end
                
                if S.rbNoAir and not R.apActive then
                    local groundRay = WS:Raycast(d.r.Position, V3(0, -4, 0), RayP)
                    local enemyVelY = d.r.AssemblyLinearVelocity.Y
                    if not groundRay or ABS(enemyVelY) > 8 then continue end
                end
                
                local tgt = S.rbHitbox == "Head" and d.head or d.torso or d.r
                if not tgt then continue end
                
                local vel = d.r.AssemblyLinearVelocity
                local predictedPos = tgt.Position
                
                if S.rbPrediction and vel.Magnitude > 0.5 then
                    local ping = LP:GetNetworkPing()
                    local predTime = ping * S.rbPredMulti
                    predictedPos = tgt.Position + V3(vel.X * predTime, 0, vel.Z * predTime)
                end
                
                local res = WS:Raycast(bulletOrigin, predictedPos - bulletOrigin, RayP)
                
                -- Проверка видимости: нет препятствия ИЛИ попали во врага
                local canHit = not res or res.Instance:IsDescendantOf(d.c)
                
                -- Если WallCheck включен - требуем прямую видимость
                if S.rbWallCheck and not canHit then continue end
                
                -- Если WallCheck выключен - стреляем в любом случае (wallbang)
                if canHit or not S.rbWallCheck then
                    local score = S.rbMaxDist - d.dist
                    if score > bestScore then
                        bestScore = score
                        best = {d = d, tgt = tgt, predictedPos = predictedPos}
                    end
                end
            end
            
            if S.avEnabled then
                if best and best.d and best.d.head then
                    AV_Update(best.d.head.Position, bulletOrigin)
                else
                    AV_RemoveLine()
                end
            end
            
            if best then
                local fs = GetFireShot()
                if fs then
                    local pos = best.predictedPos or best.tgt.Position
                    local shootOrigin = BE_GetShootOrigin(bulletOrigin)
                    pcall(function() fs:FireServer(shootOrigin, (pos - shootOrigin).Unit, best.tgt) end)
                    R.rbLast = now
                    
                    local playerName = best.d.p and best.d.p.Name or "Unknown"
                    TrackShot(playerName, best.tgt.Name or S.rbHitbox)
                end
            end
        end
    end

    -- BUNNYHOP
    if S.bhEnabled and frame % 2 == 0 and R.myHum then
        if now - R.bhPosCheckTime >= 1.5 then
            local curPos = hrp.Position
            if R.bhLastPos then
                local dist = (V3(curPos.X, 0, curPos.Z) - V3(R.bhLastPos.X, 0, R.bhLastPos.Z)).Magnitude
                R.bhCircling = dist < 15
            end
            R.bhLastPos, R.bhPosCheckTime = curPos, now
        end
        
        if not R.bhCircling then
            if now - R.bhLastReset >= 2.5 and not R.bhResetting then
                R.bhResetting, R.bhLastReset = true, now
                local wasInAir = R.bhInAir
                R.myHum.WalkSpeed = 27
                task.delay(0.2, function()
                    if S.bhEnabled and R.myHum then
                        R.myHum.WalkSpeed = wasInAir and R.bhInAir and S.bhAirSpeed or (not R.bhInAir and S.bhGroundSpeed or R.bhOrigSpeed)
                    end
                    R.bhResetting = false
                end)
            end
            
            RayP.FilterDescendantsInstances = {R.myChar}
            local onGround = WS:Raycast(hrp.Position, V3(0, -3.5, 0), RayP) ~= nil
            
            if not onGround and not R.bhInAir then
                R.bhInAir = true
                if not R.bhResetting then R.myHum.WalkSpeed = S.bhAirSpeed end
            elseif onGround and R.bhInAir then
                R.bhInAir = false
                if not R.bhResetting then R.myHum.WalkSpeed = S.bhGroundSpeed end
            end
            
            if R.bhInAir and not R.bhResetting then
                local vel, moveDir = hrp.AssemblyLinearVelocity, R.myHum.MoveDirection
                if moveDir.Magnitude > 0 then
                    hrp.AssemblyLinearVelocity = V3(moveDir.X * S.bhAirSpeed * 0.95, vel.Y, moveDir.Z * S.bhAirSpeed * 0.95)
                end
            end
        else
            R.myHum.WalkSpeed = R.bhOrigSpeed
        end
    end

    -- FAKEDUCK
    if S.fdEnabled and frame % 4 == 0 and head then
        if R.fdLock then
            R.fdCrouch = true
        else
            RayP.FilterDescendantsInstances = {R.myChar}
            local enemy = nil
            
            local maxCheck = MIN(4, #R.playerData)
            for i = 1, maxCheck do
                local d = R.playerData[i]
                if d and not d.team and d.dist <= FD_DIST and d.head and cam then
                    local _, on = cam:WorldToScreenPoint(d.head.Position)
                    if on then
                        local res = WS:Raycast(head.Position, d.head.Position - head.Position, RayP)
                        if not res or res.Instance:IsDescendantOf(d.c) then
                            enemy = d.p
                            break
                        end
                    end
                end
            end
            
            if enemy then
                R.fdTarget, R.fdCrouch = enemy, false
            else
                if R.fdTarget then
                    local c = R.fdTarget.Character
                    if not c or not c:FindFirstChildOfClass("Humanoid") or c:FindFirstChildOfClass("Humanoid").Health <= 0 then
                        R.fdTarget = nil
                    end
                end
                if not R.fdTarget then R.fdCrouch = true end
            end
        end
    end

    if frame > 500 then frame = 0 end
end

-- ========== СИСТЕМА ЗАПУСКА/ОСТАНОВКИ ==========
local function StartMainLoop()
    if R.mainConn then return end
    CacheChar()
    -- Принудительное обновление данных игроков при старте
    R.playerDataTime = 0
    UpdatePlayerData()
    R.mainConn = RS.Heartbeat:Connect(MainLoop)
end

local function StopMainLoop()
    if R.mainConn then R.mainConn:Disconnect() R.mainConn = nil end
end


-- ========== APPLY SETTINGS ==========
function ApplySettings()
    R.hotkeys = {}

    local needLoop = S.rbEnabled or S.fdEnabled or S.bhEnabled or S.ijEnabled or S.rbAirShoot
    if needLoop then StartMainLoop() else StopMainLoop() end

    if S.rbEnabled then R.hotkeys["Ragebot"] = {active = true, key = "ON"} end
    if S.rbAirShoot then R.hotkeys["Air Shoot"] = {active = true, key = S.rbAirShootKey.Name} end
    if S.fdEnabled then R.hotkeys["Fakeduck"] = {active = true, key = S.fdKey.Name} end
    if S.bhEnabled then R.hotkeys["BunnyHop"] = {active = true, key = S.bhKey.Name} end
    if S.dtEnabled then R.hotkeys["DoubleTap"] = {active = true, key = S.dtKey.Name} end
    if S.wbEnabled then R.hotkeys["Wallbang"] = {active = true, key = "ON"} end
    if S.rcEnabled then R.hotkeys["NoCollision"] = {active = true, key = "ON"} end
    if R.apActive then R.hotkeys["AI Peek v6"] = {active = true, key = S.apKey.Name} end
    if R.epActive then R.hotkeys["Exploit Pos"] = {active = true, key = S.epKey.Name} end
    if R.beActive then R.hotkeys["Barrel Ext"] = {active = true, key = S.beKey.Name .. " [" .. S.beMode .. "]"} end

    UpdateHotkeyList()
end

-- ========== CONFIG SYSTEM ==========
local function EnsureCfgFolder()
    if not Cfg.FS then return false end
    pcall(function() if not isfolder(Cfg.Folder) then makefolder(Cfg.Folder) end end)
    return true
end

local function RefreshCfg()
    Cfg.List = {}
    if not Cfg.FS then return end
    EnsureCfgFolder()
    pcall(function()
        for _, f in IPAIRS(listfiles(Cfg.Folder)) do
            local n = f:match("([^/\\]+)%.txt$")
            if n then INSERT(Cfg.List, n) end
        end
    end)
end

local function EncodeSettings()
    local parts = {}
    for k, v in PAIRS(S) do
        local val, vType = nil, TYPE(v)
        if vType == "EnumItem" then val = "K:" .. v.Name
        elseif vType == "boolean" then val = "B:" .. (v and "1" or "0")
        elseif vType == "number" then val = "N:" .. tostring(v)
        elseif vType == "string" then val = "S:" .. v
        elseif vType == "table" then val = "T:" .. HTTP:JSONEncode(v)
        elseif vType == "Color3" then val = "C:" .. FLOOR(v.R * 255) .. "," .. FLOOR(v.G * 255) .. "," .. FLOOR(v.B * 255)
        else continue end
        INSERT(parts, k .. "=" .. val)
    end
    return table.concat(parts, ";")
end

local function DecodeSettings(str)
    for pair in string.gmatch(str, "([^;]+)") do
        local k, typeVal = string.match(pair, "([^=]+)=(.+)")
        if k and typeVal and S[k] ~= nil then
            local t, v = string.match(typeVal, "^(%a):(.*)$")
            if t == "K" then pcall(function() S[k] = Enum.KeyCode[v] end)
            elseif t == "B" then S[k] = v == "1"
            elseif t == "N" then S[k] = tonumber(v) or S[k]
            elseif t == "S" then S[k] = v
            elseif t == "T" then pcall(function() S[k] = HTTP:JSONDecode(v) end)
            elseif t == "C" then
                local r, g, b = string.match(v, "(%d+),(%d+),(%d+)")
                if r then S[k] = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
            end
        end
    end
end

local function SaveCfg(name)
    if not Cfg.FS or not name or name == "" then return false end
    EnsureCfgFolder()
    local ok = pcall(function() writefile(Cfg.Folder .. "/" .. name .. ".txt", EncodeSettings()) end)
    if ok then RefreshCfg() end
    return ok
end

local function LoadCfg(name)
    if not Cfg.FS or not name or name == "" then return false end
    local path = Cfg.Folder .. "/" .. name .. ".txt"
    if not isfile(path) then return false end
    local ok, content = pcall(function() return readfile(path) end)
    if not ok or not content then return false end
    DecodeSettings(content)
    Cfg.Selected = name
    ApplySettings()
    return true
end

local function DeleteCfg(name)
    if not Cfg.FS or not name or name == "" then return end
    pcall(function() if isfile(Cfg.Folder .. "/" .. name .. ".txt") then delfile(Cfg.Folder .. "/" .. name .. ".txt") end end)
    RefreshCfg()
end

-- ========== HOTKEY LIST ==========
function UpdateHotkeyList()
    if not R.hkFrame then return end
    local cont = R.hkFrame:FindFirstChild("C")
    if not cont then return end

    for _, c in IPAIRS(cont:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end

    for name, data in PAIRS(R.hotkeys) do
        if data.active then
            local e = Instance.new("Frame", cont)
            e.Size, e.BackgroundTransparency = UDim2.new(1, 0, 0, 16), 1
            
            local nl = Instance.new("TextLabel", e)
            nl.Text, nl.Size, nl.BackgroundTransparency = name, UDim2.new(0.65, 0, 1, 0), 1
            nl.TextXAlignment, nl.Font, nl.TextSize, nl.TextColor3 = Enum.TextXAlignment.Left, T.Font, 11, T.Text
            
            local kl = Instance.new("TextLabel", e)
            kl.Text = "[" .. data.key .. "]"
            kl.Size, kl.Position = UDim2.new(0.35, 0, 1, 0), UDim2.new(0.65, 0, 0, 0)
            kl.BackgroundTransparency, kl.TextXAlignment = 1, Enum.TextXAlignment.Right
            kl.Font, kl.TextSize, kl.TextColor3 = T.Font, 10, T.Dim
        end
    end
end

local function UpdateCfgDropdown()
    if not R.cfgDropdownList then return end

    for _, c in IPAIRS(R.cfgDropdownList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end

    RefreshCfg()

    for _, cfgName in IPAIRS(Cfg.List) do
        local btn = Instance.new("TextButton", R.cfgDropdownList)
        btn.Size, btn.BackgroundColor3, btn.BorderSizePixel = UDim2.new(1, 0, 0, 20), T.Dark, 0
        btn.Text, btn.Font, btn.TextSize, btn.ZIndex = cfgName, T.Font, 12, 101
        btn.TextColor3 = cfgName == Cfg.Selected and T.Accent or T.Dim
        
        btn.MouseButton1Click:Connect(function()
            Cfg.Selected = cfgName
            if R.cfgDropdown then R.cfgDropdown.Text = cfgName .. " ▼" end
            for _, b in IPAIRS(R.cfgDropdownList:GetChildren()) do
                if b:IsA("TextButton") then b.TextColor3 = b.Text == Cfg.Selected and T.Accent or T.Dim end
            end
        end)
    end

    R.cfgDropdownList.Size = UDim2.new(1, 0, 0, MAX(20, #Cfg.List * 20))
end


-- ========== MODELS DATA ==========
local Models = {
    ["Mike Wazowski"] = {{}, {108792046953186}, 1, 1, false, false, nil},
    ["Fat Chicken"] = {{}, {97309274164914}, 1, 1, false, false, nil},
    ["Tung Tung Sahur"] = {{}, {117976702168543}, 1, 1, false, false, nil},
    ["Ghostface Scream"] = {{}, {109275113218599}, 1, 1, false, false, nil},
    ["Mini Pigeon"] = {{}, {134936622364544}, 1, 1, false, false, nil},
    ["Patrick Suit"] = {{}, {114561781784509}, 1, 1, false, false, nil},
    ["Buff Doge"] = {{}, {135861229178903}, 1, 1, false, false, nil},
    ["Monkey Suit"] = {{}, {133241040400728}, 1, 1, false, false, nil},
    ["Chubby Boy Meme"] = {{}, {112601613562351}, 1, 1, false, false, nil},
    ["Zelensky Skin"] = {{114906957884779}, {81828736436792}, 1, 0, false, false, CF(0, -0.3, 0)},
    ["Trump Head"] = {{77332453752069}, {}, 1, 0, false, true, nil},
    ["Putin Head"] = {{96761887509449}, {}, 1, 0, false, true, nil},
    ["Ronaldo Head"] = {{106097690556580}, {}, 1, 0, false, true, CF(0, 0.25, 0)},
    ["Dexter Morgan"] = {{83372243424051}, {}, 1, 0, false, true, nil},
    ["Kim Jong-Un"] = {{100019190392818}, {}, 1, 0, false, true, CF_ANG(0, RAD(180), 0)},
    ["Messi Head"] = {{18200639690}, {}, 1, 0, false, true, nil},
    ["67 Kid"] = {{111460135975152}, {}, 1, 0, false, true, CF_ANG(0, RAD(180), 0)}
}

local ModelList = {"None"}
for k in PAIRS(Models) do INSERT(ModelList, k) end
table.sort(ModelList, function(a, b) if a == "None" then return true end if b == "None" then return false end return a < b end)

local function ApplyModel(name)
    if name == "None" or not Models[name] then return end
    local d = Models[name]
    local headIds, torsoIds, headT, bodyT, keepHead, isHeadAcc, rotation = d[1], d[2], d[3], d[4], d[5], d[6], d[7]

    local function onChar(char)
        task.wait(0.5)
        if not char or not char.Parent then return end
        
        for _, child in IPAIRS(char:GetChildren()) do
            if child:IsA("Accessory") then
                local isHeadAccessory = false
                local handle = child:FindFirstChild("Handle")
                if handle then
                    local weld = handle:FindFirstChildOfClass("Weld")
                    if weld and ((weld.Part0 and weld.Part0.Name == "Head") or (weld.Part1 and weld.Part1.Name == "Head")) then
                        isHeadAccessory = true
                    end
                end
                if not keepHead or not isHeadAccessory then child:Destroy() end
            end
        end
        
        for _, desc in IPAIRS(char:GetChildren()) do
            if desc:IsA("BasePart") and desc.Name ~= "HumanoidRootPart" then
                desc.Transparency = desc.Name == "Head" and headT or bodyT
                if desc.Name == "UpperTorso" then
                    for _, decal in IPAIRS(desc:GetChildren()) do if decal:IsA("Decal") then decal:Destroy() end end
                end
            end
        end
        
        local head = char:FindFirstChild("Head")
        if headT == 1 and head then
            local face = head:FindFirstChild("face") or head:FindFirstChild("Face")
            if face then face:Destroy() end
        end
        
        local torsoPart = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
        
        for _, id in IPAIRS(headIds) do
            task.spawn(function()
                local ok, acc = pcall(function() return game:GetObjects("rbxassetid://" .. id)[1] end)
                if ok and acc and head then
                    local handle = acc:FindFirstChild("Handle")
                    if handle then
                        handle.CanCollide = false
                        local w = Instance.new("Weld")
                        w.Part0, w.Part1 = head, handle
                        w.C0 = isHeadAcc and (rotation or CF(0, 0, 0)) or (rotation and (CF(0, head.Size.Y / 2, 0) * rotation) or CF(0, head.Size.Y / 2, 0))
                        w.Parent = head
                    end
                    acc.Parent = char
                end
            end)
        end
        
        if torsoPart then
            for _, id in IPAIRS(torsoIds) do
                task.spawn(function()
                    local ok, acc = pcall(function() return game:GetObjects("rbxassetid://" .. id)[1] end)
                    if ok and acc then
                        local handle = acc:FindFirstChild("Handle")
                        if handle then
                            handle.CanCollide = false
                            local w = Instance.new("Weld")
                            w.Part0, w.Part1, w.C0 = torsoPart, handle, CF(0, 0, 0)
                            w.Parent = torsoPart
                        end
                        acc.Parent = char
                    end
                end)
            end
        end
    end

    if getgenv().modelConn then getgenv().modelConn:Disconnect() end
    getgenv().modelConn = LP.CharacterAdded:Connect(onChar)
    if LP.Character then onChar(LP.Character) end
end


-- ========== UI LIBRARY ==========
local Lib = {}

local function CreateHK()
    if R.hkFrame then R.hkFrame:Destroy() end

    local f = Instance.new("Frame", R.gui)
    f.Name, f.Size, f.Position = "HK", UDim2.new(0, 160, 0, 24), UDim2.new(1, -170, 0, 200)
    f.BackgroundColor3, f.BackgroundTransparency, f.BorderSizePixel, f.Active = T.Main, 0.1, 0, true

    Instance.new("UIStroke", f).Color = T.Stroke

    local gl = Instance.new("Frame", f)
    gl.Size, gl.BorderSizePixel = UDim2.new(1, 0, 0, 2), 0
    Instance.new("UIGradient", gl).Color = ColorSequence.new({ColorSequenceKeypoint.new(0, T.Accent), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 50))})

    local title = Instance.new("TextLabel", f)
    title.Text, title.Size, title.Position = "hotkeys", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 3)
    title.BackgroundTransparency, title.Font, title.TextSize, title.TextColor3 = 1, T.Font, 11, T.Dim

    local cont = Instance.new("Frame", f)
    cont.Name, cont.Size, cont.Position, cont.BackgroundTransparency = "C", UDim2.new(1, -8, 1, -24), UDim2.new(0, 4, 0, 22), 1

    local list = Instance.new("UIListLayout", cont)
    list.Padding = UDim.new(0, 2)
    list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        f.Size = UDim2.new(0, 160, 0, MAX(24, list.AbsoluteContentSize.Y + 26))
    end)

    R.hkFrame = f

    local drag, dStart, dPos = false, nil, nil
    f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dStart, dPos = true, i.Position, f.Position end end)
    f.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement and drag then local d = i.Position - dStart f.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y) end end)
    INSERT(R.conns, UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end))
end

local function CreateWM()
    if R.wmFrame then R.wmFrame:Destroy() end

    local f = Instance.new("Frame", R.gui)
    f.Size, f.Position = UDim2.new(0, 200, 0, 22), UDim2.new(0, 10, 0, 10)
    f.BackgroundColor3, f.BackgroundTransparency, f.BorderSizePixel = T.Main, 0.1, 0

    Instance.new("UIStroke", f).Color = T.Stroke

    local gl = Instance.new("Frame", f)
    gl.Size, gl.BorderSizePixel = UDim2.new(1, 0, 0, 2), 0
    Instance.new("UIGradient", gl).Color = ColorSequence.new({ColorSequenceKeypoint.new(0, T.Accent), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 50))})

    local txt = Instance.new("TextLabel", f)
    txt.Name, txt.Size, txt.Position = "T", UDim2.new(1, -10, 1, -2), UDim2.new(0, 5, 0, 2)
    txt.BackgroundTransparency, txt.Font, txt.TextSize, txt.TextColor3, txt.TextXAlignment = 1, T.Font, 11, T.Text, Enum.TextXAlignment.Left
    txt.Text = "Crack By Lvzz | loading..."

    R.wmFrame = f

    task.spawn(function()
        local lastTime, frameCount, fps = TICK(), 0, 60
        local fpsConn = RS.RenderStepped:Connect(function() frameCount = frameCount + 1 end)
        
        while R.running and f and f.Parent do
            local elapsed = TICK() - lastTime
            if elapsed >= 1 then fps, frameCount, lastTime = FLOOR(frameCount / elapsed), 0, TICK() end
            local ping = FLOOR(LP:GetNetworkPing() * 1000)
            txt.Text = "Crack By Lvzz | fps: " .. fps .. " | ping: " .. ping .. "ms"
            f.Size = UDim2.new(0, TS:GetTextSize(txt.Text, 11, T.Font, V3(1000, 22)).X + 20, 0, 22)
            task.wait(0.1)
        end
        if fpsConn then fpsConn:Disconnect() end
    end)
end

local function CreateTimeDisplay()
    if R.timeFrame then R.timeFrame:Destroy() end

    local f = Instance.new("Frame", R.gui)
    f.Size, f.Position = UDim2.new(0, 80, 0, 22), UDim2.new(1, -90, 0, 10)
    f.BackgroundColor3, f.BackgroundTransparency, f.BorderSizePixel, f.Active = T.Main, 0.1, 0, true

    Instance.new("UIStroke", f).Color = T.Stroke

    local gl = Instance.new("Frame", f)
    gl.Size, gl.BorderSizePixel = UDim2.new(1, 0, 0, 2), 0
    Instance.new("UIGradient", gl).Color = ColorSequence.new({ColorSequenceKeypoint.new(0, T.Accent), ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 200, 50))})

    local txt = Instance.new("TextLabel", f)
    txt.Name, txt.Size, txt.Position = "T", UDim2.new(1, -10, 1, -2), UDim2.new(0, 5, 0, 2)
    txt.BackgroundTransparency, txt.Font, txt.TextSize, txt.TextColor3, txt.TextXAlignment = 1, T.Font, 11, T.Text, Enum.TextXAlignment.Center
    txt.Text = "--:--:--"

    R.timeFrame = f

    local drag, dStart, dPos = false, nil, nil
    f.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag, dStart, dPos = true, i.Position, f.Position end end)
    f.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement and drag then local d = i.Position - dStart f.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y) end end)
    INSERT(R.conns, UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end))

    task.spawn(function()
        while R.running and f and f.Parent do
            local bt = GetBerlinTime()
            txt.Text = FORMAT("%02d:%02d:%02d", bt.hour, bt.min, bt.sec)
            task.wait(1)
        end
    end)
end


-- ========== SCOPE CROSSHAIR (HvH Style) ==========
local scopeFrame = nil
local scopeParts = {}

local function CreateScope()
    if scopeFrame then scopeFrame:Destroy() end
    scopeParts = {}
    if not R.gui or not S.scopeEnabled then return end
    
    scopeFrame = Instance.new("Frame", R.gui)
    scopeFrame.Name = "ScopeCrosshair"
    scopeFrame.Size = UDim2.new(0, 0, 0, 0)
    local yOffset = S.scopeOffsetY or -36
    scopeFrame.Position = UDim2.new(0.5, 0, 0.5, yOffset)
    scopeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    scopeFrame.BackgroundTransparency = 1
    scopeFrame.ZIndex = 100
    
    local color = S.scopeColor or Color3.fromRGB(255, 50, 50)
    local size = S.scopeSize or 20
    local gap = S.scopeGap or 8
    local thickness = S.scopeThickness or 1
    
    local function CreateLine(x, y, w, h)
        local outline = Instance.new("Frame", scopeFrame)
        outline.Size = UDim2.new(0, w + 2, 0, h + 2)
        outline.Position = UDim2.new(0, x - (w + 2)/2, 0, y - (h + 2)/2)
        outline.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        outline.BackgroundTransparency = 0.3
        outline.BorderSizePixel = 0
        outline.ZIndex = 101
        INSERT(scopeParts, outline)
        
        local line = Instance.new("Frame", scopeFrame)
        line.Size = UDim2.new(0, w, 0, h)
        line.Position = UDim2.new(0, x - w/2, 0, y - h/2)
        line.BackgroundColor3 = color
        line.BackgroundTransparency = 0
        line.BorderSizePixel = 0
        line.ZIndex = 102
        INSERT(scopeParts, line)
        
        return line
    end
    
    CreateLine(0, -(gap + size/2), thickness, size)
    CreateLine(0, gap + size/2, thickness, size)
    CreateLine(-(gap + size/2), 0, size, thickness)
    CreateLine(gap + size/2, 0, size, thickness)
end

local function DestroyScope()
    if scopeFrame then scopeFrame:Destroy() scopeFrame = nil end
    scopeParts = {}
end

local function UpdateScopeColor()
    if not scopeFrame then return end
    local color = S.scopeColor or Color3.fromRGB(255, 50, 50)
    for _, part in ipairs(scopeParts) do
        if part and part.Parent and part.ZIndex == 102 then
            part.BackgroundColor3 = color
        end
    end
end

local function ToggleScope(enabled)
    if enabled then CreateScope() else DestroyScope() end
end


-- ========== KILL EFFECTS (Multi-Type) ==========

local killScreenColors = {
    Red = Color3.fromRGB(255, 50, 50),
    Blue = Color3.fromRGB(50, 100, 255),
    Green = Color3.fromRGB(50, 255, 100),
    Purple = Color3.fromRGB(180, 50, 255),
    Cyan = Color3.fromRGB(50, 255, 255),
    Yellow = Color3.fromRGB(255, 255, 50),
    White = Color3.fromRGB(255, 255, 255),
    Pink = Color3.fromRGB(255, 100, 200)
}

local function CreateKillScreenEffect()
    if not R.gui or not S.killEffects then return end
    
    local screenType = S.killScreenType or "CS:GO"
    local duration = S.killScreenDuration or 0.25
    local color = killScreenColors[S.killScreenColor] or killScreenColors.Red
    
    if screenType == "CS:GO" then
        local flash = Instance.new("Frame", R.gui)
        flash.Name = "KillFlash"
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.Position = UDim2.new(0, 0, 0, 0)
        flash.BackgroundColor3 = color
        flash.BackgroundTransparency = 0.4
        flash.BorderSizePixel = 0
        flash.ZIndex = 100
        
        local killIcon = Instance.new("TextLabel", flash)
        killIcon.Size = UDim2.new(0, 80, 0, 80)
        killIcon.Position = UDim2.new(0.5, -40, 0.4, -40)
        killIcon.BackgroundTransparency = 1
        killIcon.Text = "✕"
        killIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
        killIcon.TextSize = 72
        killIcon.Font = Enum.Font.GothamBold
        killIcon.TextTransparency = 0
        killIcon.TextStrokeTransparency = 0.5
        killIcon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        killIcon.ZIndex = 101
        
        local fadeInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(flash, fadeInfo, {BackgroundTransparency = 1}):Play()
        TweenS:Create(killIcon, fadeInfo, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        
        task.delay(duration + 0.1, function()
            if flash and flash.Parent then flash:Destroy() end
        end)
        
    elseif screenType == "Flash" then
        local flash = Instance.new("Frame", R.gui)
        flash.Name = "KillFlash"
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = color
        flash.BackgroundTransparency = 0.3
        flash.BorderSizePixel = 0
        flash.ZIndex = 100
        
        local fadeInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(flash, fadeInfo, {BackgroundTransparency = 1}):Play()
        
        task.delay(duration + 0.1, function()
            if flash and flash.Parent then flash:Destroy() end
        end)
        
    elseif screenType == "Vignette" then
        local vignette = Instance.new("Frame", R.gui)
        vignette.Name = "KillVignette"
        vignette.Size = UDim2.new(1, 0, 1, 0)
        vignette.BackgroundColor3 = color
        vignette.BackgroundTransparency = 0.6
        vignette.BorderSizePixel = 0
        vignette.ZIndex = 100
        
        local gradient = Instance.new("UIGradient", vignette)
        gradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.4, 0.8),
            NumberSequenceKeypoint.new(1, 1)
        })
        gradient.Rotation = 90
        
        local fadeInfo = TweenInfo.new(duration * 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(vignette, fadeInfo, {BackgroundTransparency = 1}):Play()
        
        task.delay(duration * 1.5 + 0.1, function()
            if vignette and vignette.Parent then vignette:Destroy() end
        end)
        
    elseif screenType == "Skull" then
        local flash = Instance.new("Frame", R.gui)
        flash.Name = "KillFlash"
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = color
        flash.BackgroundTransparency = 0.5
        flash.BorderSizePixel = 0
        flash.ZIndex = 100
        
        local skull = Instance.new("TextLabel", flash)
        skull.Size = UDim2.new(0, 100, 0, 100)
        skull.Position = UDim2.new(0.5, -50, 0.4, -50)
        skull.BackgroundTransparency = 1
        skull.Text = "💀"
        skull.TextSize = 80
        skull.TextTransparency = 0
        skull.ZIndex = 101
        
        local fadeInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(flash, fadeInfo, {BackgroundTransparency = 1}):Play()
        TweenS:Create(skull, fadeInfo, {TextTransparency = 1}):Play()
        
        task.delay(duration + 0.1, function()
            if flash and flash.Parent then flash:Destroy() end
        end)
        
    elseif screenType == "HvH" then
        local flash = Instance.new("Frame", R.gui)
        flash.Name = "KillFlash"
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        flash.BackgroundTransparency = 0.2
        flash.BorderSizePixel = 0
        flash.ZIndex = 100
        
        local killText = Instance.new("TextLabel", flash)
        killText.Size = UDim2.new(0, 200, 0, 50)
        killText.Position = UDim2.new(0.5, -100, 0.4, -25)
        killText.BackgroundTransparency = 1
        killText.Text = "KILL"
        killText.TextColor3 = color
        killText.TextSize = 48
        killText.Font = Enum.Font.GothamBlack
        killText.TextTransparency = 0
        killText.TextStrokeTransparency = 0
        killText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        killText.ZIndex = 101
        
        local quickFade = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(flash, quickFade, {BackgroundTransparency = 1}):Play()
        
        local textFade = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenS:Create(killText, textFade, {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
        
        task.delay(duration + 0.1, function()
            if flash and flash.Parent then flash:Destroy() end
        end)
        
    elseif screenType == "None" then
        return
    end
end


-- Оптимизированные партиклы при смерти (без фризов)
local function CreateDeathParticles(enemyChar)
    if not enemyChar or not S.killEffects then return end
    
    local hrp = enemyChar:FindFirstChild("HumanoidRootPart")
    local head = enemyChar:FindFirstChild("Head")
    local targetPart = head or hrp
    if not targetPart then return end
    
    local att = Instance.new("Attachment", targetPart)
    att.Name = "KillParticleAtt"
    
    local particleType = S.killParticleType or "Binary"
    
    local digitalChars = {
        Binary = {"0", "1", "00", "11", "01", "10"},
        Matrix = {"ア", "イ", "ウ", "カ", "キ", "0", "1"},
        Hex = {"0x", "FF", "00", "A1", "B2", "C3"},
        Code = {"</>", "{}", "[]", "();", "++", "=="},
        Glitch = {"█", "▓", "▒", "░", "■", "□"},
        Numbers = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    }
    
    local chars = digitalChars[particleType] or digitalChars.Binary
    local particleCount = 15  -- Оптимизировано
    
    local typeColors = {
        Binary = {main = Color3.fromRGB(0, 255, 100), stroke = Color3.fromRGB(0, 50, 20)},
        Matrix = {main = Color3.fromRGB(0, 255, 70), stroke = Color3.fromRGB(0, 80, 30)},
        Hex = {main = Color3.fromRGB(255, 100, 50), stroke = Color3.fromRGB(100, 30, 0)},
        Code = {main = Color3.fromRGB(100, 200, 255), stroke = Color3.fromRGB(0, 50, 100)},
        Glitch = {main = Color3.fromRGB(255, 100, 255), stroke = Color3.fromRGB(50, 0, 50)},
        Numbers = {main = Color3.fromRGB(255, 255, 255), stroke = Color3.fromRGB(50, 50, 50)}
    }
    
    local colors = typeColors[particleType] or typeColors.Binary
    
    for i = 1, particleCount do
        local particle = Instance.new("BillboardGui", att)
        particle.Size = UDim2.new(0, 25, 0, 25)
        particle.StudsOffset = V3(RANDOM(-3, 3), RANDOM(-1, 3), RANDOM(-3, 3))
        particle.AlwaysOnTop = true
        
        local txt = Instance.new("TextLabel", particle)
        txt.Size = UDim2.new(1, 0, 1, 0)
        txt.BackgroundTransparency = 1
        txt.Text = chars[RANDOM(1, #chars)]
        txt.TextColor3 = colors.main
        txt.TextSize = RANDOM(14, 24)
        txt.Font = Enum.Font.Code
        txt.TextStrokeTransparency = 0.3
        txt.TextStrokeColor3 = colors.stroke
        
        local startOffset = particle.StudsOffset
        local endOffset = startOffset + V3(RANDOM(-3, 3), RANDOM(4, 10), RANDOM(-3, 3))
        
        if particleType == "Matrix" then
            endOffset = startOffset + V3(RANDOM(-1, 1), RANDOM(-8, -4), RANDOM(-1, 1))
        end
        
        -- Используем Heartbeat вместо task.wait - без фризов!
        task.spawn(function()
            local startTime = TICK()
            local duration = 1.2
            
            while particle.Parent do
                local elapsed = TICK() - startTime
                local t = MIN(elapsed / duration, 1)
                
                particle.StudsOffset = startOffset:Lerp(endOffset, t)
                txt.TextTransparency = t * 0.95
                txt.TextStrokeTransparency = 0.3 + t * 0.7
                
                if FLOOR(elapsed * 7) ~= FLOOR((elapsed - 0.016) * 7) then
                    txt.Text = chars[RANDOM(1, #chars)]
                    if particleType == "Glitch" then
                        txt.TextColor3 = Color3.fromRGB(RANDOM(150, 255), RANDOM(50, 255), RANDOM(150, 255))
                    end
                end
                
                if t >= 1 then break end
                RS.Heartbeat:Wait()
            end
            
            if particle.Parent then particle:Destroy() end
        end)
    end
    
    task.delay(2, function()
        if att and att.Parent then att:Destroy() end
    end)
end

-- ========== GHOST EFFECT (HvH Style) - Оптимизировано ==========
local function CreateGhostEffect(enemyChar)
    if not enemyChar or not S.killEffects or not S.ghostEffectEnabled then return end
    
    local originalTransparencies = {}
    local parts = {}
    
    for _, part in ipairs(enemyChar:GetDescendants()) do
        if part:IsA("BasePart") and part.Transparency < 1 then
            originalTransparencies[part] = part.Transparency
            INSERT(parts, part)
        end
    end
    
    if #parts == 0 then return end
    
    local ghostColor = S.ghostColor or Color3.fromRGB(100, 200, 255)
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "GhostHighlight"
    highlight.Adornee = enemyChar
    highlight.FillColor = ghostColor
    highlight.OutlineColor = ghostColor
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = enemyChar
    
    -- Оптимизированная анимация через Heartbeat (без task.wait)
    task.spawn(function()
        local duration = 0.8
        local startTime = TICK()
        
        while true do
            local elapsed = TICK() - startTime
            local t = MIN(elapsed / duration, 1)
            local eased = t * t
            
            for i = 1, #parts do
                local part = parts[i]
                if part and part.Parent then
                    local origTrans = originalTransparencies[part] or 0
                    part.Transparency = origTrans + (1 - origTrans) * eased
                end
            end
            
            if highlight and highlight.Parent then
                highlight.FillTransparency = 0.5 + eased * 0.5
                highlight.OutlineTransparency = eased
            end
            
            if t >= 1 then break end
            RS.Heartbeat:Wait()
        end
        
        if highlight and highlight.Parent then highlight:Destroy() end
        
        task.delay(0.3, function()
            for part, origTrans in pairs(originalTransparencies) do
                if part and part.Parent then
                    part.Transparency = origTrans
                end
            end
        end)
    end)
end

local function PlayKillEffects(playerName, enemyChar)
    if not S.killEffects then return end
    
    CreateKillScreenEffect()
    CreateDeathParticles(enemyChar)
    CreateGhostEffect(enemyChar)
end


-- ========== HIT LOGGER (Console Style) ==========
local hlLogIndex = 0

local function CreateHitLogger()
    if R.hlFrame then R.hlFrame:Destroy() end
    
    local f = Instance.new("Frame", R.gui)
    f.Name = "HitLogger"
    f.Size = UDim2.new(0, 550, 0, 200)
    f.Position = UDim2.new(0.5, -275, 0.58, 0)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    
    R.hlFrame = f
end

AddHitLog = function(logType, playerName, hitbox, damage)
    if not S.hlEnabled or not R.hlFrame then return end
    
    if logType == "kill" then
        local enemyChar = nil
        for _, p in IPAIRS(Plrs:GetPlayers()) do
            if p.Name == playerName then
                enemyChar = p.Character
                break
            end
        end
        PlayKillEffects(playerName, enemyChar)
    end
    
    local dmg = logType == "kill" and 100 or (damage or 0)
    local remaining = logType == "kill" and 0 or (logType == "miss" and 100 or (100 - dmg))
    if remaining < 0 then remaining = 0 end
    
    hlLogIndex = hlLogIndex + 1
    local myIndex = hlLogIndex
    
    for _, child in ipairs(R.hlFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name:match("^Log_") then
            local currentY = child.Position.Y.Offset
            game:GetService("TweenService"):Create(child, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
                Position = UDim2.new(0.5, 0, 0, currentY + 22)
            }):Play()
        end
    end
    
    local actionText = logType == "kill" and "Killed" or (logType == "miss" and "Missed" or "Hurt")
    local hitboxLower = (hitbox or "head"):lower()
    local fullText
    if logType == "miss" then
        fullText = FORMAT("✕ Missed %s (shot at %s).", playerName or "Unknown", hitboxLower)
    else
        fullText = FORMAT("%s %s in the %s for %d hp (%d remaining).", actionText, playerName or "Unknown", hitboxLower, dmg, remaining)
    end
    
    local bar = Instance.new("Frame", R.hlFrame)
    bar.Name = "Log_" .. myIndex
    bar.Size = UDim2.new(0, 460, 0, 20)
    bar.Position = UDim2.new(0.5, 0, 0, 0)
    bar.AnchorPoint = Vector2.new(0.5, 0)
    bar.BackgroundColor3 = Color3.fromRGB(25, 30, 35)
    bar.BackgroundTransparency = 0.45
    bar.BorderSizePixel = 0
    bar.ZIndex = 100
    
    Instance.new("UICorner", bar).CornerRadius = UDim.new(0, 4)
    
    local iconLabel = Instance.new("TextLabel", bar)
    iconLabel.Size = UDim2.new(0, 22, 1, 0)
    iconLabel.Position = UDim2.new(0, 6, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = logType == "miss" and "✕" or "⊙"
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextSize = 13
    iconLabel.TextColor3 = logType == "kill" and Color3.fromRGB(255, 100, 100) or (logType == "miss" and Color3.fromRGB(255, 180, 80) or Color3.fromRGB(180, 200, 220))
    iconLabel.ZIndex = 102
    
    local textLabel = Instance.new("TextLabel", bar)
    textLabel.Size = UDim2.new(1, -32, 1, 0)
    textLabel.Position = UDim2.new(0, 26, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = fullText
    textLabel.Font = Enum.Font.Code
    textLabel.TextSize = 13
    textLabel.TextColor3 = Color3.fromRGB(195, 200, 210)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextTruncate = Enum.TextTruncate.AtEnd
    textLabel.ZIndex = 101
    
    local accentLine = Instance.new("Frame", bar)
    accentLine.Size = UDim2.new(0, 2, 1, -4)
    accentLine.Position = UDim2.new(0, 2, 0, 2)
    accentLine.BackgroundColor3 = logType == "kill" and Color3.fromRGB(255, 80, 80) or (logType == "miss" and Color3.fromRGB(255, 160, 60) or Color3.fromRGB(100, 180, 255))
    accentLine.BackgroundTransparency = 0.3
    accentLine.BorderSizePixel = 0
    accentLine.ZIndex = 102
    Instance.new("UICorner", accentLine).CornerRadius = UDim.new(0, 1)
    
    bar.Position = UDim2.new(0.5, 0, 0, -15)
    bar.BackgroundTransparency = 1
    textLabel.TextTransparency = 1
    iconLabel.TextTransparency = 1
    accentLine.BackgroundTransparency = 1
    
    local slideInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local fadeInfo = TweenInfo.new(0.15)
    
    game:GetService("TweenService"):Create(bar, slideInfo, {Position = UDim2.new(0.5, 0, 0, 0)}):Play()
    game:GetService("TweenService"):Create(bar, fadeInfo, {BackgroundTransparency = 0.45}):Play()
    game:GetService("TweenService"):Create(textLabel, fadeInfo, {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(iconLabel, fadeInfo, {TextTransparency = 0}):Play()
    game:GetService("TweenService"):Create(accentLine, fadeInfo, {BackgroundTransparency = 0.3}):Play()
    
    local logs = {}
    for _, child in ipairs(R.hlFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name:match("^Log_") then
            INSERT(logs, child)
        end
    end
    
    table.sort(logs, function(a, b)
        local numA = tonumber(a.Name:match("Log_(%d+)")) or 0
        local numB = tonumber(b.Name:match("Log_(%d+)")) or 0
        return numA < numB
    end)
    
    while #logs > S.hlMaxLogs do
        local oldest = logs[1]
        if oldest then
            oldest:Destroy()
            table.remove(logs, 1)
        end
    end
    
    task.delay(5, function()
        if bar and bar.Parent then
            local fadeOut = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
            
            TweenS:Create(bar, fadeOut, {BackgroundTransparency = 1}):Play()
            TweenS:Create(textLabel, fadeOut, {TextTransparency = 1}):Play()
            TweenS:Create(iconLabel, fadeOut, {TextTransparency = 1}):Play()
            TweenS:Create(accentLine, fadeOut, {BackgroundTransparency = 1}):Play()
            
            task.delay(0.35, function()
                if bar and bar.Parent then bar:Destroy() end
            end)
        end
    end)
end


-- ========== KILL TRACKING ==========
local trackedEnemies = {}
local lastShotTarget = nil
local lastShotHitbox = nil
local lastShotTime = 0
local lastKillTime = 0
local lastHitTime = 0
local lastMissTime = 0
local pendingShots = {}
local lastShotByTarget = {}

TrackShot = function(playerName, hitbox)
    lastShotTarget = playerName
    lastShotHitbox = hitbox or "Head"
    lastShotTime = TICK()
    
    if lastShotByTarget[playerName] then
        pendingShots[lastShotByTarget[playerName]] = nil
    end
    
    local shotId = TICK() .. "_" .. RANDOM(1000, 9999)
    pendingShots[shotId] = {target = playerName, hitbox = hitbox or "Head", time = TICK()}
    lastShotByTarget[playerName] = shotId
    
    task.delay(0.8, function()
        if pendingShots[shotId] then
            local now = TICK()
            if now - lastMissTime > 0.3 and now - lastHitTime > 0.3 and now - lastKillTime > 0.3 then
                lastMissTime = now
                AddHitLog("miss", playerName, hitbox or "Head", 0)
            end
            pendingShots[shotId] = nil
            if lastShotByTarget[playerName] == shotId then
                lastShotByTarget[playerName] = nil
            end
        end
    end)
end

local function ResolveShots(playerName)
    for id, shot in pairs(pendingShots) do
        if shot.target == playerName then
            pendingShots[id] = nil
        end
    end
    lastShotByTarget[playerName] = nil
end

SetupKillTracking = function()
    for _, player in IPAIRS(Plrs:GetPlayers()) do
        if player ~= LP and not trackedEnemies[player.UserId] then
            trackedEnemies[player.UserId] = true
            
            local function onCharacter(char)
                if not char then return end
                local hum = char:WaitForChild("Humanoid", 5)
                if not hum then return end
                
                local lastHealth = hum.Health
                
                hum.HealthChanged:Connect(function(newHealth)
                    local now = TICK()
                    local damage = FLOOR(lastHealth - newHealth)
                    
                    if lastShotTarget == player.Name and now - lastShotTime < 1.5 then
                        ResolveShots(player.Name)
                        
                        if newHealth <= 0 and lastHealth > 0 then
                            if now - lastKillTime > 0.5 then
                                lastKillTime = now
                                AddHitLog("kill", player.Name, lastShotHitbox or "Head", FLOOR(lastHealth))
                            end
                        elseif damage > 0 and now - lastHitTime > 0.25 then
                            lastHitTime = now
                            AddHitLog("hit", player.Name, lastShotHitbox or "Head", damage)
                        end
                    end
                    
                    lastHealth = newHealth
                end)
                
                hum.Died:Connect(function()
                    task.wait(0.5)
                    lastHealth = 100
                end)
            end
            
            if player.Character then onCharacter(player.Character) end
            player.CharacterAdded:Connect(onCharacter)
        end
    end
end

Plrs.PlayerAdded:Connect(function(player)
    if player ~= LP then
        task.delay(1, SetupKillTracking)
    end
end)


function Lib:Create(title)
    if R.gui then R.gui:Destroy() end

    R.gui = Instance.new("ScreenGui")
    R.gui.Name, R.gui.ResetOnSpawn = "Arc", false
    R.gui.Parent = game:GetService("CoreGui")

    CreateHK()
    CreateWM()
    CreateTimeDisplay()
    CreateHitLogger()

    local W = Instance.new("Frame", R.gui)
    W.Name, W.Size, W.Position = "M", UDim2.new(0, 620, 0, 450), UDim2.new(0.5, -310, 0.5, -225)
    W.BackgroundColor3, W.BorderSizePixel = T.Main, 0

    Instance.new("UIStroke", W).Color = T.Border
    R.main = W

    local gl = Instance.new("Frame", W)
    gl.Size, gl.BorderSizePixel = UDim2.new(1, 0, 0, 2), 0
    Instance.new("UIGradient", gl).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })

    local tl = Instance.new("TextLabel", W)
    tl.Text, tl.Size, tl.Position = title, UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 4)
    tl.BackgroundTransparency, tl.Font, tl.TextSize, tl.TextColor3 = 1, T.Font, 13, T.Text

    local tc = Instance.new("Frame", W)
    tc.Size, tc.Position = UDim2.new(1, -20, 0, 40), UDim2.new(0, 10, 0, 30)
    tc.BackgroundColor3, tc.BorderColor3 = T.Group, T.Stroke

    local tlay = Instance.new("UIListLayout", tc)
    tlay.FillDirection, tlay.HorizontalAlignment, tlay.Padding = Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Center, UDim.new(0, 15)

    local pc = Instance.new("Frame", W)
    pc.Size, pc.Position, pc.BackgroundTransparency = UDim2.new(1, -20, 1, -85), UDim2.new(0, 10, 0, 75), 1

    W.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 and i.Position.Y < W.AbsolutePosition.Y + 30 then R.drag, R.dragStart, R.startPos = true, i.Position, W.Position end end)
    W.InputChanged:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseMovement and R.drag then local d = i.Position - R.dragStart W.Position = UDim2.new(R.startPos.X.Scale, R.startPos.X.Offset + d.X, R.startPos.Y.Scale, R.startPos.Y.Offset + d.Y) end end)

    INSERT(R.conns, UIS.InputChanged:Connect(function(i)
        if R.sliderDrag and i.UserInputType == Enum.UserInputType.MouseMovement then
            local d = R.sliderDrag
            local rel = CLAMP((i.Position.X - d.bg.AbsolutePosition.X) / d.bg.AbsoluteSize.X, 0, 1)
            d.val = FLOOR(d.min + (d.max - d.min) * rel + 0.5)
            d.fill.Size = UDim2.new(rel, 0, 1, 0)
            d.lbl.Text = d.text .. ": " .. d.val
            if d.cb then d.cb(d.val) end
        end
    end))

    INSERT(R.conns, UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then R.drag, R.sliderDrag = false, nil end end))

    local Tabs = {}

    function Tabs:NewTab(name)
        local btn = Instance.new("TextButton", tc)
        btn.Text, btn.Size, btn.BackgroundTransparency = name, UDim2.new(0, 70, 1, 0), 1
        btn.Font, btn.TextSize, btn.TextColor3 = T.Font, 13, T.Dim
        
        local page = Instance.new("ScrollingFrame", pc)
        page.Size, page.BackgroundTransparency, page.Visible, page.BorderSizePixel = UDim2.new(1, 0, 1, 0), 1, false, 0
        page.ScrollBarThickness, page.ScrollBarImageColor3, page.AutomaticCanvasSize = 4, T.Accent, Enum.AutomaticSize.Y
        
        local lc = Instance.new("Frame", page)
        lc.Size, lc.BackgroundTransparency, lc.AutomaticSize = UDim2.new(0.48, 0, 0, 0), 1, Enum.AutomaticSize.Y
        Instance.new("UIListLayout", lc).Padding = UDim.new(0, 12)
        
        local rc = Instance.new("Frame", page)
        rc.Size, rc.Position, rc.BackgroundTransparency, rc.AutomaticSize = UDim2.new(0.48, 0, 0, 0), UDim2.new(0.52, 0, 0, 0), 1, Enum.AutomaticSize.Y
        Instance.new("UIListLayout", rc).Padding = UDim.new(0, 12)
        
        btn.MouseButton1Click:Connect(function()
            for _, p in IPAIRS(pc:GetChildren()) do p.Visible = false end
            for _, t in IPAIRS(tc:GetChildren()) do if t:IsA("TextButton") then t.TextColor3 = T.Dim end end
            page.Visible, btn.TextColor3 = true, T.Accent
        end)
        
        if #tc:GetChildren() == 2 then page.Visible, btn.TextColor3 = true, T.Accent end
        
        local TL = {}
        
        function TL:NewGroupbox(side, gtitle)
            local grp = Instance.new("Frame", side == "Right" and rc or lc)
            grp.Size, grp.BackgroundTransparency, grp.AutomaticSize = UDim2.new(1, 0, 0, 0), 1, Enum.AutomaticSize.Y
            
            local brd = Instance.new("Frame", grp)
            brd.Size, brd.Position = UDim2.new(1, 0, 0, 0), UDim2.new(0, 0, 0, 8)
            brd.BackgroundColor3, brd.BorderColor3, brd.AutomaticSize = T.Main, T.Stroke, Enum.AutomaticSize.Y
            
            local ttl = Instance.new("TextLabel", grp)
            ttl.Text, ttl.Position, ttl.AutomaticSize = gtitle, UDim2.new(0, 12, 0, 14), Enum.AutomaticSize.X
            ttl.BackgroundColor3, ttl.TextColor3, ttl.Font, ttl.TextSize, ttl.ZIndex = T.Main, T.Text, T.Font, 12, 2
            
            local cnt = Instance.new("Frame", brd)
            cnt.Size, cnt.Position, cnt.BackgroundTransparency, cnt.AutomaticSize = UDim2.new(1, -16, 0, 0), UDim2.new(0, 8, 0, 22), 1, Enum.AutomaticSize.Y
            Instance.new("UIListLayout", cnt).Padding = UDim.new(0, 8)
            Instance.new("UIPadding", brd).PaddingBottom = UDim.new(0, 8)
            
            local G = {}
            
            function G:Toggle(text, def, cb)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency = UDim2.new(1, 0, 0, 20), 1
                
                local box = Instance.new("Frame", f)
                box.Size, box.Position = UDim2.new(0, 16, 0, 16), UDim2.new(0, 0, 0, 2)
                Instance.new("UIStroke", box).Color = T.Stroke
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.Position = text, UDim2.new(1, -25, 1, 0), UDim2.new(0, 25, 0, 0)
                lbl.BackgroundTransparency, lbl.TextXAlignment, lbl.Font, lbl.TextSize = 1, Enum.TextXAlignment.Left, T.Font, 13
                
                local en = def
                local function upd() box.BackgroundColor3 = en and T.Accent or T.Dark lbl.TextColor3 = en and T.Text or T.Dim if cb then cb(en) end end
                
                local hitbox = Instance.new("TextButton", f)
                hitbox.Size, hitbox.BackgroundTransparency, hitbox.Text = UDim2.new(1, 0, 1, 0), 1, ""
                hitbox.MouseButton1Click:Connect(function() en = not en upd() end)
                upd()
                return G
            end
            
            function G:Slider(text, min, max, def, cb)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency = UDim2.new(1, 0, 0, 35), 1
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.BackgroundTransparency = text .. ": " .. def, UDim2.new(1, 0, 0, 15), 1
                lbl.TextXAlignment, lbl.TextColor3, lbl.Font, lbl.TextSize = Enum.TextXAlignment.Left, T.Dim, T.Font, 13
                
                local bg = Instance.new("Frame", f)
                bg.Size, bg.Position, bg.BackgroundColor3, bg.BorderColor3 = UDim2.new(1, 0, 0, 12), UDim2.new(0, 0, 0, 18), T.Dark, T.Stroke
                
                local fill = Instance.new("Frame", bg)
                fill.Size, fill.BackgroundColor3, fill.BorderSizePixel = UDim2.new((def - min) / (max - min), 0, 1, 0), T.Accent, 0
                
                bg.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then R.sliderDrag = {bg = bg, fill = fill, lbl = lbl, text = text, min = min, max = max, val = def, cb = cb} end end)
                return G
            end
            
            function G:Dropdown(text, opts, def, cb)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency, f.ClipsDescendants, f.ZIndex = UDim2.new(1, 0, 0, 40), 1, false, 10
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.BackgroundTransparency = text, UDim2.new(1, 0, 0, 15), 1
                lbl.TextXAlignment, lbl.TextColor3, lbl.Font, lbl.TextSize = Enum.TextXAlignment.Left, T.Dim, T.Font, 13
                
                local box = Instance.new("TextButton", f)
                box.Size, box.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 18)
                box.BackgroundColor3, box.BorderColor3, box.Text = T.Dark, T.Stroke, def .. " ▼"
                box.TextColor3, box.Font, box.TextSize = T.Text, T.Font, 13
                
                local ol = Instance.new("Frame", f)
                ol.Size, ol.Position = UDim2.new(1, 0, 0, #opts * 20), UDim2.new(0, 0, 0, 38)
                ol.BackgroundColor3, ol.BorderColor3, ol.Visible, ol.ZIndex = T.Darker, T.Stroke, false, 100
                Instance.new("UIListLayout", ol)
                
                local cur, open = def, false
                
                for _, opt in IPAIRS(opts) do
                    local ob = Instance.new("TextButton", ol)
                    ob.Size, ob.BackgroundColor3, ob.BorderSizePixel = UDim2.new(1, 0, 0, 20), T.Dark, 0
                    ob.Text, ob.Font, ob.TextSize, ob.ZIndex = opt, T.Font, 12, 101
                    ob.TextColor3 = opt == cur and T.Accent or T.Dim
                    
                    ob.MouseButton1Click:Connect(function()
                        cur, box.Text, ol.Visible, open = opt, opt .. " ▼", false, false
                        f.Size = UDim2.new(1, 0, 0, 40)
                        for _, b in IPAIRS(ol:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = b.Text == cur and T.Accent or T.Dim end end
                        if cb then cb(cur) end
                    end)
                end
                
                box.MouseButton1Click:Connect(function() open = not open ol.Visible = open f.Size = open and UDim2.new(1, 0, 0, 40 + #opts * 20) or UDim2.new(1, 0, 0, 40) end)
                return G
            end
            
            function G:Button(text, cb)
                local b = Instance.new("TextButton", cnt)
                b.Size, b.BackgroundColor3, b.BorderColor3 = UDim2.new(1, 0, 0, 22), T.Dark, T.Stroke
                b.Text, b.TextColor3, b.Font, b.TextSize = text, T.Text, T.Font, 13
                b.MouseButton1Click:Connect(cb)
                return G
            end
            
            function G:Keybind(text, def, cb)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency = UDim2.new(1, 0, 0, 20), 1
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.BackgroundTransparency = text, UDim2.new(0.6, 0, 1, 0), 1
                lbl.TextXAlignment, lbl.TextColor3, lbl.Font, lbl.TextSize = Enum.TextXAlignment.Left, T.Dim, T.Font, 13
                
                local b = Instance.new("TextButton", f)
                b.Size, b.Position = UDim2.new(0.3, 0, 1, 0), UDim2.new(0.7, 0, 0, 0)
                b.BackgroundColor3, b.BorderColor3 = Color3.fromRGB(22, 22, 22), T.Stroke
                b.Text, b.TextColor3, b.Font, b.TextSize = "[" .. def.Name .. "]", T.Dim, T.Font, 11
                
                local waiting = false
                b.MouseButton1Click:Connect(function() waiting, b.Text, b.TextColor3 = true, "[...]", T.Accent end)
                INSERT(R.conns, UIS.InputBegan:Connect(function(i)
                    if waiting and i.UserInputType == Enum.UserInputType.Keyboard then
                        waiting, b.Text, b.TextColor3 = false, "[" .. i.KeyCode.Name .. "]", T.Dim
                        if cb then cb(i.KeyCode) end
                    end
                end))
                return G
            end
            
            function G:TextBox(text, def, cb)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency = UDim2.new(1, 0, 0, 40), 1
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.BackgroundTransparency = text, UDim2.new(1, 0, 0, 15), 1
                lbl.TextXAlignment, lbl.TextColor3, lbl.Font, lbl.TextSize = Enum.TextXAlignment.Left, T.Dim, T.Font, 13
                
                local tb = Instance.new("TextBox", f)
                tb.Size, tb.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 18)
                tb.BackgroundColor3, tb.BorderColor3, tb.Text, tb.PlaceholderText = T.Dark, T.Stroke, def or "", "Enter..."
                tb.TextColor3, tb.Font, tb.TextSize = T.Text, T.Font, 12
                tb.FocusLost:Connect(function() if cb then cb(tb.Text) end end)
                return G
            end
            
            function G:ConfigDropdown(text)
                local f = Instance.new("Frame", cnt)
                f.Size, f.BackgroundTransparency, f.ClipsDescendants, f.ZIndex = UDim2.new(1, 0, 0, 40), 1, false, 10
                
                local lbl = Instance.new("TextLabel", f)
                lbl.Text, lbl.Size, lbl.BackgroundTransparency = text, UDim2.new(1, 0, 0, 15), 1
                lbl.TextXAlignment, lbl.TextColor3, lbl.Font, lbl.TextSize = Enum.TextXAlignment.Left, T.Dim, T.Font, 13
                
                local box = Instance.new("TextButton", f)
                box.Size, box.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 18)
                box.BackgroundColor3, box.BorderColor3 = T.Dark, T.Stroke
                box.Text, box.TextColor3, box.Font, box.TextSize = (Cfg.Selected ~= "" and Cfg.Selected or "Select...") .. " ▼", T.Text, T.Font, 13
                R.cfgDropdown = box
                
                local ol = Instance.new("Frame", f)
                ol.Size, ol.Position = UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 0, 38)
                ol.BackgroundColor3, ol.BorderColor3, ol.Visible, ol.ZIndex = T.Darker, T.Stroke, false, 100
                Instance.new("UIListLayout", ol)
                R.cfgDropdownList = ol
                
                local open = false
                box.MouseButton1Click:Connect(function()
                    open = not open ol.Visible = open
                    if open then UpdateCfgDropdown() f.Size = UDim2.new(1, 0, 0, 40 + MAX(20, #Cfg.List * 20)) else f.Size = UDim2.new(1, 0, 0, 40) end
                end)
                UpdateCfgDropdown()
                return G
            end
            
            function G:Label(text)
                local lbl = Instance.new("TextLabel", cnt)
                lbl.Size, lbl.BackgroundTransparency = UDim2.new(1, 0, 0, 16), 1
                lbl.Text, lbl.TextXAlignment = text, Enum.TextXAlignment.Left
                lbl.TextColor3, lbl.Font, lbl.TextSize = T.Accent, T.Font, 11
                return G, lbl
            end
            
            return G
        end
        
        return TL
    end

    return Tabs
end


-- ========== BUILD UI ==========
local Win = Lib:Create("Crack By Lvzz")

-- RAGE TAB
do
    local Tab = Win:NewTab("Rage")

    local rb = Tab:NewGroupbox("Left", "Ragebot")
    rb:Toggle("Enable", S.rbEnabled, function(v) S.rbEnabled = v ApplySettings() end)
    rb:Toggle("Resolver", S.rbResolver, function(v) S.rbResolver = v end)
    rb:Toggle("Prediction", S.rbPrediction, function(v) S.rbPrediction = v end)
    rb:Toggle("Auto Fire", S.rbAutoFire, function(v) S.rbAutoFire = v end)
    rb:Toggle("Team Check", S.rbTeamCheck, function(v) S.rbTeamCheck = v end)
    rb:Dropdown("Hitbox", {"Head", "Torso"}, S.rbHitbox, function(v) S.rbHitbox = v end)
    rb:Toggle("Wall Check", S.rbWallCheck, function(v) S.rbWallCheck = v end)
    rb:Toggle("No Air Shot", S.rbNoAir, function(v) S.rbNoAir = v end)
    rb:Toggle("Smart Aim", S.rbSmartAim, function(v) S.rbSmartAim = v end)
    rb:Slider("Max Distance", 100, 1000, S.rbMaxDist, function(v) S.rbMaxDist = v end)
    rb:Slider("Fire Rate", 1, 20, S.rbFireRate * 100, function(v) S.rbFireRate = v / 100 end)
    rb:Slider("Prediction Multi", 50, 200, S.rbPredMulti * 100, function(v) S.rbPredMulti = v / 100 end)

    local as = Tab:NewGroupbox("Left", "Air Shoot")
    as:Toggle("Enable", S.rbAirShoot, function(v) S.rbAirShoot = v if not v then AS_RemovePart() end ApplySettings() end)
    as:Keybind("Toggle Key", S.rbAirShootKey, function(k) S.rbAirShootKey = k end)
    as:Toggle("AimView Line", S.avEnabled, function(v) S.avEnabled = v if not v then AV_RemoveLine() end end)

    local dt = Tab:NewGroupbox("Right", "Double Tap")
    dt:Toggle("Enable", S.dtEnabled, function(v) S.dtEnabled = v ApplySettings() end)
    dt:Keybind("Key", S.dtKey, function(k) S.dtKey = k end)
    dt:Slider("TP Distance", 3, 10, S.dtDist, function(v) S.dtDist = v end)
    dt:Dropdown("Mode", {"Defensive", "Offensive", "Off"}, S.dtMode, function(v) S.dtMode = v end)

    local ap = Tab:NewGroupbox("Right", "AI Peek v6")
    ap:Toggle("Enable", S.apEnabled, function(v) 
        S.apEnabled = v 
        if not v and R.apActive then AP_Disable() end 
    end)
    ap:Keybind("Key", S.apKey, function(k) S.apKey = k end)
    ap:Dropdown("Mode", {"Hold", "Toggle"}, S.apMode, function(v) S.apMode = v end)
    ap:Toggle("Show Points", S.apShowPoints, function(v) 
        S.apShowPoints = v 
        if R.apActive then AP_RemovePoints() AP_CreatePoints() end 
    end)
    ap:Toggle("ESP Outline", S.apESP, function(v) 
        S.apESP = v 
        if R.apActive then AP_UpdateESP() end 
    end)
    ap:Toggle("Team Check", S.apTeamCheck, function(v) S.apTeamCheck = v end)
    ap:Slider("Range", 10, 200, S.apRange, function(v) S.apRange = v end)
    ap:Slider("Peek Distance", 2, 25, S.apPeekDist, function(v) 
        S.apPeekDist = v 
        if R.apActive then AP_RemovePoints() AP_CreatePoints() end 
    end)
    ap:Slider("Max Height", 1, 10, S.apHeight, function(v) S.apHeight = v end)
    
    local _, apCooldownLabel = ap:Label("Cooldown: " .. AP_GetCooldownMs() .. "ms (" .. AP_GetSpeedMode() .. ")")
    ap:Slider("Speed", 0, 1000, S.apSpeed, function(v) 
        S.apSpeed = v 
        if apCooldownLabel then
            apCooldownLabel.Text = "Cooldown: " .. AP_GetCooldownMs() .. "ms (" .. AP_GetSpeedMode() .. ")"
        end
    end)
    
    ap:Slider("Rings", 1, 5, S.apRings, function(v) 
        S.apRings = v 
        if R.apActive then AP_RemovePoints() AP_CreatePoints() end 
    end)
    ap:Slider("Points/Ring", 4, 16, S.apPointsPerRing, function(v) 
        S.apPointsPerRing = v 
        if R.apActive then AP_RemovePoints() AP_CreatePoints() end 
    end)
end

-- AA TAB
do
    local Tab = Win:NewTab("AA")

    local fd = Tab:NewGroupbox("Left", "Fakeduck")
    fd:Toggle("Enable", S.fdEnabled, function(v) if v ~= S.fdEnabled then ToggleFakeduck() end end)
    fd:Toggle("Team Check", S.fdTeamCheck, function(v) S.fdTeamCheck = v end)
    fd:Keybind("Toggle Key", S.fdKey, function(k) S.fdKey = k end)
    fd:Keybind("Lock Key", S.fdLockKey, function(k) S.fdLockKey = k end)

    local info = Tab:NewGroupbox("Right", "Info")
    info:Button("Fakeduck Info", function() print("[Crack By Lvzz] Fakeduck automatically crouches when no enemy is visible") end)
end


-- VISUALS TAB
do
    local Tab = Win:NewTab("Visuals")

    local wm = Tab:NewGroupbox("Left", "Watermark")
    wm:Toggle("Show Watermark", true, function(v) S.wmVisible = v if R.wmFrame then R.wmFrame.Visible = v end end)

    local hk = Tab:NewGroupbox("Left", "Hotkey List")
    hk:Toggle("Show Hotkeys", true, function(v) S.hkVisible = v if R.hkFrame then R.hkFrame.Visible = v end end)

    local tm = Tab:NewGroupbox("Left", "Time Display")
    tm:Toggle("Show Time", true, function(v) S.timeVisible = v if R.timeFrame then R.timeFrame.Visible = v end end)

    local hl = Tab:NewGroupbox("Left", "Hit Logger")
    hl:Toggle("Enable", S.hlEnabled, function(v) S.hlEnabled = v if R.hlFrame then R.hlFrame.Visible = v end end)
    hl:Slider("Max Logs", 4, 15, S.hlMaxLogs, function(v) S.hlMaxLogs = v end)

    local ke = Tab:NewGroupbox("Left", "Kill Effects")
    ke:Toggle("Enable", S.killEffects, function(v) S.killEffects = v end)
    ke:Dropdown("Screen Type", {"CS:GO", "Flash", "Vignette", "Skull", "HvH", "None"}, S.killScreenType or "CS:GO", function(v) S.killScreenType = v end)
    ke:Dropdown("Screen Color", {"Red", "Blue", "Green", "Purple", "Cyan", "Yellow", "White", "Pink"}, S.killScreenColor or "Red", function(v) S.killScreenColor = v end)
    ke:Slider("Duration (ms)", 50, 5000, FLOOR((S.killScreenDuration or 0.5) * 1000), function(v) S.killScreenDuration = v / 1000 end)
    ke:Dropdown("Particles", {"Binary", "Matrix", "Hex", "Code", "Glitch", "Numbers"}, S.killParticleType, function(v) S.killParticleType = v end)
    ke:Toggle("Ghost Effect", S.ghostEffectEnabled, function(v) S.ghostEffectEnabled = v end)
    ke:Dropdown("Ghost Color", {"Cyan", "Red", "Green", "Purple", "White", "Pink"}, "Cyan", function(v)
        local colors = {
            Cyan = Color3.fromRGB(100, 200, 255),
            Red = Color3.fromRGB(255, 100, 100),
            Green = Color3.fromRGB(100, 255, 100),
            Purple = Color3.fromRGB(200, 100, 255),
            White = Color3.fromRGB(255, 255, 255),
            Pink = Color3.fromRGB(255, 150, 200)
        }
        S.ghostColor = colors[v] or Color3.fromRGB(100, 200, 255)
    end)

    local sc = Tab:NewGroupbox("Left", "Scope Crosshair")
    sc:Toggle("Enable", S.scopeEnabled, function(v) S.scopeEnabled = v ToggleScope(v) end)
    sc:Slider("Size", 5, 500, S.scopeSize, function(v) S.scopeSize = v if S.scopeEnabled then CreateScope() end end)
    sc:Slider("Gap", 0, 200, S.scopeGap, function(v) S.scopeGap = v if S.scopeEnabled then CreateScope() end end)
    sc:Slider("Thickness", 1, 5, S.scopeThickness, function(v) S.scopeThickness = v if S.scopeEnabled then CreateScope() end end)
    sc:Slider("Y Offset", -200, 200, S.scopeOffsetY, function(v) S.scopeOffsetY = v if S.scopeEnabled then CreateScope() end end)
    sc:Dropdown("Color", {"Red", "Cyan", "Green", "Yellow", "Purple", "White", "Pink"}, "Red", function(v)
        local colors = {
            Red = Color3.fromRGB(255, 50, 50),
            Cyan = Color3.fromRGB(50, 255, 255),
            Green = Color3.fromRGB(50, 255, 50),
            Yellow = Color3.fromRGB(255, 255, 50),
            Purple = Color3.fromRGB(200, 50, 255),
            White = Color3.fromRGB(255, 255, 255),
            Pink = Color3.fromRGB(255, 100, 200)
        }
        S.scopeColor = colors[v] or Color3.fromRGB(255, 50, 50)
        UpdateScopeColor()
    end)

    local vfx = Tab:NewGroupbox("Right", "Effects")
    vfx:Toggle("Bloom", false, function(v) S.bloomEnabled = v ApplyBloom() end)
    vfx:Slider("Bloom Intensity", 0, 50, 15, function(v) S.bloomIntensity = v / 10 ApplyBloom() end)
    vfx:Slider("Bloom Size", 0, 100, 40, function(v) S.bloomSize = v ApplyBloom() end)
    vfx:Toggle("Blur", false, function(v) S.blurEnabled = v ApplyBlur() end)
    vfx:Slider("Blur Size", 0, 24, 10, function(v) S.blurSize = v ApplyBlur() end)
    vfx:Toggle("Color Correction", false, function(v) S.colorEnabled = v ApplyColorCorrection() end)
    vfx:Toggle("Sun Rays", false, function(v) S.sunRaysEnabled = v ApplySunRays() end)
    vfx:Toggle("Fog", false, function(v) S.fogEnabled = v ApplyFog() end)
    vfx:Slider("Fog End", 100, 5000, 500, function(v) S.fogEnd = v ApplyFog() end)

    local mdl = Tab:NewGroupbox("Right", "Custom Model")
    mdl:Dropdown("Select Model", ModelList, "None", function(v) S.selectedModel = v end)
    mdl:Button("Apply Model", function() if S.selectedModel and S.selectedModel ~= "None" then ApplyModel(S.selectedModel) end end)
    mdl:Button("Remove Model", function() if getgenv().modelConn then getgenv().modelConn:Disconnect() getgenv().modelConn = nil end S.selectedModel = "None" if LP.Character then LP:LoadCharacter() end end)
end

-- EXPLOITS TAB
do
    local Tab = Win:NewTab("Exploits")

    local ep = Tab:NewGroupbox("Left", "Exploit Position")
    ep:Toggle("Enable", S.epEnabled, function(v) S.epEnabled = v if not v and R.epActive then EP_DestroyDecoy() end end)
    ep:Keybind("Key", S.epKey, function(k) S.epKey = k end)
    ep:Slider("Distance", 1, 10, S.epDist, function(v) S.epDist = v end)

    local ij = Tab:NewGroupbox("Left", "Infinity Jump")
    ij:Toggle("Enable", S.ijEnabled, function(v) S.ijEnabled = v if not v then IJ_RemovePart() end ApplySettings() end)
    ij:Keybind("Key", S.ijKey, function(k) S.ijKey = k end)

    local be = Tab:NewGroupbox("Right", "Barrel Extend")
    be:Toggle("Enable", S.beEnabled, function(v) S.beEnabled = v if not v and R.beActive then BE_Disable() end ApplySettings() end)
    be:Keybind("Key", S.beKey, function(k) S.beKey = k end)
    be:Dropdown("Mode", {"Hold", "Toggle"}, S.beMode, function(v) S.beMode = v end)
    be:Slider("Distance", 1, 10, S.beDist, function(v) S.beDist = v end)
end

-- MISC TAB
do
    local Tab = Win:NewTab("Misc")

    local bh = Tab:NewGroupbox("Left", "BunnyHop")
    bh:Toggle("Enable", S.bhEnabled, function(v)
        S.bhEnabled = v
        if v then
            R.bhOrigSpeed = R.myHum and R.myHum.WalkSpeed or 16
            R.bhInAir, R.bhLastReset, R.bhResetting = false, 0, false
            R.bhLastPos, R.bhPosCheckTime, R.bhCircling = nil, 0, false
            if R.myHum then R.myHum.WalkSpeed = S.bhGroundSpeed end
        elseif R.myHum then R.myHum.WalkSpeed = R.bhOrigSpeed end
        ApplySettings()
    end)
    bh:Keybind("Toggle Key", S.bhKey, function(k) S.bhKey = k end)
    bh:Slider("Ground Speed", 20, 50, S.bhGroundSpeed, function(v) S.bhGroundSpeed = v if S.bhEnabled and R.myHum and not R.bhInAir then R.myHum.WalkSpeed = v end end)
    bh:Slider("Air Speed", 20, 50, S.bhAirSpeed, function(v) S.bhAirSpeed = v if S.bhEnabled and R.myHum and R.bhInAir then R.myHum.WalkSpeed = v end end)

    local wp = Tab:NewGroupbox("Right", "Wallbang Helper")
    wp:Toggle("Enable", S.wbEnabled, function(v) S.wbEnabled = v if v then enableWallbangHelper() else disableWallbangHelper() end ApplySettings() end)
    wp:Button("Refresh Walls", function() if S.wbEnabled then disableWallbangHelper() task.wait(0.1) enableWallbangHelper() end end)

    local wm = Tab:NewGroupbox("Right", "Wallbang Map")
    wm:Toggle("Enable", S.wmEnabled, function(v) S.wmEnabled = v if v then enableWallbangMap() else disableWallbangMap() end R.hotkeys["WB Map"] = v and {active = true, key = "ON"} or nil UpdateHotkeyList() end)

    local rc = Tab:NewGroupbox("Right", "Remove Collision")
    rc:Toggle("Enable", S.rcEnabled, function(v) S.rcEnabled = v if v then enableRemoveCollision() else disableRemoveCollision() end ApplySettings() end)

    local tp = Tab:NewGroupbox("Left", "Teleport")
    tp:Toggle("Enable", S.tpEnabled, function(v) S.tpEnabled = v R.hotkeys["Teleport"] = v and {active = true, key = "ON"} or nil UpdateHotkeyList() end)
    tp:Keybind("CT Spawn", S.tpCTKey, function(k) S.tpCTKey = k end)
    tp:Keybind("T Spawn", S.tpTKey, function(k) S.tpTKey = k end)
end


-- SETTINGS TAB
do
    local Tab = Win:NewTab("Settings")

    local mn = Tab:NewGroupbox("Left", "Menu")
    mn:Keybind("Menu Key", S.menuKey, function(k) S.menuKey = k end)
    mn:Button("Unload Script", function()
        R.running = false
        StopMainLoop()
        if R.apActive then AP_Disable() end
        EP_Free()
        if R.beActive then BE_Disable() end
        AS_RemovePart()
        IJ_RemovePart()
        AV_RemoveLine()
        if S.bhEnabled and R.myHum then R.myHum.WalkSpeed = R.bhOrigSpeed or 16 end
        if S.wbEnabled then disableWallbangHelper() end
        if S.rcEnabled then disableRemoveCollision() end
        if S.wmEnabled then disableWallbangMap() end
        if R.bloomEffect then pcall(function() R.bloomEffect:Destroy() end) end
        if R.blurEffect then pcall(function() R.blurEffect:Destroy() end) end
        if R.colorEffect then pcall(function() R.colorEffect:Destroy() end) end
        if R.sunRaysEffect then pcall(function() R.sunRaysEffect:Destroy() end) end
        Light.FogStart, Light.FogEnd = 0, 100000
        for _, c in IPAIRS(R.conns) do pcall(function() c:Disconnect() end) end
        for _, e in IPAIRS(R.fx) do pcall(function() e:Destroy() end) end
        if R.gui then R.gui:Destroy() end
        if getgenv().modelConn then getgenv().modelConn:Disconnect() getgenv().modelConn = nil end
        print("[Crack By Lvzz] Script unloaded!")
    end)

    local cf = Tab:NewGroupbox("Right", "Configs")
    cf:ConfigDropdown("Select Config")
    local cfgInput = ""
    cf:TextBox("New Config Name", "", function(t) cfgInput = t end)
    cf:Button("Create & Save", function() if cfgInput ~= "" then SaveCfg(cfgInput) Cfg.Selected = cfgInput if R.cfgDropdown then R.cfgDropdown.Text = cfgInput .. " ▼" end UpdateCfgDropdown() end end)
    cf:Button("Save Current", function() if Cfg.Selected ~= "" then SaveCfg(Cfg.Selected) end end)
    cf:Button("Load Selected", function() if Cfg.Selected ~= "" then LoadCfg(Cfg.Selected) end end)
    cf:Button("Delete Selected", function() if Cfg.Selected ~= "" then DeleteCfg(Cfg.Selected) Cfg.Selected = "" if R.cfgDropdown then R.cfgDropdown.Text = "Select... ▼" end UpdateCfgDropdown() end end)
    cf:Button("Refresh List", function() UpdateCfgDropdown() end)

    local cr = Tab:NewGroupbox("Left", "Credits")
    cr:Button("Crack By Lvzz v6.1", function() end)
    cr:Button("Expires: 20.01.2027", function() end)
end

-- ========== TELEPORT FUNCTIONS ==========
function teleportTo(spawnName, childIndex)
    if not S.tpEnabled or not R.myHRP then return end
    pcall(function()
        local spawnPoint = WS:FindFirstChild(spawnName)
        if spawnPoint then
            local children = spawnPoint:GetChildren()
            if children[childIndex] then
                local target = children[childIndex]
                local targetCF = target:IsA("BasePart") and target.CFrame or (target.PrimaryPart and target.PrimaryPart.CFrame)
                if targetCF then R.myHRP.CFrame = targetCF + V3(0, 3, 0) end
            end
        end
    end)
end

-- ========== INPUT HANDLER ==========
local dtKeyHeld = false
local DT_DIR_KEYS = {[Enum.KeyCode.Up] = "Forward", [Enum.KeyCode.Down] = "Back", [Enum.KeyCode.Left] = "Left", [Enum.KeyCode.Right] = "Right"}

INSERT(R.conns, UIS.InputBegan:Connect(function(i, gpe)
    if gpe then return end
    local key = i.KeyCode

    if key == S.menuKey then
        R.visible = not R.visible
        if R.main then R.main.Visible = R.visible end
        for _, e in IPAIRS(R.fx) do pcall(function() e:Destroy() end) end
        R.fx = {}
        if R.visible then
            local blur = Instance.new("DepthOfFieldEffect")
            blur.FarIntensity, blur.FocusDistance, blur.InFocusRadius, blur.NearIntensity = 0.6, 50, 50, 0.6
            blur.Parent = Light
            R.fx[1] = blur
        end
        return
    end

    if S.dtEnabled and key == S.dtKey then
        if S.dtMode == "Offensive" then dtKeyHeld = true else DT_Peek(nil) end
        return
    end

    if S.dtEnabled and S.dtMode == "Offensive" and dtKeyHeld and DT_DIR_KEYS[key] then
        DT_Peek(DT_DIR_KEYS[key])
        return
    end

    if S.apEnabled and key == S.apKey then
        if S.apMode == "Hold" then 
            if not R.apActive then AP_Enable() end
        else
            if R.apActive then AP_Disable() else AP_Enable() end
        end
        return
    end

    if S.epEnabled and key == S.epKey then
        if R.epActive then EP_DestroyDecoy() else EP_SpawnDecoy() end
        return
    end

    if S.beEnabled and key == S.beKey then
        if S.beMode == "Hold" then if not R.beActive then BE_Enable() end
        elseif R.beActive then BE_Disable() else BE_Enable() end
        return
    end

    if S.ijEnabled and key == S.ijKey and R.ijCanJump and R.myHum then
        R.myHum:ChangeState(Enum.HumanoidStateType.Jumping)
        return
    end

    if key == S.rbAirShootKey then
        S.rbAirShoot = not S.rbAirShoot
        if not S.rbAirShoot then AS_RemovePart() end
        ApplySettings()
        return
    end

    if key == S.fdKey then ToggleFakeduck() return end
    if key == S.fdLockKey then R.fdLock = true return end

    if key == S.bhKey then
        S.bhEnabled = not S.bhEnabled
        if S.bhEnabled then
            R.bhOrigSpeed = R.myHum and R.myHum.WalkSpeed or 16
            R.bhInAir, R.bhLastReset, R.bhResetting = false, 0, false
            R.bhLastPos, R.bhPosCheckTime, R.bhCircling = nil, 0, false
            if R.myHum then R.myHum.WalkSpeed = S.bhGroundSpeed end
        elseif R.myHum then R.myHum.WalkSpeed = R.bhOrigSpeed end
        ApplySettings()
        return
    end

    if S.tpEnabled then
        if key == S.tpCTKey then teleportTo("CTSpawn", 4) return end
        if key == S.tpTKey then teleportTo("TSpawn", 5) return end
    end
end))

INSERT(R.conns, UIS.InputEnded:Connect(function(i, gpe)
    if gpe then return end
    local key = i.KeyCode

    if key == S.dtKey then dtKeyHeld = false return end
    if S.apEnabled and key == S.apKey and S.apMode == "Hold" then AP_Disable() return end
    if S.beEnabled and key == S.beKey and S.beMode == "Hold" then BE_Disable() return end
    if key == S.fdLockKey then R.fdLock = false return end
end))


-- ========== CHARACTER RESPAWN HANDLER ==========
INSERT(R.conns, LP.CharacterAdded:Connect(function()
    R.myChar, R.myHRP, R.myHead, R.myHum = nil, nil, nil, nil
    R.fireShot, R.playerData = nil, {}
    R.playerDataTime, R.fireShotTime = 0, 0
    R.bhInAir, R.bhLastReset, R.bhResetting = false, 0, false
    R.bhLastPos, R.bhPosCheckTime, R.bhCircling = nil, 0, false

    if R.apActive then AP_Disable() end
    R.apTeleporting = false
    EP_Free()
    AS_RemovePart()
    if R.beActive then BE_Disable() end
    IJ_RemovePart()
    AV_RemoveLine()

    task.wait(0.5)
    CacheChar()

    if S.bhEnabled and R.myHum then 
        R.bhOrigSpeed = R.myHum.WalkSpeed or 16 
        R.myHum.WalkSpeed = S.bhGroundSpeed 
    end
    if S.fdEnabled then 
        S.fdEnabled = false 
        R.fdIdleAnim, R.fdWalkAnim = nil, nil 
        task.wait(0.5) 
        ToggleFakeduck() 
    end
    if S.wbEnabled then task.delay(1, enableWallbangHelper) end
    if S.rcEnabled then task.delay(1, enableRemoveCollision) end
    if S.wmEnabled then task.delay(1, enableWallbangMap) end
end))

-- ========== INIT ==========
CacheChar()
EnsureCfgFolder()
RefreshCfg()

if #Cfg.List > 0 then
    Cfg.Selected = Cfg.List[1]
    if R.cfgDropdown then R.cfgDropdown.Text = Cfg.Selected .. " ▼" end
end

local blur = Instance.new("DepthOfFieldEffect")
blur.FarIntensity, blur.FocusDistance, blur.InFocusRadius, blur.NearIntensity = 0.6, 50, 50, 0.6
blur.Parent = Light
R.fx[1] = blur

task.spawn(SetupKillTracking)

print("[Crack By Lvzz] Script loaded successfully! (AI Peek v6)")
print("[Crack By Lvzz] Press " .. S.menuKey.Name .. " to toggle menu")
