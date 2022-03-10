local IsJailbreak = (game.PlaceId == 606849621)
local getupvalue = getupvalue or debug and debug.getupvalue or false
local getupvalues = getupvalues or debug and debug.getupvalues or false
local setupvalue = setupvalue or debug and debug.setupvalue or false
local getconstants = getconstants or debug and debug.getconstants or false
local setconstant = setconstant or debug and debug.setconstant or false
local getproto = getproto or debug and debug.getproto or false
local traceback = traceback or debug and debug.traceback or false
local request = request or http_request or syn and syn.request or false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local decoded = HttpService:JSONDecode(request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body);
local hwid_list = {"Syn-Fingerprint", "Exploit-Guid", "Proto-User-Identifier", "Sentinel-Fingerprint", "Krnl-Hwid"};
local HWID;
for i, v in next, hwid_list do
    if decoded.headers[v] then
        HWID = decoded.headers[v];
        break
    end
end
local blacklisted = {
    "1494e0cda70536e83f33127bb4038ef2e4e73b5eb530fc6c25fa36fc77848de66c8239f05b214dc286940edb4128405966009c338821d2854db67206a4c6a87f"
}
local Exploit = secure_load and "Sentinel" or pebc_execute and "ProtoSmasher" or is_sirhurt_closure and "Sirhurt" or (syn and not is_sirhurt_closure) and "Synapse X" or KRNL_LOADED and "Krnl"
local IsSiff = HWID == ""
local Version = "2.1.7"
local HasAll = (getupvalue and getupvalues and setupvalue and getconstants and setconstant and getproto and traceback) and true or false
local function Notification(text) return require(ReplicatedStorage.Game.Notification).new({Text = text}) end
local function LoadTesla()
    local Sucess, Toggle = pcall(function()
		if KRNL_LOADED then
			return {}
		end
        local File = readfile("Tesla.json")
        return HttpService:JSONDecode(File)
    end)
    if not Sucess then
        Toggle = {}
        writefile("Tesla.json", HttpService:JSONEncode(Toggle))
    end
    local NiggaToggle = {
        ClickTp = Toggle.ClickTp or false,
        NoWait = Toggle.NoWait or false,
        OpenDoors = Toggle.OpenDoors or false,
        NoClip = Toggle.NoClip or false,
        AntiArrest = Toggle.AntiArrest or false,
        Autobreakout = Toggle.Autobreakout or false,
        OPM = Toggle.OPM or false,
        Eject = Toggle.Eject or false,
        GodMode = Toggle.GodMode or false,
        AntiRagdoll = Toggle.AntiRagdoll or false,
        TeamSwitchCD = Toggle.TeamSwitchCD or false,
        CellTime = Toggle.CellTime or false,
        FlySpeed = Toggle.FlySpeed or 50,
        AntiFlip = Toggle.AntiFlip or false,
        MobileGarage = Toggle.MobileGarage or false,
        AutoPilot = Toggle.AutoPilot or false,
        InjanHorn = Toggle.InjanHorn or false,
        RainbowCar = Toggle.RainbowCar or false,
        TazeAll = Toggle.TazeAll or false,
        TazeAura = Toggle.TazeAura or false,
        Autorob = Toggle.Autorob or false,
        ClickDestroy = Toggle.ClickDestroy or false,
        Nuke = Toggle.Nuke or false,
        Annoy = Toggle.Annoy or false,
        Hats = Toggle.Hats or false,
        KillAura = Toggle.KillAura or false,
        KillAuraLTP = Toggle.KillAuraLTP or false,
        TirePop = Toggle.TirePop or false,
        RainbowUI = Toggle.RainbowUI or false,
        AutoArrest = Toggle.AutoArrest or false
    }
    getrenv().lmao = function() return 0/0 end
    local Client = {}
    Client.Hashes = {}
    Client.Doors = {}
    Client.Constants = {}
    Client.TouchTrigger = {}
    for i, v in pairs(getgc(true)) do
        if type(v) == "table" then
            if rawget(v, "Event") and rawget(v, "Fireworks") then
                Client.em = v.em
                Client.Network = v.Event
                Client.Fireworks = v.Fireworks
                Client.GetVehiclePacket = v.GetVehiclePacket
            elseif rawget(v, "OpenFun") and rawget(v, "State") then
                table.insert(Client.Doors, v)
            elseif rawget(v, "ItemData") then
                Client.Guns = v.ItemData
            elseif rawget(v, "Ragdoll") then
                Client.Falling = v
            elseif rawget(v, "t") and rawget(v, "i") and type(rawget(v, "c")) == "function" then
                if v.i == 0.1 then
                    local con = getconstants(v.c)
                    if table.find(con, "Eject") and table.find(con, "MouseButton1Down") then
                        Client.Constants.Eject = getconstants(getproto(v.c, 1))
                    end
                elseif v.i == 1 and type(getupvalue(v.c, 2)) == "boolean" then
                    setupvalue(v.c, 2, true)
                end
            elseif rawget(v, "VehiclesOwned") then
                Client.VehiclesOwned = v.VehiclesOwned
            elseif rawget(v, "Part") and type(rawget(v, "Fun")) == "function" then
                if v.Part.Name == "Donut" then
                    Client.GiveDonut = v.Fun 
                elseif v.Part.Name == "JetPackGiver" then
                    Client.GiveJetPack = v.Fun
                end
            elseif type(rawget(v, "Heli")) == "table" then
                Client.Vehicle = v
            end
        elseif type(v) == "function" then
            if getfenv(v).script == LocalPlayer.PlayerScripts.LocalScript then -- fetching localscript functions
                local con = getconstants(v)
                if table.find(con, "hems") and #con == 1 then
                    Client.AllHashes = getupvalue(v, 2)
                elseif table.find(con, "SequenceRequireState") then
                    Client.OpenDoor = v
                elseif table.find(con, "LastVehicleExit") and table.find(con, "tick") then
                    Client.ExitCar = v
                    Client.Constants.ExitCar = con
                elseif table.find(con, "NitroLoop") and table.find(con, "Nitro1") then
                    Client.Nitro = v
                elseif table.find(con, "Punch") then
                    Client.OnAction = v
                elseif table.find(con, "Play") and table.find(con, "Source") and table.find(con, "FireServer") then
                    Client.PlaySound = v
                elseif table.find(con, "ShouldBreakout") and #con == 3 then
                    Client.PoliceFunction = v
                elseif table.find(con, "PlusCash") then
                    Client.PlusCash = v
                elseif table.find(con, "math") and table.find(con, "Random") and #con == 3 then
                    Client.RandomF = v
                elseif table.find(con, "Pick up %s") and not table.find(con, "briefcase") then
                    Client.PickItem = getupvalue(v, 1)
                end
            elseif getfenv(v).script == ReplicatedStorage.Game.TeamChooseUI then -- fetching teamscript functions
                local con = getconstants(v)
                if table.find(con, "delay") and table.find(con, "assert") then
                    local a = getproto(v, 6)
                    Client.Constants.TeamChange = getconstants(a)
                end
            elseif getfenv(v).script == ReplicatedStorage.Game.Inventory then -- fetching inventory function (godmode)
                local con = getconstants(v)
                if table.find(con, "GetLocalVehiclePacket") then
                    Client.Unequip = v
                end
            elseif getfenv(v).script == ReplicatedStorage.Game.Garage.GarageUI then -- fetching garage function
                local con = getconstants(v)
                local modifycon = getconstants(getproto(require(ReplicatedStorage.Game.Garage.GarageUI).Init,1))
                if unpack(con) == unpack(modifycon) then
                    Client.ModifyCar = v
                elseif table.find(con, "Type") and table.find(con, "Make") and table.find(con, "FireServer") then
                    Client.SpawnVehicle = v
                end
            elseif getfenv(v).script == ReplicatedStorage.Game.GunShop then -- fetching gunshop function
                local con = getconstants(v)
                if table.find(con, "CanGrab") and table.find(con, "FireServer") then
                    Client.GiveGun = v
                end
            elseif getfenv(v).script == ReplicatedStorage.Game.NukeControl then -- fetching nukecontrol
                local con = getconstants(v)
                if table.find(con, "Nuke") and table.find(con, "Shockwave") then
                    Client.Nuke = v
                end
            end
        end
    end
    Client.GetLocalEquipped = require(ReplicatedStorage.Game.ItemSystem.ItemSystem).GetLocalEquipped
    Client.Arrest = getupvalue(getupvalue(Client.PoliceFunction,1),7)
    Client.BreakOut = getupvalue(getupvalue(Client.PoliceFunction,3),2)
    Client.PickPocket = getupvalue(getupvalue(Client.PoliceFunction,2),2)
    Client.Hashes.ExitCar = (function()
        local const = {}
        for i,v in pairs(Client.Constants.ExitCar) do
            if i < table.find(Client.Constants.ExitCar, "FireServer") and v~="sub" and v~="reverse" then
                table.insert(const,v)
            end
        end
        local go1 = tostring(const[1])
        local go2 = tostring(const[tonumber(table.maxn(const))])
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, go1) and string.find(i, go2) and go1:sub(1,1) == i:sub(1,1) and go2:sub(#go2,#go2) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.EatDonut = (function()
        local con = getconstants(getproto(require(ReplicatedStorage.Game.Item.Donut).InputBegan, 1))
        local dntconst = {}
            for i,v in pairs(con) do
            if i > table.find(con, "LastConsumed") and i < table.find(con, "FireServer") and v~= "sub" and v ~= "reverse" then
                table.insert(dntconst, v)
            end
        end
        local da = dntconst[1]
        local db = dntconst[table.maxn(dntconst)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, da) and string.find(i, db) and da:sub(1,1) == i:sub(1,1) and db:sub(#db,#db) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.TeamChange = (function()
        local tcon = {}
        for i, v in pairs(Client.Constants.TeamChange) do
            if type(v) == "string" and v ~= "Police" and v ~= "Prisoner" and v ~= "sub" and v ~= "reverse" and v ~= "assert" and v ~= "FireServer" then
                table.insert(tcon, v)
            end
        end
        local taa = tcon[1]
        local tbb = tcon[table.maxn(tcon)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, taa) and string.find(i, tbb) and taa:sub(1,1) == i:sub(1,1) and tbb:sub(#tbb,#tbb) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.Eject = (function()
        local Kcon2 = {}
        for i, v in pairs(Client.Constants.Eject) do
            if type(v) == "string" and v ~= "FireServer" then
                table.insert(Kcon2, v)
            end
        end
        local ka = Kcon2[1]
        local kb = Kcon2[table.maxn(Kcon2)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, ka) and string.find(i, kb) and ka:sub(1,1) == i:sub(1,1) and kb:sub(#kb,#kb) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.Taze = (function()
        local ta = getconstants(require(ReplicatedStorage.Game.Item.Taser).Tase)
        local taa = {}
        for i,v in pairs(ta) do
            if i > table.find(ta, "GetPlayerFromCharacter") and i < table.find(ta, "Name") and v~= "sub" and v ~= "reverse" then
                table.insert(taa, v)
            end
        end
        local tb = taa[1]:sub(1,1)
        local tc = taa[table.maxn(taa)]
        for i,v in pairs(Client.AllHashes) do
            if string.find(i, tb) and string.find(i, tc) and tb:sub(1,1) == i:sub(1,1) and tc:sub(#tc,#tc) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.Equip = (function()
        local const = {}
        local bruhcon = getconstants(require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Equip)
        for i,v in pairs(bruhcon) do
            if i > table.find(bruhcon, "Fire") and i < table.find(bruhcon, "FireServer") then
                table.insert(const, v)
            end
        end
        local da = const[1]
        local db = const[table.maxn(const)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, da) and string.find(i, db) and da:sub(1,1) == i:sub(1,1) and db:sub(#db,#db) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.Damage = (function()
        local const = {}
        local bruhcon = getconstants(require(ReplicatedStorage.Game.Item.PlasmaPistol).ShootOther)
        for i,v in pairs(bruhcon) do
            if i > table.find(bruhcon, "FindFirstChild") and i < table.find(bruhcon, "FireServer") then
            table.insert(const, v)
            end
        end
        local da = const[1]
        local db = const[table.maxn(const)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, da) and string.find(i, db) and da:sub(1,1) == i:sub(1,1) and db:sub(#db,#db) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    Client.Hashes.GrabCrate = (function()
        local const = {}
        local con = getconstants(Client.Vehicle.Heli.Update)
        for i,v in pairs(con) do
            if i > table.find(con, "PointToObjectSpace") and i < table.find(con, "FireServer") then
                table.insert(const, v)
            end
        end
        local da = const[1]
        local db = const[table.maxn(const)]
        for i, v in pairs(Client.AllHashes) do
            if string.find(i, da) and string.find(i, db) and da:sub(1,1) == i:sub(1,1) and db:sub(#db,#db) == i:sub(#i,#i) then
                return i
            end
        end
    end)()
    local function zigzag(X) 
        return math.acos(math.cos(X*math.pi))/math.pi 
    end
    local function hasprop(object, prop)
        local a, b = pcall(function()
            return object[tostring(prop)]
        end)
        if a then
            return b
        end
        return nil
    end
    local function RandomSeat()
        for i, v in pairs(require(game:GetService('ReplicatedStorage').Module.UI).CircleAction.Specs) do
            if v.Name == "Enter Passenger" then
                v:Callback(true)
                return
            end
        end
    end
    local function TP(cframe)
        if Client.GetVehiclePacket() then
            if Client.GetVehiclePacket().Model.Name ~= "Volt" or Client.GetVehiclePacket().Model.Name ~= "Patrol" then
                Client.GetVehiclePacket().Model:SetPrimaryPartCFrame(cframe);
                return
            else
                LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = cframe
                return
            end
        else
            RandomSeat()
            wait(0.2)
            Client.ExitCar()
            wait(0.2)
            LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = cframe
            return
        end
    end
    local function Punch(num)
        setconstant(Client.OnAction, 16, "lmao")
        for i = 1, num do
            Client.OnAction({Name = "Punch"}, true)
        end
        setconstant(Client.OnAction, 16, "tick")
    end
    local function Equip(name)
        if _G.thing then
            require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Equip(LocalPlayer, _G.thing)
            return
        end
        for i,v in pairs(getgc(true)) do
            if type(v) == "table" and rawget(v, 'i') and rawget(v, 'Frame') and rawget(v, 'Name') then
                if v.Name == name then
                    _G.thing = v
                end
            end
        end
        require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Equip(LocalPlayer, _G.thing)
        return
    end
    local Colors = {}
    for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.Color).Items) do
        table.insert(Colors, v.Name)
    end
    local hatclick = (function()
        for i,v in pairs(workspace.Givers:GetChildren()) do
            if v.Name == 'Station' then
                if v:FindFirstChild("Item").Value == 'HatPolice' then
                    return v.ClickDetector
                end
            end
        end
    end)()
    local function firehatoff()
        fireclickdetector(hatclick)
        local Hat = LocalPlayer.Character:FindFirstChild("HatPolice")
        if Hat then
            Hat.Parent = workspace
        end
    end
    local function Taze(plr)
        pcall(function()
            if not plr:IsA("Player") then return end
            if plr.Character then
                Client.Network:FireServer(Client.Hashes.Taze, plr.Name, plr.Character:WaitForChild('HumanoidRootPart'), plr.Character:WaitForChild('HumanoidRootPart').Position)
            end
        end)
    end
    local function FormatMoney(n)
        local n = tostring(n)
        local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
        return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
    end
    require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Fake = function() return end
    local function SendNotification(title, text, time)
        game.StarterGui:SetCore("SendNotification", {
            Title = title;
            Text = text; 
            Duration = time; 
        })
    end
    --if #getupvalues(Client.Network.FireServer) ~= 1 then -- Anti Spy
        --while true do end
    --end
    local oldFS = getupvalue(Client.Network.FireServer, 1);
    setupvalue(Client.Network.FireServer, 1, function(...)
        local args = {...}
        if AddingHash and checkcaller() then
            Client.Hashes[CurrentName] = Hash
            CurrentName = ""
            AddingHash = false
            return function() end
        end
        if getfenv(Client.Network.FireServer) ~= getfenv(2) then
            --while true do end
        elseif args[2] and type(args[2]) == "number" and string.find(traceback(), "Falling") and NiggaToggle.AntiRagdoll then
            return false
        elseif args[2] and type(args[2]) == "table" and args[2]["Name"] == "Cuffed" and NiggaToggle.AntiArrest then
            if NiggaToggle.Autorob and _G.AutoRobbing then
                _G.AutoRobbing = false
            end
            return require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip(), Client.BreakOut(LocalPlayer)
        elseif string.find(traceback(), "CargoShipCoordinator") and NiggaToggle.TirePop or string.find(traceback(), "CargoShipCoordinator") and NiggaToggle.Autorob then
            return false
        end;
        return oldFS(...);
    end);
    local oldRagdoll = Client.Falling.Ragdoll
    Client.Falling.Ragdoll = function(...)
        if NiggaToggle.AntiRagdoll then
            return wait(9e9)
        end
        return oldRagdoll(...)
    end
    local whitelisted = {}
    local LoopEject = {}
    local locations = {
        Stores = {
            ['Jewelry Out'] = CFrame.new(156.103851, 18.540699, 1353.72388),
            ['Jewelry In'] = CFrame.new(133.300705, 17.9375954, 1316.42407),
            ['Bank Out'] = CFrame.new(11.6854906, 17.8929214, 788.188171),
            ['Bank In'] = CFrame.new(24.6513691, 19.4347649, 853.291687),
            ['Museum Out'] = CFrame.new(1103.53406, 138.152878, 1246.98511),
            ['Museum In'] = CFrame.new(1071.72, 102.8, 1191.9),
            ['Donut Shop'] = CFrame.new(270.763885, 18.4229183, -1762.90149),
            ['Gas Station'] = CFrame.new(-1584.1051, 18.4732189, 721.38739),
            ['Power Plant'] = CFrame.new(691.559326, 37.6575089, 2362.05591),
        },
    
        Locations = {
            ['Prison Cells'] = CFrame.new(-1461.07605, -0.318537951, -1824.14917),
            ['Prison Yard'] = CFrame.new(-1219.36316, 17.7750931, -1760.8584),
            ['Prison Sewer'] = CFrame.new(-1050.70667, 0.7002424, -1498.72766),
            ['Prison Parking'] = CFrame.new(-1173.36951, 18.698061, -1533.47656),
            ['Gun Shop'] = CFrame.new(-27.8670673, 17.7929249, -1774.66882),
            ['1M Shop'] = CFrame.new(388.804688, 17.5929279, -1701.1698),
            ['Volcano Base'] = CFrame.new(1726.72266, 50.4146309, -1745.76196),
            ['City Base'] = CFrame.new(-244.824478, 17.8677788, 1573.81616),
            ['Police HQ1'] = CFrame.new(-1134.69604, 17.9251575, -1586.79395),
            ['Police HQ2'] = CFrame.new(738.103577, 38.1275024, 1134.48059),
            ['Military Base'] = CFrame.new(766.283386, 18.0144463, -324.15921),
            ['Evil Lair'] = CFrame.new(1735.52405, 18.1646328, -1726.05249),
            ['Secret Agent Base'] = CFrame.new(1506.60754, 69.8824005, 1634.42456),
            ['Garage'] = CFrame.new(-336.791779, 18.2407684, 1137.49451),
            ['Glider Shop'] = CFrame.new(137.43399, 18.1547852, -1768.24658),
            ['Lookout'] = CFrame.new(1328.05725, 166.614426, 2609.93457),
            ['Airport'] = CFrame.new(-1227.47449, 64.4552231, 2787.64233),
            ['Boat Cave'] = CFrame.new(1870.72498, 31.4386101, 1896.98865),
            ['Port'] = CFrame.new(-423.029663, 21.2136765, 2023.55713),
            ['Volcano Inside'] = CFrame.new(1704.46484, 25.0370979, -1775.46484),
        },
    
        Vehicles = {
            ['Prison Camaro'] = CFrame.new(-951.755493, 18.5451126, -1446.42664),
            ['Lamborghini'] = CFrame.new(146.728821, 17.5929279, 774.655396),
            ['Chiron'] = CFrame.new(241.109451, 17.6066723, 1362.49316),
            ['McLaren'] = CFrame.new(597.850708, 37.712925, 1649.81897),
            ['Pickup Truck'] = CFrame.new(-1543.02686, 18.3732185, 721.518494),
            ['Model3'] = CFrame.new(-117.721481, 17.5907402, 547.516052),
            ['Roadster'] = CFrame.new(-122.155197, 18.2636452, 520.741638),
            ['Mini Cooper'] = CFrame.new(760.116577, 17.8929214, -1228.13806),
            ['Dirtbike'] = CFrame.new(1643.61707, 18.8864899, 233.026291),
            ['SUV'] = CFrame.new(-1066.26172, 18.6751556, -1476.00732),
            ['Dune Buggy'] = CFrame.new(580.013916, 17.1554928, -458.795807),
            ['ATV'] = CFrame.new(-1452.651, 24.8182373, 202.176361),
            ['Mustang'] = CFrame.new(-97.1472931, 18.2549458, -1724.10986),
            ['Porsche'] = CFrame.new(1111.16809, 101.783577, 1296.94312),
            ['Ambulance'] = CFrame.new(-179.030914, 18.2636738, 1158.46533),
            ['UFO'] = CFrame.new(775.515747, 18.3745003, -142.552948),
            ['SWAT Van'] = CFrame.new(-1356.85388, 17.9232101, -1534.93152),
            ['Wraith'] = CFrame.new(1687.08911, 50.4146309, -1704.4657),
            ['Ferrari'] = CFrame.new(1694.97766, 18.2658329, 276.87796),
            ['Classic'] = CFrame.new(1194.28406, 106.283951, 1176.69458),
            ['Police Motorcycle'] = CFrame.new(765.334778, 38.6451302, 1053.74951),
            ['Firetruck'] = CFrame.new(-967.847168, 33.1665268, 1320.79968),
            ['Jet Skis'] = CFrame.new(-379.247833, 19.2636337, 728.789917),
            ['Cruiser'] = CFrame.new(-68.4236374, 19.2636337, 2523.81152),
            ['Little Bird'] = CFrame.new(38.4758072, 216.43457, 847.337891),
            ['Stunt'] = CFrame.new(-1349.34143, 41.5697594, 2803.24512),
            ['Jet Plane'] = CFrame.new(-1577.87366, 41.5697594, 2835.16333)
        },
    }
    local library, ui_options, AllToggle = loadstring([[local a={main_color=Color3.fromRGB(255,0,0),window_color=Color3.new(0.0823529,0.0862745,0.0901961),min_size=Vector2.new(100,100),default_size=Vector2.new(500,550),toggle_key=Enum.KeyCode.RightShift,can_resize=true}local b={}do local c=game:GetService("CoreGui"):FindFirstChild("imgui")if c then c:Destroy()end end;local c=Instance.new("ScreenGui")local d=Instance.new("Frame")local e=Instance.new("TextLabel")local f=Instance.new("ImageLabel")local g=Instance.new("Frame")local h=Instance.new("Frame")local i=Instance.new("ImageButton")local j=Instance.new("ImageLabel")local k=Instance.new("ImageLabel")local l=Instance.new("Frame")local m=Instance.new("TextLabel")local n=Instance.new("ImageLabel")local o=Instance.new("Frame")local p=Instance.new("UIListLayout")local q=Instance.new("Frame")local r=Instance.new("Frame")local s=Instance.new("UIListLayout")local t=Instance.new("TextBox")local u=Instance.new("ImageLabel")local v=Instance.new("ImageLabel")local w=Instance.new("TextLabel")local x=Instance.new("ImageLabel")local y=Instance.new("TextLabel")local z=Instance.new("TextLabel")local A=Instance.new("TextLabel")local B=Instance.new("ImageLabel")local C=Instance.new("UIListLayout")local D=Instance.new("TextButton")local E=Instance.new("ImageLabel")local F=Instance.new("ImageButton")local G=Instance.new("ScrollingFrame")local H=Instance.new("UIListLayout")local I=Instance.new("ImageLabel")local J=Instance.new("TextButton")local K=Instance.new("ImageLabel")local L=Instance.new("ImageLabel")local M=Instance.new("TextButton")local N=Instance.new("ImageLabel")local O=Instance.new("ImageLabel")local P=Instance.new("Frame")local Q=Instance.new("UIListLayout")local R=Instance.new("TextLabel")local S=Instance.new("ImageLabel")local T=Instance.new("ImageLabel")local U=Instance.new("ImageLabel")local V=Instance.new("ImageLabel")local W=Instance.new("ImageLabel")local X=Instance.new("Frame")local Y=Instance.new("TextButton")local Z=Instance.new("ImageLabel")local _=Instance.new("TextLabel")local a0=Instance.new("TextButton")local a1=Instance.new("ImageLabel")local a2=Instance.new("TextButton")local a3=Instance.new("ImageLabel")local a4=Instance.new("TextLabel")local a5=Instance.new("TextButton")local a6=Instance.new("ImageLabel")local a7=Instance.new("Frame")c.Name="imgui"c.Parent=game:GetService("CoreGui")c.Enabled=false;d.Name="Prefabs"d.Parent=c;d.BackgroundColor3=Color3.new(1,1,1)d.Size=UDim2.new(0,100,0,100)d.Visible=false;e.Name="Label"e.Parent=d;e.BackgroundColor3=Color3.new(1,1,1)e.BackgroundTransparency=1;e.Size=UDim2.new(0,200,0,20)e.Font=Enum.Font.GothamSemibold;e.Text="Hello, world 123"e.TextColor3=Color3.new(1,1,1)e.TextSize=14;e.TextXAlignment=Enum.TextXAlignment.Left;f.Name="Window"f.Parent=d;f.Active=true;f.BackgroundColor3=Color3.new(1,1,1)f.BackgroundTransparency=1;f.ClipsDescendants=true;f.Position=UDim2.new(0,20,0,20)f.Selectable=true;f.Size=UDim2.new(0,200,0,200)f.Image="rbxassetid://2851926732"f.ImageColor3=Color3.new(0.0823529,0.0862745,0.0901961)f.ScaleType=Enum.ScaleType.Slice;f.SliceCenter=Rect.new(12,12,12,12)g.Name="Resizer"g.Parent=f;g.Active=true;g.BackgroundColor3=Color3.new(1,1,1)g.BackgroundTransparency=1;g.BorderSizePixel=0;g.Position=UDim2.new(1,-20,1,-20)g.Size=UDim2.new(0,20,0,20)h.Name="Bar"h.Parent=f;h.BackgroundColor3=Color3.new(0.160784,0.290196,0.478431)h.BorderSizePixel=0;h.Position=UDim2.new(0,0,0,5)h.Size=UDim2.new(1,0,0,15)i.Name="Toggle"i.Parent=h;i.BackgroundColor3=Color3.new(1,1,1)i.BackgroundTransparency=1;i.Position=UDim2.new(0,5,0,-2)i.Rotation=90;i.Size=UDim2.new(0,20,0,20)i.ZIndex=2;i.Image="http://www.roblox.com/asset/?id=4887804810"j.Name="Base"j.Parent=h;j.BackgroundColor3=Color3.new(0.160784,0.290196,0.478431)j.BorderSizePixel=0;j.Position=UDim2.new(0,0,0.800000012,0)j.Size=UDim2.new(1,0,0,10)j.Image="rbxassetid://2851926732"j.ImageColor3=Color3.new(0.160784,0.290196,0.478431)j.ScaleType=Enum.ScaleType.Slice;j.SliceCenter=Rect.new(12,12,12,12)k.Name="Top"k.Parent=h;k.BackgroundColor3=Color3.new(1,1,1)k.BackgroundTransparency=1;k.Position=UDim2.new(0,0,0,-5)k.Size=UDim2.new(1,0,0,10)k.Image="rbxassetid://2851926732"k.ImageColor3=Color3.new(0.160784,0.290196,0.478431)k.ScaleType=Enum.ScaleType.Slice;k.SliceCenter=Rect.new(12,12,12,12)l.Name="Tabs"l.Parent=f;l.BackgroundColor3=Color3.new(1,1,1)l.BackgroundTransparency=1;l.Position=UDim2.new(0,15,0,60)l.Size=UDim2.new(1,-30,1,-60)m.Name="Title"m.Parent=f;m.BackgroundColor3=Color3.new(1,1,1)m.BackgroundTransparency=1;m.Position=UDim2.new(0,30,0,3)m.Size=UDim2.new(0,200,0,20)m.Font=Enum.Font.GothamBold;m.Text="Gamer Time"m.TextColor3=Color3.new(1,1,1)m.TextSize=14;m.TextXAlignment=Enum.TextXAlignment.Left;n.Name="TabSelection"n.Parent=f;n.BackgroundColor3=Color3.new(1,1,1)n.BackgroundTransparency=1;n.Position=UDim2.new(0,15,0,30)n.Size=UDim2.new(1,-30,0,25)n.Visible=false;n.Image="rbxassetid://2851929490"n.ImageColor3=Color3.new(0.145098,0.14902,0.156863)n.ScaleType=Enum.ScaleType.Slice;n.SliceCenter=Rect.new(4,4,4,4)o.Name="TabButtons"o.Parent=n;o.BackgroundColor3=Color3.new(1,1,1)o.BackgroundTransparency=1;o.Size=UDim2.new(1,0,1,0)p.Parent=o;p.FillDirection=Enum.FillDirection.Horizontal;p.SortOrder=Enum.SortOrder.LayoutOrder;p.Padding=UDim.new(0,2)q.Parent=n;q.BackgroundColor3=Color3.new(0.12549,0.227451,0.372549)q.BorderColor3=Color3.new(0.105882,0.164706,0.207843)q.BorderSizePixel=0;q.Position=UDim2.new(0,0,1,0)q.Size=UDim2.new(1,0,0,2)r.Name="Tab"r.Parent=d;r.BackgroundColor3=Color3.new(1,1,1)r.BackgroundTransparency=1;r.Size=UDim2.new(1,0,1,0)r.Visible=false;s.Parent=r;s.SortOrder=Enum.SortOrder.LayoutOrder;s.Padding=UDim.new(0,5)t.Parent=d;t.BackgroundColor3=Color3.new(1,1,1)t.BackgroundTransparency=1;t.BorderSizePixel=0;t.Size=UDim2.new(1,0,0,20)t.ZIndex=2;t.Font=Enum.Font.GothamSemibold;t.PlaceholderColor3=Color3.new(0.698039,0.698039,0.698039)t.PlaceholderText="Input Text"t.Text=""t.TextColor3=Color3.new(0.784314,0.784314,0.784314)t.TextSize=14;u.Name="TextBox_Roundify_4px"u.Parent=t;u.BackgroundColor3=Color3.new(1,1,1)u.BackgroundTransparency=1;u.Size=UDim2.new(1,0,1,0)u.Image="rbxassetid://2851929490"u.ImageColor3=Color3.new(0.203922,0.207843,0.219608)u.ScaleType=Enum.ScaleType.Slice;u.SliceCenter=Rect.new(4,4,4,4)v.Name="Slider"v.Parent=d;v.BackgroundColor3=Color3.new(1,1,1)v.BackgroundTransparency=1;v.Position=UDim2.new(0,0,0.178571433,0)v.Size=UDim2.new(1,0,0,20)v.Image="rbxassetid://2851929490"v.ImageColor3=Color3.new(0.145098,0.14902,0.156863)v.ScaleType=Enum.ScaleType.Slice;v.SliceCenter=Rect.new(4,4,4,4)w.Name="Title"w.Parent=v;w.BackgroundColor3=Color3.new(1,1,1)w.BackgroundTransparency=1;w.Position=UDim2.new(0.5,0,0.5,-10)w.Size=UDim2.new(0,0,0,20)w.ZIndex=2;w.Font=Enum.Font.GothamBold;w.Text="Slider"w.TextColor3=Color3.new(0.784314,0.784314,0.784314)w.TextSize=14;x.Name="Indicator"x.Parent=v;x.BackgroundColor3=Color3.new(1,1,1)x.BackgroundTransparency=1;x.Size=UDim2.new(0,0,0,20)x.Image="rbxassetid://2851929490"x.ImageColor3=Color3.new(0.254902,0.262745,0.278431)x.ScaleType=Enum.ScaleType.Slice;x.SliceCenter=Rect.new(4,4,4,4)y.Name="Value"y.Parent=v;y.BackgroundColor3=Color3.new(1,1,1)y.BackgroundTransparency=1;y.Position=UDim2.new(1,-55,0.5,-10)y.Size=UDim2.new(0,50,0,20)y.Font=Enum.Font.GothamBold;y.Text="0%"y.TextColor3=Color3.new(0.784314,0.784314,0.784314)y.TextSize=14;z.Parent=v;z.BackgroundColor3=Color3.new(1,1,1)z.BackgroundTransparency=1;z.Position=UDim2.new(1,-20,-0.75,0)z.Size=UDim2.new(0,26,0,50)z.Font=Enum.Font.GothamBold;z.Text="]"z.TextColor3=Color3.new(0.627451,0.627451,0.627451)z.TextSize=14;A.Parent=v;A.BackgroundColor3=Color3.new(1,1,1)A.BackgroundTransparency=1;A.Position=UDim2.new(1,-65,-0.75,0)A.Size=UDim2.new(0,26,0,50)A.Font=Enum.Font.GothamBold;A.Text="["A.TextColor3=Color3.new(0.627451,0.627451,0.627451)A.TextSize=14;B.Name="Circle"B.Parent=d;B.BackgroundColor3=Color3.new(1,1,1)B.BackgroundTransparency=1;B.Image="rbxassetid://266543268"B.ImageTransparency=0.5;C.Parent=d;C.FillDirection=Enum.FillDirection.Horizontal;C.SortOrder=Enum.SortOrder.LayoutOrder;C.Padding=UDim.new(0,20)D.Name="Dropdown"D.Parent=d;D.BackgroundColor3=Color3.new(1,1,1)D.BackgroundTransparency=1;D.BorderSizePixel=0;D.Position=UDim2.new(-0.055555556,0,0.0833333284,0)D.Size=UDim2.new(0,200,0,20)D.ZIndex=2;D.Font=Enum.Font.GothamBold;D.Text="      Dropdown"D.TextColor3=Color3.new(0.784314,0.784314,0.784314)D.TextSize=14;D.TextXAlignment=Enum.TextXAlignment.Left;E.Name="Indicator"E.Parent=D;E.BackgroundColor3=Color3.new(1,1,1)E.BackgroundTransparency=1;E.Position=UDim2.new(0.899999976,-10,0.100000001,0)E.Rotation=-90;E.Size=UDim2.new(0,15,0,15)E.ZIndex=2;E.Image="https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4744658743"F.Name="Box"F.Parent=D;F.BackgroundColor3=Color3.new(1,1,1)F.BackgroundTransparency=1;F.Position=UDim2.new(0,0,0,25)F.Size=UDim2.new(1,0,0,150)F.ZIndex=3;F.Image="rbxassetid://2851929490"F.ImageColor3=Color3.new(0.129412,0.133333,0.141176)F.ScaleType=Enum.ScaleType.Slice;F.SliceCenter=Rect.new(4,4,4,4)G.Name="Objects"G.Parent=F;G.BackgroundColor3=Color3.new(1,1,1)G.BackgroundTransparency=1;G.BorderSizePixel=0;G.Size=UDim2.new(1,0,1,0)G.ZIndex=3;G.CanvasSize=UDim2.new(0,0,0,0)G.ScrollBarThickness=8;H.Parent=G;H.SortOrder=Enum.SortOrder.LayoutOrder;I.Name="TextButton_Roundify_4px"I.Parent=D;I.BackgroundColor3=Color3.new(1,1,1)I.BackgroundTransparency=1;I.Size=UDim2.new(1,0,1,0)I.Image="rbxassetid://2851929490"I.ImageColor3=Color3.new(0.203922,0.207843,0.219608)I.ScaleType=Enum.ScaleType.Slice;I.SliceCenter=Rect.new(4,4,4,4)J.Name="TabButton"J.Parent=d;J.BackgroundColor3=Color3.new(0.160784,0.290196,0.478431)J.BackgroundTransparency=1;J.BorderSizePixel=0;J.Position=UDim2.new(0.185185179,0,0,0)J.Size=UDim2.new(0,71,0,20)J.ZIndex=2;J.Font=Enum.Font.GothamSemibold;J.Text="Test tab"J.TextColor3=Color3.new(0.784314,0.784314,0.784314)J.TextSize=14;K.Name="TextButton_Roundify_4px"K.Parent=J;K.BackgroundColor3=Color3.new(1,1,1)K.BackgroundTransparency=1;K.Size=UDim2.new(1,0,1,0)K.Image="rbxassetid://2851929490"K.ImageColor3=Color3.new(0.203922,0.207843,0.219608)K.ScaleType=Enum.ScaleType.Slice;K.SliceCenter=Rect.new(4,4,4,4)L.Name="Folder"L.Parent=d;L.BackgroundColor3=Color3.new(1,1,1)L.BackgroundTransparency=1;L.Position=UDim2.new(0,0,0,50)L.Size=UDim2.new(1,0,0,20)L.Image="rbxassetid://2851929490"L.ImageColor3=Color3.new(0.0823529,0.0862745,0.0901961)L.ScaleType=Enum.ScaleType.Slice;L.SliceCenter=Rect.new(4,4,4,4)M.Name="Button"M.Parent=L;M.BackgroundColor3=Color3.new(0.160784,0.290196,0.478431)M.BackgroundTransparency=1;M.BorderSizePixel=0;M.Size=UDim2.new(1,0,0,20)M.ZIndex=2;M.Font=Enum.Font.GothamSemibold;M.Text="      Folder"M.TextColor3=Color3.new(1,1,1)M.TextSize=14;M.TextXAlignment=Enum.TextXAlignment.Left;N.Name="TextButton_Roundify_4px"N.Parent=M;N.BackgroundColor3=Color3.new(1,1,1)N.BackgroundTransparency=1;N.Size=UDim2.new(1,0,1,0)N.Image="rbxassetid://2851929490"N.ImageColor3=Color3.new(0.160784,0.290196,0.478431)N.ScaleType=Enum.ScaleType.Slice;N.SliceCenter=Rect.new(4,4,4,4)O.Name="Toggle"O.Parent=M;O.BackgroundColor3=Color3.new(1,1,1)O.BackgroundTransparency=1;O.Position=UDim2.new(0,5,0,0)O.Size=UDim2.new(0,20,0,20)O.Image="https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"P.Name="Objects"P.Parent=L;P.BackgroundColor3=Color3.new(1,1,1)P.BackgroundTransparency=1;P.Position=UDim2.new(0,10,0,25)P.Size=UDim2.new(1,-10,1,-25)P.Visible=false;Q.Parent=P;Q.SortOrder=Enum.SortOrder.LayoutOrder;Q.Padding=UDim.new(0,5)S.Name="ColorPicker"S.Parent=d;S.BackgroundColor3=Color3.new(1,1,1)S.BackgroundTransparency=1;S.Size=UDim2.new(0,180,0,110)S.Image="rbxassetid://2851929490"S.ImageColor3=Color3.new(0.203922,0.207843,0.219608)S.ScaleType=Enum.ScaleType.Slice;S.SliceCenter=Rect.new(4,4,4,4)T.Name="Palette"T.Parent=S;T.BackgroundColor3=Color3.new(1,1,1)T.BackgroundTransparency=1;T.Position=UDim2.new(0.0500000007,0,0.0500000007,0)T.Size=UDim2.new(0,100,0,100)T.Image="rbxassetid://698052001"T.ScaleType=Enum.ScaleType.Slice;T.SliceCenter=Rect.new(4,4,4,4)U.Name="Indicator"U.Parent=T;U.BackgroundColor3=Color3.new(1,1,1)U.BackgroundTransparency=1;U.Size=UDim2.new(0,5,0,5)U.ZIndex=2;U.Image="rbxassetid://2851926732"U.ImageColor3=Color3.new(0,0,0)U.ScaleType=Enum.ScaleType.Slice;U.SliceCenter=Rect.new(12,12,12,12)V.Name="Sample"V.Parent=S;V.BackgroundColor3=Color3.new(1,1,1)V.BackgroundTransparency=1;V.Position=UDim2.new(0.800000012,0,0.0500000007,0)V.Size=UDim2.new(0,25,0,25)V.Image="rbxassetid://2851929490"V.ScaleType=Enum.ScaleType.Slice;V.SliceCenter=Rect.new(4,4,4,4)W.Name="Saturation"W.Parent=S;W.BackgroundColor3=Color3.new(1,1,1)W.Position=UDim2.new(0.649999976,0,0.0500000007,0)W.Size=UDim2.new(0,15,0,100)W.Image="rbxassetid://3641079629"X.Name="Indicator"X.Parent=W;X.BackgroundColor3=Color3.new(1,1,1)X.BorderSizePixel=0;X.Size=UDim2.new(0,20,0,2)X.ZIndex=2;Y.Name="Switch"Y.Parent=d;Y.BackgroundColor3=Color3.new(1,1,1)Y.BackgroundTransparency=1;Y.BorderSizePixel=0;Y.Position=UDim2.new(0.229411766,0,0.20714286,0)Y.Size=UDim2.new(0,20,0,20)Y.ZIndex=2;Y.Font=Enum.Font.SourceSans;Y.Text=""Y.TextColor3=Color3.new(1,1,1)Y.TextSize=18;Z.Name="TextButton_Roundify_4px"Z.Parent=Y;Z.BackgroundColor3=Color3.new(1,1,1)Z.BackgroundTransparency=1;Z.Size=UDim2.new(1,0,1,0)Z.Image="rbxassetid://2851929490"Z.ImageColor3=Color3.new(0.160784,0.290196,0.478431)Z.ImageTransparency=0.5;Z.ScaleType=Enum.ScaleType.Slice;Z.SliceCenter=Rect.new(4,4,4,4)_.Name="Title"_.Parent=Y;_.BackgroundColor3=Color3.new(1,1,1)_.BackgroundTransparency=1;_.Position=UDim2.new(1.20000005,0,0,0)_.Size=UDim2.new(0,20,0,20)_.Font=Enum.Font.GothamSemibold;_.Text="Switch"_.TextColor3=Color3.new(0.784314,0.784314,0.784314)_.TextSize=14;_.TextXAlignment=Enum.TextXAlignment.Left;a0.Name="Button"a0.Parent=d;a0.BackgroundColor3=Color3.new(0.160784,0.290196,0.478431)a0.BackgroundTransparency=1;a0.BorderSizePixel=0;a0.Size=UDim2.new(0,91,0,20)a0.ZIndex=2;a0.Font=Enum.Font.GothamSemibold;a0.TextColor3=Color3.new(1,1,1)a0.TextSize=14;a1.Name="TextButton_Roundify_4px"a1.Parent=a0;a1.BackgroundColor3=Color3.new(1,1,1)a1.BackgroundTransparency=1;a1.Size=UDim2.new(1,0,1,0)a1.Image="rbxassetid://2851929490"a1.ImageColor3=Color3.new(0.160784,0.290196,0.478431)a1.ScaleType=Enum.ScaleType.Slice;a1.SliceCenter=Rect.new(4,4,4,4)a2.Name="DropdownButton"a2.Parent=d;a2.BackgroundColor3=Color3.new(0.129412,0.133333,0.141176)a2.BorderSizePixel=0;a2.Size=UDim2.new(1,0,0,20)a2.ZIndex=3;a2.Font=Enum.Font.GothamBold;a2.Text="      Button"a2.TextColor3=Color3.new(0.784314,0.784314,0.784314)a2.TextSize=14;a2.TextXAlignment=Enum.TextXAlignment.Left;a3.Name="Keybind"a3.Parent=d;a3.BackgroundColor3=Color3.new(1,1,1)a3.BackgroundTransparency=1;a3.Size=UDim2.new(0,200,0,20)a3.Image="rbxassetid://2851929490"a3.ImageColor3=Color3.new(0.203922,0.207843,0.219608)a3.ScaleType=Enum.ScaleType.Slice;a3.SliceCenter=Rect.new(4,4,4,4)a4.Name="Title"a4.Parent=a3;a4.BackgroundColor3=Color3.new(1,1,1)a4.BackgroundTransparency=1;a4.Size=UDim2.new(0,0,1,0)a4.Font=Enum.Font.GothamBold;a4.Text="Keybind"a4.TextColor3=Color3.new(0.784314,0.784314,0.784314)a4.TextSize=14;a4.TextXAlignment=Enum.TextXAlignment.Left;a5.Name="Input"a5.Parent=a3;a5.BackgroundColor3=Color3.new(1,1,1)a5.BackgroundTransparency=1;a5.BorderSizePixel=0;a5.Position=UDim2.new(1,-85,0,2)a5.Size=UDim2.new(0,80,1,-4)a5.ZIndex=2;a5.Font=Enum.Font.GothamSemibold;a5.Text="RShift"a5.TextColor3=Color3.new(0.784314,0.784314,0.784314)a5.TextSize=12;a5.TextWrapped=true;a6.Name="Input_Roundify_4px"a6.Parent=a5;a6.BackgroundColor3=Color3.new(1,1,1)a6.BackgroundTransparency=1;a6.Size=UDim2.new(1,0,1,0)a6.Image="rbxassetid://2851929490"a6.ImageColor3=Color3.new(0.290196,0.294118,0.313726)a6.ScaleType=Enum.ScaleType.Slice;a6.SliceCenter=Rect.new(4,4,4,4)a7.Name="Windows"a7.Parent=c;a7.BackgroundColor3=Color3.new(1,1,1)a7.BackgroundTransparency=1;a7.Position=UDim2.new(0,20,0,20)a7.Size=UDim2.new(1,20,1,-20)script.Parent=c;local a8=game:GetService("UserInputService")local a9=game:GetService("TweenService")local aa=game:GetService("RunService")local ab=game:GetService("Players")local ac=ab.LocalPlayer;local ad=ac:GetMouse()local d=script.Parent:WaitForChild("Prefabs")local a7=script.Parent:FindFirstChild("Windows")local ae={["binding"]=false}a8.InputBegan:Connect(function(af,ag)if ag then return end;if af.KeyCode==(typeof(a.toggle_key)=="EnumItem"and a.toggle_key or Enum.KeyCode.RightShift)then if script.Parent then if not ae.binding then script.Parent.Enabled=not script.Parent.Enabled end end end end)local function ah(ai,aj,ak)ak=ak or 0.5;local al=TweenInfo.new(ak,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)local am=a9:Create(ai,al,aj)am:Play()end;local function an(ao,ap,aq)ao,ap,aq=ao/255,ap/255,aq/255;local ar,as=math.max(ao,ap,aq),math.min(ao,ap,aq)local at,au,av;av=ar;local aw=ar-as;if ar==0 then au=0 else au=aw/ar end;if ar==as then at=0 else if ar==ao then at=(ap-aq)/aw;if ap<aq then at=at+6 end elseif ar==ap then at=(aq-ao)/aw+2 elseif ar==aq then at=(ao-ap)/aw+4 end;at=at/6 end;return at,au,av end;local function ax(ay,az)local aA,aq=pcall(function()return ay[tostring(az)]end)if aA then return aq end end;local function aB(aC)return aC.TextBounds.X+15 end;local function aD()return Vector2.new(a8:GetMouseLocation().X+1,a8:GetMouseLocation().Y-35)end;local function aE(aF,aG,aH)spawn(function()aF.ClipsDescendants=true;local aI=d:FindFirstChild("Circle"):Clone()aI.Parent=aF;aI.ZIndex=1000;local aJ=aG-aI.AbsolutePosition.X;local aK=aH-aI.AbsolutePosition.Y;aI.Position=UDim2.new(0,aJ,0,aK)local aL=0;if aF.AbsoluteSize.X>aF.AbsoluteSize.Y then aL=aF.AbsoluteSize.X*1.5 elseif aF.AbsoluteSize.X<aF.AbsoluteSize.Y then aL=aF.AbsoluteSize.Y*1.5 elseif aF.AbsoluteSize.X==aF.AbsoluteSize.Y then aL=aF.AbsoluteSize.X*1.5 end;aI:TweenSizeAndPosition(UDim2.new(0,aL,0,aL),UDim2.new(0.5,-aL/2,0.5,-aL/2),"Out","Quad",0.5,false,nil)ah(aI,{ImageTransparency=1},0.5)wait(0.5)aI:Destroy()end)end;local aM=0;local aN={}local function aO()local aP=d:FindFirstChild("UIListLayout"):Clone()aP.Parent=a7;local aQ={}for aR,av in next,a7:GetChildren()do if not av:IsA("UIListLayout")then aQ[av]=av.AbsolutePosition end end;aP:Destroy()for aR,av in next,aQ do aR.Position=UDim2.new(0,av.X,0,av.Y)end end;function aN:FormatWindows()aO()end;function aN:Ready()c.Enabled=true end;function aN:AddWindow(aS,aT)aM=aM+1;local aU=false;local aV=true;aS=tostring(aS or"New Window")aT=typeof(aT)=="table"and aT or a;aT.tween_time=0.1;local f=d:FindFirstChild("Window"):Clone()f.Parent=a7;f.ImageColor3=aT.window_color;f:FindFirstChild("Title").Text=aS;f.Size=UDim2.new(0,aT.default_size.X,0,aT.default_size.Y)f.ZIndex=f.ZIndex+aM*10;function dragify(q)local aW;local aX;local aY;local aZ;local function a_(af)Delta=af.Position-aY;Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+Delta.X,startPos.Y.Scale,startPos.Y.Offset+Delta.Y)game:GetService("TweenService"):Create(q,TweenInfo.new(0.01),{Position=Position}):Play()end;q.InputBegan:Connect(function(af)if(af.UserInputType==Enum.UserInputType.MouseButton1 or af.UserInputType==Enum.UserInputType.Touch)and aV then aW=true;aY=af.Position;startPos=q.Position;af.Changed:Connect(function()if af.UserInputState==Enum.UserInputState.End then aW=false end end)end end)q.InputChanged:Connect(function(af)if(af.UserInputType==Enum.UserInputType.MouseMovement or af.UserInputType==Enum.UserInputType.Touch)and aV then aX=af end end)game:GetService("UserInputService").InputChanged:Connect(function(af)if af==aX and aW and aV then a_(af)end end)end;do local m=f:FindFirstChild("Title")local h=f:FindFirstChild("Bar")local j=h:FindFirstChild("Base")local k=h:FindFirstChild("Top")local b0=f:FindFirstChild("TabSelection"):FindFirstChild("Frame")local i=h:FindFirstChild("Toggle")spawn(function()while aa.Heartbeat:Wait()do h.BackgroundColor3=aT.main_color;j.BackgroundColor3=aT.main_color;j.ImageColor3=aT.main_color;k.ImageColor3=aT.main_color;b0.BackgroundColor3=aT.main_color end end)end;local g=f:WaitForChild("Resizer")local b1={}dragify(f)do local b2=false;g.MouseEnter:Connect(function()aV=false;b2=true end)g.MouseLeave:Connect(function()b2=false;aV=true end)local b3=false;a8.InputBegan:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=true;spawn(function()if b2 and g.Active and aT.can_resize then while b3 and g.Active and aa.Heartbeat:Wait()do local b5=aD()local aG=b5.X-f.AbsolutePosition.X;local aH=b5.Y-f.AbsolutePosition.Y;if aG>=aT.min_size.X and aH>=aT.min_size.Y then ah(f,{Size=UDim2.new(0,aG,0,aH)},aT.tween_time)elseif aG>=aT.min_size.X then ah(f,{Size=UDim2.new(0,aG,0,aT.min_size.Y)},aT.tween_time)elseif aH>=aT.min_size.Y then ah(f,{Size=UDim2.new(0,aT.min_size.X,0,aH)},aT.tween_time)else ah(f,{Size=UDim2.new(0,aT.min_size.X,0,aT.min_size.Y)},aT.tween_time)end end end end)end end)a8.InputEnded:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=false end end)end;do local b6=f:FindFirstChild("Bar"):FindFirstChild("Toggle")local b7=true;local b8=true;local b9={}local ba=f.AbsoluteSize.Y;b6.MouseButton1Click:Connect(function()if b8 then b8=false;if b7 then b9={}for aR,av in next,f:FindFirstChild("Tabs"):GetChildren()do b9[av]=av.Visible;av.Visible=false end;g.Active=false;ba=f.AbsoluteSize.Y;ah(b6,{Rotation=0},aT.tween_time)ah(f,{Size=UDim2.new(0,f.AbsoluteSize.X,0,26)},aT.tween_time)b6.Parent:FindFirstChild("Base").Transparency=1 else for aR,av in next,b9 do aR.Visible=av end;g.Active=true;ah(b6,{Rotation=90},aT.tween_time)ah(f,{Size=UDim2.new(0,f.AbsoluteSize.X,0,ba)},aT.tween_time)b6.Parent:FindFirstChild("Base").Transparency=0 end;b7=not b7;wait(aT.tween_time)b8=true end end)end;do local bb=f:FindFirstChild("Tabs")local bc=f:FindFirstChild("TabSelection")local bd=bc:FindFirstChild("TabButtons")do function b1:AddTab(be)local bf={}be=tostring(be or"New Tab")bc.Visible=true;local bg=d:FindFirstChild("TabButton"):Clone()bg.Parent=bd;bg.Text=be;bg.Size=UDim2.new(0,aB(bg),0,20)bg.ZIndex=bg.ZIndex+aM*10;bg:GetChildren()[1].ZIndex=bg:GetChildren()[1].ZIndex+aM*10;local bh=d:FindFirstChild("Tab"):Clone()bh.Parent=bb;bh.ZIndex=bh.ZIndex+aM*10;local function bi()if aU then return end;for aR,av in next,bd:GetChildren()do if not av:IsA("UIListLayout")then av:GetChildren()[1].ImageColor3=Color3.fromRGB(52,53,56)ah(av,{Size=UDim2.new(0,av.AbsoluteSize.X,0,20)},aT.tween_time)end end;for aR,av in next,bb:GetChildren()do av.Visible=false end;ah(bg,{Size=UDim2.new(0,bg.AbsoluteSize.X,0,25)},aT.tween_time)bg:GetChildren()[1].ImageColor3=Color3.fromRGB(73,75,79)bh.Visible=true end;bg.MouseButton1Click:Connect(function()bi()end)function bf:Show()bi()end;do function bf:Label(bj)bj=tostring(bj or"New Label")local bk={}local bl=d:FindFirstChild("Label"):Clone()bl.Parent=bh;bl.Text=bj;bl.Size=UDim2.new(0,aB(bl),0,20)bl.ZIndex=bl.ZIndex+aM*10;function bk:Set(bm)bl.Text=bm end;function bk:SetColor(bn)bl.TextColor3=bn end;return bk,bl end;function bf:Button(bo,bp)bo=tostring(bo or"New Button")bp=typeof(bp)=="function"and bp or function()end;local aF=d:FindFirstChild("Button"):Clone()aF.Parent=bh;aF.Text=bo;aF.Size=UDim2.new(0,aB(aF),0,20)aF.ZIndex=aF.ZIndex+aM*10;aF:GetChildren()[1].ZIndex=aF:GetChildren()[1].ZIndex+aM*10;spawn(function()while true do aF:GetChildren()[1].ImageColor3=aT.main_color;aa.Heartbeat:Wait()end end)aF.MouseButton1Click:Connect(function()aE(aF,ad.X,ad.Y)pcall(bp)end)return aF end;function bf:Toggle(bq,bp)local br={}bq=tostring(bq or"New Switch")bp=typeof(bp)=="function"and bp or function()end;local bs=d:FindFirstChild("Switch"):Clone()bs.Parent=bh;bs:FindFirstChild("Title").Text=bq;bs:FindFirstChild("Title").ZIndex=bs:FindFirstChild("Title").ZIndex+aM*10;bs.ZIndex=bs.ZIndex+aM*10;bs:GetChildren()[1].ZIndex=bs:GetChildren()[1].ZIndex+aM*10;spawn(function()while true do bs:GetChildren()[1].ImageColor3=aT.main_color;aa.Heartbeat:Wait()end end)local bt=false;bs.MouseButton1Click:Connect(function()bt=not bt;bs.Text=bt and utf8.char(10003)or""pcall(bp,bt)end)br.Name=bq;function br:Set(bu)bt=typeof(bu)=="boolean"and bu or false;bs.Text=bt and utf8.char(10003)or""pcall(bp,bt)end;table.insert(b,br)return br,bs end;function bf:Box(bv,bp,bw)bv=tostring(bv or"New TextBox")bp=typeof(bp)=="function"and bp or function()end;bw=typeof(bw)=="table"and bw or{["clear"]=true}bw={["clear"]=bw.clear==true}local bx=d:FindFirstChild("TextBox"):Clone()bx.Parent=bh;bx.PlaceholderText=bv;bx.ZIndex=bx.ZIndex+aM*10;bx:GetChildren()[1].ZIndex=bx:GetChildren()[1].ZIndex+aM*10;bx.FocusLost:Connect(function(by)if by then if#bx.Text>0 then pcall(bp,bx.Text)if bw.clear then bx.Text=""end end end end)return bx end;function bf:Slider(bz,bp,bA)local bB={}bz=tostring(bz or"New Slider")bp=typeof(bp)=="function"and bp or function()end;bA=typeof(bA)=="table"and bA or{}bA={["min"]=bA.min or 0,["max"]=bA.max or 100,["readonly"]=bA.readonly or false}local bC=d:FindFirstChild("Slider"):Clone()bC.Parent=bh;bC.ZIndex=bC.ZIndex+aM*10;local aS=bC:FindFirstChild("Title")local bD=bC:FindFirstChild("Indicator")local bE=bC:FindFirstChild("Value")aS.ZIndex=aS.ZIndex+aM*10;bD.ZIndex=bD.ZIndex+aM*10;bE.ZIndex=bE.ZIndex+aM*10;aS.Text=bz;do local b2=false;bC.MouseEnter:Connect(function()b2=true;aV=false end)bC.MouseLeave:Connect(function()b2=false;aV=true end)local b3=false;a8.InputBegan:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=true;spawn(function()if b2 and not bA.readonly then while b3 and not aU and aa.Heartbeat:Wait()do local b5=aD()local aG=(bC.AbsoluteSize.X-(bC.AbsoluteSize.X-(b5.X-bC.AbsolutePosition.X)+1))/bC.AbsoluteSize.X;local as=0;local ar=1;local aL=as;if aG>=as and aG<=ar then aL=aG elseif aG<as then aL=as elseif aG>ar then aL=ar end;ah(bD,{Size=UDim2.new(aL or as,0,0,20)},aT.tween_time)local ac=math.floor((aL or as)*100)local bF=bA.max;local bG=bA.min;local bH=bF-bG;local bI=math.floor(bH/100*ac+bG)bE.Text=tostring(bI)pcall(bp,bI)end end end)end end)a8.InputEnded:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=false end end)function bB:Set(bJ)bJ=tonumber(bJ)or 0;bJ=(bJ>=0 and bJ<=100 and bJ)/100;ah(bD,{Size=UDim2.new(bJ or 0,0,0,20)},aT.tween_time)local ac=math.floor((bJ or 0)*100)local bF=bA.max;local bG=bA.min;local bH=bF-bG;local bI=math.floor(bH/100*ac+bG)bE.Text=tostring(bI)pcall(bp,bI)end;bB:Set(0)end;return bB,bC end;function bf:Bind(bK,bp,bL)local bM={}bK=tostring(bK or"New Keybind")bp=typeof(bp)=="function"and bp or function()end;bL=typeof(bL)=="table"and bL or{}bL={["standard"]=bL.standard or Enum.KeyCode.RightShift}local bN=d:FindFirstChild("Keybind"):Clone()local af=bN:FindFirstChild("Input")local aS=bN:FindFirstChild("Title")bN.ZIndex=bN.ZIndex+aM*10;af.ZIndex=af.ZIndex+aM*10;af:GetChildren()[1].ZIndex=af:GetChildren()[1].ZIndex+aM*10;aS.ZIndex=aS.ZIndex+aM*10;bN.Parent=bh;aS.Text="  "..bK;bN.Size=UDim2.new(0,aB(aS)+80,0,20)local bO={RightControl='RightCtrl',LeftControl='LeftCtrl',LeftShift='LShift',RightShift='RShift',MouseButton1="Mouse1",MouseButton2="Mouse2"}local bN=bL.standard;function bM:Set(a3)local bP=bO[a3.Name]or a3.Name;af.Text=bP;bN=a3 end;a8.InputBegan:Connect(function(aA,aq)if ae.binding then spawn(function()wait()ae.binding=false end)return end;if aA.KeyCode==bN and not aq then pcall(bp,bN)end end)bM:Set(bL.standard)af.MouseButton1Click:Connect(function()if ae.binding then return end;af.Text="..."ae.binding=true;local aA,aq=a8.InputBegan:Wait()bM:Set(aA.KeyCode)end)return bM,bN end;function bf:Dropdown(bQ,bp)local bR={}bQ=tostring(bQ or"New Dropdown")bp=typeof(bp)=="function"and bp or function()end;local bS=d:FindFirstChild("Dropdown"):Clone()local bT=bS:FindFirstChild("Box")local bU=bT:FindFirstChild("Objects")local bD=bS:FindFirstChild("Indicator")bS.ZIndex=bS.ZIndex+aM*10;bT.ZIndex=bT.ZIndex+aM*10;bU.ZIndex=bU.ZIndex+aM*10;bD.ZIndex=bD.ZIndex+aM*10;bS:GetChildren()[3].ZIndex=bS:GetChildren()[3].ZIndex+aM*10;bS.Parent=bh;bS.Text="      "..bQ;bT.Size=UDim2.new(1,0,0,0)local b7=false;bS.MouseButton1Click:Connect(function()b7=not b7;local bV=(#bU:GetChildren()-1)*20;if#bU:GetChildren()-1>=10 then bV=10*20;bU.CanvasSize=UDim2.new(0,0,(#bU:GetChildren()-1)*0.1,0)end;if b7 then if aU then return end;aU=true;ah(bT,{Size=UDim2.new(1,0,0,bV)},aT.tween_time)ah(bD,{Rotation=90},aT.tween_time)else aU=false;ah(bT,{Size=UDim2.new(1,0,0,0)},aT.tween_time)ah(bD,{Rotation=-90},aT.tween_time)end end)function bR:Add(bW)local bX={}bW=tostring(bW or"New Object")local ay=d:FindFirstChild("DropdownButton"):Clone()ay.Parent=bU;ay.Text=bW;ay.ZIndex=ay.ZIndex+aM*10;ay.MouseEnter:Connect(function()ay.BackgroundColor3=aT.main_color end)ay.MouseLeave:Connect(function()ay.BackgroundColor3=Color3.fromRGB(33,34,36)end)if b7 then local bV=(#bU:GetChildren()-1)*20;if#bU:GetChildren()-1>=10 then bV=10*20;bU.CanvasSize=UDim2.new(0,0,(#bU:GetChildren()-1)*0.1,0)end;ah(bT,{Size=UDim2.new(1,0,0,bV)},aT.tween_time)end;ay.MouseButton1Click:Connect(function()if aU then bS.Text="      [ "..bW.." ]"aU=false;b7=false;ah(bT,{Size=UDim2.new(1,0,0,0)},aT.tween_time)ah(bD,{Rotation=-90},aT.tween_time)pcall(bp,bW)end end)function bX:Remove()ay:Destroy()end;return ay,bX end;return bR,bS end;function bf:ColorPicker(bp)local bY={}bp=typeof(bp)=="function"and bp or function()end;local bZ=d:FindFirstChild("ColorPicker"):Clone()bZ.Parent=bh;bZ.ZIndex=bZ.ZIndex+aM*10;local b_=bZ:FindFirstChild("Palette")local c0=bZ:FindFirstChild("Sample")local c1=bZ:FindFirstChild("Saturation")b_.ZIndex=b_.ZIndex+aM*10;c0.ZIndex=c0.ZIndex+aM*10;c1.ZIndex=c1.ZIndex+aM*10;do local at=0;local au=1;local av=1;local function c2()local c3=Color3.fromHSV(at,au,av)c0.ImageColor3=c3;c1.ImageColor3=Color3.fromHSV(at,1,1)pcall(bp,c3)end;do local c3=Color3.fromHSV(at,au,av)c0.ImageColor3=c3;c1.ImageColor3=Color3.fromHSV(at,1,1)end;local c4,c5=false,false;b_.MouseEnter:Connect(function()aV=false;c4=true end)b_.MouseLeave:Connect(function()aV=true;c4=false end)c1.MouseEnter:Connect(function()aV=false;c5=true end)c1.MouseLeave:Connect(function()aV=true;c5=false end)local c6=b_:FindFirstChild("Indicator")local c7=c1:FindFirstChild("Indicator")c6.ZIndex=c6.ZIndex+aM*10;c7.ZIndex=c7.ZIndex+aM*10;local b3=false;a8.InputBegan:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=true;spawn(function()while b3 and c4 and not aU do local b5=aD()local aG=b_.AbsoluteSize.X-(b5.X-b_.AbsolutePosition.X)+1;local aH=b_.AbsoluteSize.Y-(b5.Y-b_.AbsolutePosition.Y)+1.5;local c3=Color3.fromHSV(aG/100,aH/100,0)at=aG/100;au=aH/100;ah(c6,{Position=UDim2.new(0,math.abs(aG-100)-c6.AbsoluteSize.X/2,0,math.abs(aH-100)-c6.AbsoluteSize.Y/2)},aT.tween_time)c2()aa.Heartbeat:Wait()end;while b3 and c5 and not aU do local b5=aD()local aH=b_.AbsoluteSize.Y-(b5.Y-b_.AbsolutePosition.Y)+1.5;av=aH/100;ah(c7,{Position=UDim2.new(0,0,0,math.abs(aH-100))},aT.tween_time)c2()aa.Heartbeat:Wait()end end)end end)a8.InputEnded:Connect(function(b4)if b4.UserInputType==Enum.UserInputType.MouseButton1 then b3=false end end)function bY:Set(c3)c3=typeof(c3)=="Color3"and c3 or Color3.new(1,1,1)local c8,c9,ca=an(c3.r*255,c3.g*255,c3.b*255)c0.ImageColor3=c3;c1.ImageColor3=Color3.fromHSV(c8,1,1)pcall(bp,c3)end end;return bY,bZ end end;return bf,bh end end end;do for aR,av in next,f:GetDescendants()do if ax(av,"ZIndex")then av.ZIndex=av.ZIndex+aM*10 end end end;return b1,f end;return aN,a,b,c]])()
    if IsSiff then
        ui_options.main_color = Color3.fromRGB(255,192,203)
        ui_options.window_color = Color3.fromRGB(255,182,193)
    end
    local Tesla = library:AddWindow(IsSiff and "i love you xd" or "Ford (discord.tesla-best.xyz) - " .. Exploit)
    local TeleportTab = Tesla:AddTab("Teleports")
    local PlayerTab = Tesla:AddTab("Player")
    local CombatTab = Tesla:AddTab("Combat")
    local VehicleTab = Tesla:AddTab("Vehicle")
    local FarmingTab = Tesla:AddTab("Farming")
    local FunTab = Tesla:AddTab("Fun")
    local SettingTab = Tesla:AddTab("Settings")
    TeleportTab:Show()
    TeleportTab:Box("Teleport To Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) then
                TP(v.Character:WaitForChild('HumanoidRootPart').CFrame)
                return
            end
        end
    end)
    local sd = TeleportTab:Dropdown("Store Teleports", function(selected)
        TP(locations.Stores[selected])
    end)
    for i,v in next, locations.Stores do
        sd:Add(i)
    end
    local ld = TeleportTab:Dropdown("Location Teleports", function(selected)
        TP(locations.Locations[selected])
    end)
    for i,v in next, locations.Locations do
        ld:Add(i)
    end
    local vd = TeleportTab:Dropdown("Vehicle Teleport", function(selected)
        TP(locations.Vehicles[selected])
    end)
    for i,v in next, locations.Vehicles do
        vd:Add(i)
    end
    TeleportTab:Toggle("Click Teleport", function(arg)
        NiggaToggle.ClickTp = arg
    end):Set(NiggaToggle.ClickTp)
    TeleportTab:Button("Teleport to Airdrop", function()
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Pick up briefcase" then
                TP(v.Part.CFrame)
                return
            end
        end
    end)
    TeleportTab:Button("Teleport to Cargo Ship", function()
        local Ship = workspace:FindFirstChild("CargoShip")
        local Crate = Ship and Ship.Crates:FindFirstChild("Crate")
        if Crate then
            TP(Crate.Part.CFrame + Vector3.new(0, 10, 0))
        else
            Notification("Cargo Ship closed")
        end
    end)
    TeleportTab:Button("Teleport To Plane", function()
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Inspect Crate" then
                TP(v.Part.CFrame)
                return true
            end
        end
        Notification("Plane closed")
        return false
    end)
    local SavePos = nil
    local SavePosString = "Saved Position: %s"
    local SavePosLabel = TeleportTab:Label(SavePosString:format("None"))
    TeleportTab:Button("Save Position", function()
        SavePos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
        SavePosLabel:Set(SavePosString:format(tostring(LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position)))
    end)
    TeleportTab:Button("Teleport to Saved Position", function()
        if SavePos then
            TP(SavePos)
        else
            Notification("You Don't Have Position Saved!")
        end
    end)
    PlayerTab:Slider("WalkSpeed", function(callback)
        _G.WalkSpeed = callback
        LocalPlayer.Character.Humanoid.WalkSpeed = callback
    end, {
        min = 16,
        max = 150
    })
    PlayerTab:Slider("JumpPower", function(callback)
        LocalPlayer.Character.Humanoid.JumpPower = callback
    end, {
        min = 50,
        max = 200
    })
    PlayerTab:Toggle("No Wait", function(arg)
        NiggaToggle.NoWait = arg
    end):Set(NiggaToggle.NoWait)
    PlayerTab:Toggle("Open All Doors", function(arg)
        NiggaToggle.OpenDoors = arg
    end):Set(NiggaToggle.OpenDoors)
    PlayerTab:Toggle("No Clip", function(arg)
        NiggaToggle.NoClip = arg
    end):Set(NiggaToggle.NoClip)
    PlayerTab:Toggle("Anti Arrest", function(arg)
        NiggaToggle.AntiArrest = arg
    end):Set(NiggaToggle.AntiArrest)
    PlayerTab:Toggle("Auto Breakout", function(arg)
        NiggaToggle.Autobreakout = arg
    end):Set(NiggaToggle.Autobreakout)
    PlayerTab:Toggle("No Punch Cooldown", function(arg)
        NiggaToggle.OPM = arg
        setconstant(Client.OnAction, 16, arg and "lmao" or "tick")
    end):Set(NiggaToggle.OPM)
    PlayerTab:Toggle("Eject All", function(arg)
        NiggaToggle.Eject = arg
    end):Set(NiggaToggle.Eject)
    PlayerTab:Toggle("God Mode", function(arg)
        NiggaToggle.GodMode = arg
        setconstant(Client.GiveDonut, 1, arg and "lmao" or "tick")
        setconstant(Client.Unequip, 12, arg and "Fake" or "Unequip")
    end):Set(NiggaToggle.GodMode)
    PlayerTab:Toggle("Anti Ragdoll", function(arg)
        NiggaToggle.AntiRagdoll = arg
    end):Set(NiggaToggle.AntiRagdoll)
    PlayerTab:Toggle("No Team Change Cooldown", function(arg)
        NiggaToggle.TeamSwitchCD = arg
        require(ReplicatedStorage.Resource.Settings).Time.BetweenTeamChange = arg and 0 or 24
    end):Set(NiggaToggle.TeamSwitchCD)
    PlayerTab:Toggle("No Cell Time", function(arg)
        NiggaToggle.CellTime = arg
        require(ReplicatedStorage.Resource.Settings).Time.Cell = arg and 0 or 24
    end):Set(NiggaToggle.CellTime)
    PlayerTab:Button("Change Suit", function()
        fireclickdetector(workspace.ClothingRacks.ClothingRack.Hitbox.ClickDetector)
    end)
    PlayerTab:Button("Give JetPack", Client.GiveJetPack)
    PlayerTab:Button("Inf JetPack Fuel", function()
        local JPFuel = getupvalue(require(ReplicatedStorage.Game.JetPack.JetPack).Init,7)
        JPFuel.LocalMaxFuel = math.huge
        JPFuel.LocalFuel = math.huge
        JPFuel.LocalFuelType = "Rocket"
    end)
    PlayerTab:Button("Invisible", function()
        local ogpos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
        if not workspace.Vehicles:FindFirstChild("DuneBuggy") then
            TP(CFrame.new(527.959351, 19.180603, -476.19516))
            Notification("Waiting for Dune Buggy...")
            repeat wait(0.5) until workspace.Vehicles:FindFirstChild("DuneBuggy")
        end
        wait()
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Enter Passenger" and v.ValidRoot.Name == "DuneBuggy" then
                v:Callback(true)
                require(ReplicatedStorage.Game.Item.Gun).SetLeaning({Config = { Motion = { Hip = { Springs = { ItemOffset = nil, ItemRotation = nil, NeckRotation = nil } } } },SpringItemOffset = {SetTarget = function() end},SpringItemRotation = {SetTarget = function() end},SpringNeckRotation = {SetTarget = function() end},Local = true}, false, false)
                wait(0.3)
                Client.ExitCar()
                break
            end
        end
    end)
    PlayerTab:Button("PickPocket", function()
        local key = workspace:FindFirstChild("Key")
        if key then
            Client.PickItem({Part = {Parent = key}}, true)
            return
        end
        local ogpos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
        for i,v in pairs(Players:GetPlayers()) do
            if tostring(v.Team) == "Police" then
                if v.Character:FindFirstChild("HumanoidRootPart") then
                    if not v.Character:FindFirstChild("InVehicle") then
                        TP(v.Character:WaitForChild('HumanoidRootPart').CFrame)
                        wait(0.5)
                        for count = 1, 10 do
                            Client.PickPocket(v)
                        end
                        wait()
                        TP(ogpos)
                        return
                    end
                end
            end
        end
    end)
    local teamd = PlayerTab:Dropdown("Change Team", function(selected)
        Client.Network:FireServer(Client.Hashes.TeamChange, tostring(selected))
        local ogpos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
        wait(0.5)
        TP(ogpos)
    end)
    teamd:Add("Prisoner")
    teamd:Add("Police")
    CombatTab:Button("Grab All Guns", function()
        for i,v in pairs(workspace.Givers:GetChildren()) do
            if v.Name == "Guns" then
                fireclickdetector(v.ClickDetector)
            end
        end
        for i,v in pairs(Client.Guns) do
            Client.GiveGun({ Part = { Parent = { Name = i } }, CanGrab = true }, true)
        end
    end)
    CombatTab:Button("Gun Mods", function()
        for i,v in pairs(ReplicatedStorage.Game.ItemConfig:GetChildren()) do
            local cst = require(v)
            cst.CamShakeMagnitude = 0
            cst.MagSize = math.huge
            cst.ReloadTime = 0
            cst.FireAuto = true
            cst.FireFreq = 30
        end
        local old = require(ReplicatedStorage.Game.Item.Taser).Tase
        require(ReplicatedStorage.Game.Item.Taser).Tase = function(self, ...)
            self.Config.ReloadTime = 0
            self.ReloadTimeHit = 0
            return old(self, ...)
        end
    end)
    CombatTab:Toggle("Taze All", function(arg)
        NiggaToggle.TazeAll = arg
    end):Set(NiggaToggle.TazeAll)
    CombatTab:Toggle("Taze Aura", function(arg)
        NiggaToggle.TazeAura = arg
    end):Set(NiggaToggle.TazeAura)
    CombatTab:Toggle("Kill Aura", function(arg)
        NiggaToggle.KillAura = arg
	end):Set(NiggaToggle.KillAura)
    CombatTab:Toggle("Kill Aura (Loop TP)", function(arg)
        NiggaToggle.KillAuraLTP = arg
    end):Set(NiggaToggle.KillAuraLTP)
    VehicleTab:Box("Engine Speed", function(callback)
        if tonumber(callback) then
            _G.EngineSpeed = tonumber(callback)
        end
    end)
    VehicleTab:Box("Height", function(callback)
        if tonumber(callback) then
            _G.Height = tonumber(callback)
        end
    end)
    VehicleTab:Box("Turn Speed", function(callback)
        if tonumber(callback) then
            _G.TurnSpeed = tonumber(callback)
        end
    end)
    VehicleTab:Box("Brake", function(callback)
        if tonumber(callback) then
            _G.Brake = tonumber(callback)
        end
    end)
    VehicleTab:Button("Reset Car", function()
        _G.TurnSpeed = nil
        _G.Height = nil
        _G.EngineSpeed = nil
        _G.Brake = nil
        Notification("Please Re-enter your vehicle")
    end)
    local x = LocalPlayer:GetMouse()
    local z = workspace.CurrentCamera
    local function FlyPart(ak, al)
        local am = Instance.new("Folder")
        am.Name = "Storage"
        for E, an in pairs(ak:GetChildren()) do
            if an:IsA("BodyGyro") then
                an.Parent = am
            end
        end
        local ao = Instance.new("BodyPosition", ak)
        ao.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        ao.Name = "Position"
        local ap = Instance.new("BodyGyro", ak)
        ap.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        ap.Name = "Rotate"
        z.CameraSubject = ak
        local aq = 0
        local ar = x.KeyDown:Connect(function(as)
            if as == "w" then
                if al then
                    aq = NiggaToggle.FlySpeed
                else
                    aq = tonumber("-" .. tostring(NiggaToggle.FlySpeed))
                end
            elseif as == "s" then
                if al then
                    aq = tonumber("-" .. tostring(NiggaToggle.FlySpeed))
                else
                    aq = NiggaToggle.FlySpeed
                end
            end
        end)
        x.KeyUp:Connect(function(as)
            if as == "w" then
                aq = 0
            elseif as == "s" then
                aq = 0
            end
        end)
        local at = {}
        at.IsRunning = true
        at.Part = ak
        at.Storage = am
        at.MT = ar
        spawn(function()
            repeat
                local au = z.CFrame
                local av = ak.Position
                local aw = (av - au.p).Magnitude
                ao.Position = (au * CFrame.new(0, 0, tonumber("-" .. tostring(aw)) + aq)).p + Vector3.new(0, 0.2225, 0)
                ap.CFrame = au
                wait()
            until at.IsRunning == false or z.CameraSubject ~= ak
            ao:Remove()
            ap:Remove()
            for E, ax in pairs(at.Storage:GetChildren()) do
                ax.Parent = at.Part
            end
            at.MT:Disconnect()
            at.Storage:Remove()
        end)
        return at
    end
    local A = workspace.Vehicles
    local function GetVehicleMain()
        local ai = LocalPlayer.Name
        for E, aj in pairs(A:GetChildren()) do
            if aj:FindFirstChild("Seat") and aj.Seat:FindFirstChild("PlayerName") and aj:FindFirstChild("Engine") then
                if aj.Seat.PlayerName.Value == ai then
                    return aj.Engine, false
                end
            elseif aj:FindFirstChild("Seat") and aj.Seat:FindFirstChild("PlayerName") and aj:FindFirstChild("Model") then
                if aj.Seat.PlayerName.Value == ai then
                    if aj.Model:FindFirstChild("Body") then
                        return aj.Model.Body, true
                    end
                end
            end
        end
    end
    VehicleTab:Button("Car Fly", function()
        if GetVehicleMain() ~= nil then
            Notification("Vehicle Fly Enabled")
            local az, al = GetVehicleMain()
            local aA = FlyPart(az, al)
            if al then
                repeat
                    wait()
                until az.Parent.Parent.Seat.PlayerName.Value ~= d.Name
            else
                repeat
                    wait()
                until az.Parent.Seat.PlayerName.Value ~= LocalPlayer.Name
            end
            wait(0.1)
            z.CameraSubject = N
            Notification("Vehicle Fly Disabled")
        else
            Notification("Vehicle Not Found")
        end
    end)
    VehicleTab:Box("Fly Speed", function(callback)
        NiggaToggle.FlySpeed = callback
    end)
    VehicleTab:Toggle("Anti Flip Over", function(arg)
        NiggaToggle.AntiFlip = arg
    end):Set(NiggaToggle.AntiFlip)
    VehicleTab:Toggle("No Tire Pop", function(arg)
        NiggaToggle.TirePop = arg
    end):Set(NiggaToggle.TirePop)
    VehicleTab:Toggle("Mobile Garage", function(arg)
        debug.setupvalue(require(ReplicatedStorage.Game.Garage.GarageUI).Toggle, 5, arg)
    end):Set(NiggaToggle.MobileGarage)
    VehicleTab:Toggle("Elon Musk Mode", function(arg)
        debug.setupvalue(require(ReplicatedStorage.Module.AlexChassis).OnAction, 8, arg)
    end):Set(NiggaToggle.AutoPilot)
    VehicleTab:Toggle("Injan Horn", function(arg)
        local id = LocalPlayer.UserId
        require(ReplicatedStorage.Resource.Settings).Perm.InjanHorn.Id[tostring(id)] = arg
    end):Set(NiggaToggle.InjanHorn)
    VehicleTab:Toggle("Rainbow Car (FLASH WARNING)", function(arg)
        NiggaToggle.RainbowCar = arg
    end):Set(NiggaToggle.RainbowCar)
    VehicleTab:Button("Unlock Skins", function()
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.Color).Items) do
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.InteriorMainColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.WindowColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.WheelColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.SpoilerColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.InteriorDetailColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.HeadlightsColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.SeatColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.Glow[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.BodyColor[v.Name] = true
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.SecondBodyColor[v.Name] = true
        end
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.Engine).Items) do
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.Engine[v.Name] = true
        end
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.Brakes).Items) do
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.Brakes[v.Name] = true
        end
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.SuspensionHeight).Items) do
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.SuspensionHeight[v.Name] = true
        end
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.StoreData.Rim).Items) do
            require(ReplicatedStorage.Game.Garage.GarageUI).Owned.Rim[v.Name] = true
        end
        for i,v in pairs(require(ReplicatedStorage.Game.ItemSkin.ItemSkinList)) do
            require(ReplicatedStorage.Game.ItemSkin.ItemSkin).ItemSkinsOwned[v.Name] = true
        end
    end)
    --[[VehicleTab:Button("Inf Nitro SS", function()
        if Client.GetVehiclePacket() then
            setconstant(Client.Nitro, 1, "lmao")
            Client.OnAction({Name = "Nitro"}, true)
            wait()
            Client.OnAction({Name = "Nitro"}, false)
            setconstant(Client.Nitro, 1, "tick")
        else
            Notification("Make sure you are in a vehicle!")
        end
    end)]]
    local sv = VehicleTab:Dropdown("Spawn Vehicle", function(selected)
        for i,v in pairs(require(ReplicatedStorage.Game.Garage.VehicleData)) do
            if tostring(v.Make) == tostring(selected) then
                Client.SpawnVehicle(v)
            end
        end
    end)
    for i,v in pairs(require(ReplicatedStorage.Game.Garage.VehicleData)) do
        if not rawget(v, "NoGarageSpawn") then
            sv:Add(v.Make)
        end
    end
    _G.BankRobbed = nil
    _G.JewRobbed = nil
    _G.MusRobbed = nil
    _G.TrainRobbed = nil
    _G.PlaneRobbed = nil
    _G.ShipRobbed = 0
    _G.AutoRobbing = nil
    _G.PPRobbed = nil
    local function TPBuilding()
        for i,v in pairs(workspace.Buildings:GetDescendants()) do
            if v:IsA("Texture") and v.Color3 == Color3.fromRGB(83,123,186) then
                v.Parent.CanCollide = false
                TP(v.Parent.CFrame)
                break
            end
        end
    end
    local function CheckMoney(b)local c=b:gsub("[%p%s]","")return tonumber(c) end
    local function RobBank()
        if _G.AutoRobbing or _G.BankRobbed then return end
        _G.AutoRobbing = true
        if workspace.Banks:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency > 0.5 then
            SendNotification('Bank', 'Open', 3)
            local BankMain = workspace.Banks:FindFirstChildOfClass("Model").Layout:FindFirstChildOfClass("Model")
            TP(BankMain.Begin.CFrame + Vector3.new(0,5,0))
            wait(0.5)
            TP(BankMain.TriggerDoor.CFrame + Vector3.new(0,5,0))
            wait(0.7)
            TP(BankMain.Money.CFrame)
            BankMain.Lasers:Destroy()
            repeat wait(0.5)
            until LocalPlayer.PlayerGui.MainGui.CollectMoney.Visible or workspace.Banks:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency == 0
            repeat wait(0.5)
            until CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Money.Text) == CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Maximum.Text) or not LocalPlayer.PlayerGui.MainGui.CollectMoney.Visible or LocalPlayer.Character:FindFirstChild("Handcuffs") or workspace.Banks:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency == 0
            wait()
            TPBuilding()
            _G.BankRobbed = true
            _G.AutoRobbing = false
        else
            SendNotification('Bank', 'Closed', 3)
            TPBuilding()
            _G.AutoRobbing = false
        end
    end
    local function RobJew()
        if _G.AutoRobbing or _G.JewRobbed then return end
        _G.AutoRobbing = true
        if workspace.Jewelrys:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency > 0.5 then
            local JewMain = workspace.Jewelrys:FindFirstChildOfClass("Model")
            SendNotification('Jewelry', 'Open', 3)
            TP(JewMain:FindFirstChild("WindowEntry").LaserTouch.CFrame + Vector3.new(0,1,0))
            wait(1.5)
            for i,v in next, workspace.Jewelrys:GetDescendants() do
                if v.Name == "BarbedWire" then
                    v:Destroy()
                end
            end
            for i, part in pairs(JewMain.Boxes:GetChildren()) do
                local pos = CFrame.new(part.Position - part.CFrame.LookVector * 2, part.Position)
                if LocalPlayer.PlayerGui.MainGui.CollectMoney.Visible and CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Money.Text) == CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Maximum.Text) or LocalPlayer.Character:FindFirstChild("Handcuffs") then
                    break
                end
                TP(pos)
                wait(0.2)
                Punch(8)
                wait(0.3)
            end
            TPBuilding()
            wait(2)
            TP(CFrame.new(1761.20618, 52.1366386, -1790.52783))
            wait(2)
            TPBuilding()
            _G.JewRobbed = true
            _G.AutoRobbing = false
        else
            SendNotification('Jewelry', 'Closed', 3)
            TPBuilding()
            _G.AutoRobbing = false
        end
    end
    local function CheckMuseum()
        for i,v in pairs(workspace.Museum.Roof.Hole:GetChildren()) do
            if v:FindFirstChildOfClass("Texture") then
                if v.Transparency == 0 then
                    return false
                end
                return true
            end
        end
    end
    local function RobMuseum()
        if _G.AutoRobbing or _G.MusRobbed then return end
        _G.AutoRobbing = true
        if not CheckMuseum() then
            for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                if v.Name == "Place Dynamite" and v.Part:IsDescendantOf(workspace.Museum) and v.Enabled then
                    v:Callback(true)
                    break
                end
            end
        end
        wait(1)
        if not CheckMuseum() then 
            SendNotification('Museum', 'Closed', 3)
            _G.AutoRobbing = false
            TPBuilding()
            return 
        end
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Grab Bone" and v.Enabled and v.Part then
                TP(v.Part.CFrame)
                wait(0.3)
                for count = 1,8 do
                    v:Callback(true)
                end
                break
            end
        end
        TPBuilding()
        wait(2)
        local WaitTime = 16
        if not Client.GetLocalEquipped() then
            WaitTime = 18
            for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                if v.Name == "Grab Bone" and v.Enabled and v.Part then
                    TP(v.Part.CFrame)
                    wait(0.3)
                    for count = 1,8 do
                        v:Callback(true)
                    end
                    break
                end
            end
            TPBuilding()
        end
        SendNotification('Museum', 'bypassing', 5)
        wait(WaitTime)
        TP(CFrame.new(1761.20618, 52.1366386, -1790.52783))
        require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip()
        wait(2)
        TPBuilding()
        _G.MusRobbed = true
        _G.AutoRobbing = false
        return
    end
    local function RobPlane()
        if _G.AutoRobbing or _G.PlaneRobbed then return end
        _G.AutoRobbing = true
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Inspect Crate" and v.Part then
                TP(v.Part.CFrame)
                wait(0.2)
                v:Callback(true)
                wait(0.3)
                TPBuilding()
                if not Client.GetLocalEquipped() then
                    for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                        if v.Name == "Inspect Crate" and v.Part then
                            TP(v.Part.CFrame)
                            wait(0.2)
                            v:Callback(true)
                            wait(0.3)
                            TPBuilding()
                            break
                        end
                    end
                end
                wait(2)
                TP(CFrame.new(-393.667542, 21.2136765, 2025.38611))
                wait(2)
                TPBuilding()
                require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip()
                _G.PlaneRobbed = true
                _G.AutoRobbing = false
                return true
            end
        end
        _G.AutoRobbing = false
        TPBuilding()
        SendNotification("Plane", "Closed", 2)
        return false
    end
    local function RobTrain()
        if _G.AutoRobbing or _G.TrainRobbed then return end
        _G.AutoRobbing = true
        for i,v in pairs(workspace.Trains:GetChildren()) do
            if v.Name == "BoxCar" then
                for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                    if v.Part:IsDescendantOf(workspace.Trains) then
                        v:Callback(true)
                    end
                end
                wait(1)
                TP(v.Model.Rob.Gold.CFrame + Vector3.new(0, 1, 0))
                repeat wait(0.5)
                until LocalPlayer.PlayerGui.MainGui.CollectMoney.Visible or #workspace.Trains:GetChildren() == 0
                repeat wait(0.5)
                until CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Money.Text) == CheckMoney(LocalPlayer.PlayerGui.MainGui.CollectMoney.Maximum.Text) or #workspace.Trains:GetChildren() == 0 or not LocalPlayer.PlayerGui.MainGui.CollectMoney.Visible or LocalPlayer.Character:FindFirstChild("Handcuffs")
                wait()
                TPBuilding()
                _G.TrainRobbed = true
                _G.AutoRobbing = false
                return true
            elseif v.Name == "SteamEngine" then
                for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                    if v.Name == "Grab briefcase" then
                        v:Callback(true)
                        wait(1)
                    end
                 end
                 TP(CFrame.new(1761.20618, 52.1366386, -1790.52783))
                 require(ReplicatedStorage.Game.ItemSystem.ItemSystem).Unequip()
                 wait(1.5)
                 TPBuilding()
                 _G.TrainRobbed = true
                 _G.AutoRobbing = false
                 return true
            end
        end
        TPBuilding()
        SendNotification("Train", "Closed", 2)
        _G.AutoRobbing = false
        return false
    end
    local function RobAirdrop()
        if _G.AutoRobbing then return end
        _G.AutoRobbing = true
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Pick up briefcase" and v.Part then
                TP(v.Part.CFrame)
                wait(0.2)
                v:Callback(true)
                break
            end
        end
        TPBuilding()
        _G.AutoRobbing = false
    end
    local function RobShip()
        if _G.AutoRobbing or _G.ShipRobbed == 2 then return end
        _G.AutoRobbing = true
        local Ship = workspace:FindFirstChild("CargoShip")
        local Crate = Ship and Ship.Crates:FindFirstChild("Crate")
        if Crate then
            for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                if v.Name == "Hijack" then
                    v:Callback(true)
                end
            end
            for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                if v.Name == "Enter Driver" then
                    if v.ValidRoot.Name == "LittleBird" and Client.VehiclesOwned.LittleBird then
                        v:Callback(true)
                    end
                    if v.ValidRoot.Name == "BlackHawk" and Client.VehiclesOwned.BlackHawk then
                        v:Callback(true)
                    end
                end
            end
            wait(0.6)
            if not Client.GetVehiclePacket() then
                for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                    if v.Name == "Enter Driver" and v.ValidRoot.Name == "Heli" then
                        v:Callback(true)
                    end
                end
            end
            wait(0.5)
            if not Client.GetVehiclePacket() then
                _G.AutoRobbing = false
                return
            end
            Client.Vehicle.Heli.OnAction({Name = "Rope"}, true)
            wait(0.2)
            TP(Crate:GetPrimaryPartCFrame() + Vector3.new(0,30,0))
            wait(0.1)
            Client.Network:FireServer(Client.Hashes.GrabCrate, Crate, Vector3.new())
            wait(1.5)
            TP(CFrame.new(-466.427094, 15, 1903.74011, -0.0499384888, -6.51072918e-10, -0.998752296, -2.55000749e-08, 1, 6.23139762e-10, 0.998752296, 2.54993768e-08, -0.0499384888))
            Crate:SetPrimaryPartCFrame(CFrame.new(-466.427094, 0, 1903.74011, -0.0499384888, -6.51072918e-10, -0.998752296, -2.55000749e-08, 1, 6.23139762e-10, 0.998752296, 2.54993768e-08, -0.0499384888))
            wait(0.2)
            Client.Vehicle.Heli.OnAction({Name = "Rope"}, true)
            wait(0.2)
            Client.ExitCar()
            wait(0.3)
            TPBuilding()
            _G.AutoRobbing = false
            _G.ShipRobbed = _G.ShipRobbed + 1
        else
            _G.AutoRobbing = false
            SendNotification("Cargo Ship", "Closed", 2)
        end
    end
    local function RobPowerPlant()
        if _G.AutoRobbing or _G.PPRobbed or not request then return end
        _G.AutoRobbing = true
        if workspace.PowerPlant.Smoke.Particle.Enabled then
            local Puzzle = getupvalue(require(ReplicatedStorage.Game.Robbery.PuzzleFlow).Init, 3)
            TP(CFrame.new(694.3, 60, 2374.1) * CFrame.Angles(0, math.pi, 0))
            repeat wait(0.5)
                LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = (CFrame.new(694.3, 60, 2374.1) * CFrame.Angles(0, math.pi, 0))
                if not workspace.PowerPlant.Smoke.Particle.Enabled then
                    TPBuilding()
                    _G.AutoRobbing = false
                    return false
                end
            until Puzzle.IsOpen and Puzzle.Grid
            for _, v in ipairs(Puzzle.Grid) do
                for i, v2 in ipairs(v) do
                    v[i] = v2 + 1
                end
            end
            local Sucess, Respond = pcall(request, {
                Url = "https://numberlink-solver.herokuapp.com/api/solve", Method = "POST", Body = HttpService:JSONEncode({matrix = Puzzle.Grid}), Headers = {["Content-Type"] = "application/json"}
            })
            if Sucess and type(Respond) == "table" and rawget(HttpService:JSONDecode(Respond.Body), "solution") then
                Puzzle.Grid = HttpService:JSONDecode(Respond.Body).solution
                for _, v in ipairs(Puzzle.Grid) do
                    for i, v2 in ipairs(v) do
                        v[i] = v2 - 1
                    end
                end
                Puzzle.OnConnection()
                repeat wait(0.5) until not Puzzle.IsOpen
                TP(CFrame.new(672.5, 57.3, 2387.4))
                wait(1)
                repeat wait(0.5)
                    LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = CFrame.new(657.5, 57.3, 2386.7)
                    if not workspace.PowerPlant.Smoke.Particle.Enabled then
                        TPBuilding()
                        _G.AutoRobbing = false
                        return false
                    end
                until Puzzle.IsOpen and Puzzle.Grid
                for _, v in ipairs(Puzzle.Grid) do
                    for i, v2 in ipairs(v) do
                        v[i] = v2 + 1
                    end
                end
                local Sucess, Respond = pcall(request, {
                    Url = "https://numberlink-solver.herokuapp.com/api/solve", Method = "POST", Body = HttpService:JSONEncode({matrix = Puzzle.Grid}), Headers = {["Content-Type"] = "application/json"}
                })
                if Sucess and type(Respond) == "table" and rawget(HttpService:JSONDecode(Respond.Body), "solution") then
                    Puzzle.Grid = HttpService:JSONDecode(Respond.Body).solution
                    for _, v in ipairs(Puzzle.Grid) do
                        for i, v2 in ipairs(v) do
                            v[i] = v2 - 1
                        end
                    end
                    Puzzle.OnConnection()
                    wait(1)
                    TPBuilding()
                    wait(5)
                    repeat wait()
                    until LocalPlayer.PlayerGui.PowerPlantRobberyGui.Price.TextLabel.Text == "Uranium Value: $5,750"
                    TP(CFrame.new(1761.20618, 52.1366386, -1790.52783))
                    wait(1.5)
                    TPBuilding()
                    _G.AutoRobbing = false
                    _G.PPRobbed = true
                    return true
                else
                    if Puzzle.IsOpen then
                        Puzzle:Hide()
                    end
                    _G.AutoRobbing = false
                    TPBuilding()
                    return false
                end
            else
                if Puzzle.IsOpen then
                    Puzzle:Hide()
                end
                _G.AutoRobbing = false
                TPBuilding()
                return false
            end
        else
            _G.AutoRobbing = false
            SendNotification("Power Plant", "Closed", 2)
            return false
        end
    end
    local function PickCash()
        if _G.AutoRobbing then return end
        _G.AutoRobbing = true
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Tag.Name == "Cash" then
                TP(v.Part.CFrame)
                wait(0.2)
                v:Callback(true)
                wait(0.5)
            end
        end
        TPBuilding()
        _G.AutoRobbing = false
    end
    local function RobSmall()
        if _G.AutoRobbing then return end
        _G.AutoRobbing = true
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Rob" then
                v:Callback(false)
                wait()
                v:Callback(true)
            end
        end
        _G.AutoRobbing = false
    end
    FarmingTab:Box("Arrest Player", function(callback)
        if LocalPlayer.Team ~= game.Teams.Police then
            Notification("You are not Police!")
            return
        end
        for _,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) then
                for i = 1, 10 do
                    Equip("Handcuffs")
                    if v.Character:FindFirstChild('InVehicle') then
                        Client.Network:FireServer(Client.Hashes.Eject, v.Name)
                    end
                    TP(v.Character:WaitForChild('HumanoidRootPart').CFrame)
                    Client.Arrest(v)
                    wait(0.2)
                end
                return
            end
        end
    end)
    local BankLabel = FarmingTab:Label("Bank")
    local JewLabel = FarmingTab:Label("Jewelry")
    local MusLabel = FarmingTab:Label("Museum")
    local TrainLabel = FarmingTab:Label("Train")
    local PlaneLabel = FarmingTab:Label("Plane")
    local PPLabel = FarmingTab:Label("Power Plant")
    local ShipLabel = FarmingTab:Label("Cargo Ship")
    local CurrentMoney = LocalPlayer.leaderstats.Money.Value
    local MoneyEarnedString = "Money Earned: %s$"
    local AutoRobCooldown = 0
    spawn(function()
        while wait(0.5) do
            if workspace.Banks:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency == 0 then
                _G.BankRobbed = false
                BankLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                BankLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
            if workspace.Jewelrys:FindFirstChildOfClass("Model").Extra.Sign.Decal.Transparency == 0 then
                _G.JewRobbed = false
                JewLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                JewLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
            for i,v in pairs(workspace.Museum.Roof.Hole:GetChildren()) do
                if v:FindFirstChildOfClass("Texture") then
                    if v.Transparency == 0 then
                        _G.MusRobbed = false
                        MusLabel:SetColor(Color3.fromRGB(255, 0, 0))
                    else
                        MusLabel:SetColor(Color3.fromRGB(0, 255, 0))
                    end
                end
            end
            if #workspace.Trains:GetChildren() == 0 then
                _G.TrainRobbed = false
                TrainLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                TrainLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
            if not workspace:FindFirstChild("Plane") then
                _G.PlaneRobbed = false
                PlaneLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                PlaneLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
            if not workspace:FindFirstChild("CargoShip") then
                _G.ShipRobbed = 0
                ShipLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                ShipLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
            if not workspace.PowerPlant.Smoke.Particle.Enabled then
                _G.PPRobbed = false
                PPLabel:SetColor(Color3.fromRGB(255, 0, 0))
            else
                PPLabel:SetColor(Color3.fromRGB(0, 255, 0))
            end
        end
    end)
    local MoneyEarned = FarmingTab:Label(MoneyEarnedString:format("0"))
    FarmingTab:Toggle("Auto Rob", function(arg)
        CurrentMoney = LocalPlayer.leaderstats.Money.Value
        NiggaToggle.Autorob = arg
    end):Set(NiggaToggle.Autorob)
    FarmingTab:Slider("Auto Rob Cooldown", function(callback)
        AutoRobCooldown = tonumber(callback)
    end, {
        min = 0,
        max = 10
    })
    FarmingTab:Toggle("Auto Arrest", function(arg)
        if arg and LocalPlayer.Team ~= game.Teams.Police then
            Client.Network:FireServer(Client.Hashes.TeamChange, "Police")
            wait(1.5)
        end
        NiggaToggle.AutoArrest = arg
    end):Set(NiggaToggle.AutoArrest)
    FarmingTab:Button("Rob Small Stores", function()
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Name == "Rob" then
                v:Callback(false)
                wait()
                v:Callback(true)
            end
        end
    end)
    FarmingTab:Button("Grab Dropped Cash", function()
        local ogpos = LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame
        for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
            if v.Tag.Name == "Cash" then
                TP(v.Part.CFrame)
                wait(0.2)
                v:Callback(true)
                wait(0.5)
            end
        end
        TP(ogpos)
    end)
    FarmingTab:Button("Remove Lasers", function()
        for i,v in next, workspace:GetDescendants() do
            if v.Name == "BarbedWire" and not v:IsDescendantOf(workspace.MilitaryIsland) then
                v:Destroy()
            end
        end
    end)
    FunTab:Box("Loop Eject Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) and not table.find(whitelisted, v.Name) then
                table.insert(LoopEject, v.Name)
            end
        end
    end)
    FunTab:Box("Unloop Eject Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) then
                if table.find(LoopEject, v.Name) then
                    table.remove(LoopEject, table.find(LoopEject, v.Name))
                end
            end
        end
    end)
    FunTab:Box("Play Firework", function(callback)
        if tonumber(callback) then
            Client.Fireworks(tonumber(callback))
        end
    end)
    FunTab:Box("Give Money", function(callback)
        if tonumber(callback) then
            Client.PlusCash(tonumber(callback), "this is fake nigga")
        end
    end)
    FunTab:Box("Eject Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback)))  then
                Client.Network:FireServer(Client.Hashes.Eject, v.Name)
                return
            end
        end
    end)
    FunTab:Toggle("Click Nuke", function(arg)
        NiggaToggle.Nuke = arg
    end):Set(NiggaToggle.Nuke)
    FunTab:Toggle("Alt + Click Destroy", function(arg)
        NiggaToggle.ClickDestroy = arg
    end):Set(NiggaToggle.ClickDestroy)
    FunTab:Toggle("Annoy Server", function(arg)
        NiggaToggle.Annoy = arg
    end):Set(NiggaToggle.Annoy)
    FunTab:Toggle("Spam Hats", function(arg)
        NiggaToggle.Hats = arg
    end):Set(NiggaToggle.Hats)
    FunTab:Button("Volcano Eruption", function()
        firetouchinterest(LocalPlayer.Character:WaitForChild('HumanoidRootPart'), workspace.LavaFun.Lavatouch, 0)
        wait()
        firetouchinterest(LocalPlayer.Character:WaitForChild('HumanoidRootPart'), workspace.LavaFun.Lavatouch, 1)
    end)
    if sethiddenproperty then
        FunTab:Button("Teleport All Unanchored Part to You", function()
            for i, v in pairs(workspace:GetDescendants()) do
                if hasprop(v, "Anchored") == false and not v:IsDescendantOf(LocalPlayer.Character) then
                    v.CFrame = CFrame.new(LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position + Vector3.new(math.random(-50,50),50,math.random(-50,50)))
                end
            end
        end)
        FunTab:Button("Teleport All Vehicle to You", function()
            for i,v in pairs(workspace.Vehicles:GetChildren()) do
                v:SetPrimaryPartCFrame(CFrame.new(LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position + Vector3.new(math.random(-50,50),50,math.random(-50,50))))
            end
        end)
    end
    local playd = FunTab:Dropdown("Play Sound", function(callback)
        Client.PlaySound(callback, {
            Source = workspace, 
            Volume = math.huge, 
            Multi = true,
            MaxTime = 10
        }, false);
    end)
    for i,v in pairs(require(ReplicatedStorage.Resource.Settings).Sounds) do
        playd:Add(i)
    end
    SettingTab:Box("Whitelist Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) and not table.find(whitelisted, v.Name) then
                table.insert(whitelisted, v.Name)
            end
        end
    end)
    SettingTab:Box("Unwhitelist Player", function(callback)
        for i,v in pairs(Players:GetPlayers()) do
            if string.find(string.lower(v.Name), string.lower(tostring(callback))) then
                if table.find(whitelisted, v.Name) then
                    table.remove(whitelisted, table.find(whitelisted, v.Name))
                end
            end
        end
    end)
    SettingTab:Button("Copy Discord Link", function()
        setclipboard("https://discord.gg/Dt7Tw4W")
    end)
    SettingTab:Button("Panic", function()
        for i,v in pairs(AllToggle) do
            v:Set(false)
        end
    end)
    SettingTab:Button("Rejoin To Same Server", function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
    end)
    SettingTab:Bind("Toggle GUI Key", function(obj)
        ui_options.toggle_key = obj
    end, {
        ["standard"] = ui_options.toggle_key,
    })
    SettingTab:Label("UI Color")
    local cp = SettingTab:ColorPicker(function(color)
        ui_options.main_color = color
    end)
    SettingTab:Toggle("Rainbow UI", function(arg)
        NiggaToggle.RainbowUI = arg
    end):Set(NiggaToggle.RainbowUI)
    SettingTab:Label("Credits:")
    SettingTab:Label("Singularity#5490 for ui library")
    SettingTab:Label("NAME4YOU#0001 for new bypasses")
    SettingTab:Label(string.format("Version: %s", Version))
    spawn(function()
        while RunService.Stepped:Wait() do
            if NiggaToggle.NoClip then
                for i,v in pairs(LocalPlayer.Character:GetChildren()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
            if NiggaToggle.Hats then
                firehatoff()
            end
            if sethiddenproperty then
                sethiddenproperty(LocalPlayer, "MaximumSimulationRadius", math.pow(math.huge,math.huge)*math.huge)
                sethiddenproperty(LocalPlayer, "SimulationRadius", math.pow(math.huge,math.huge)*math.huge)
            end
        end
    end)
    local Mouse = LocalPlayer:GetMouse()
    Mouse.Button1Down:Connect(function()
        if NiggaToggle.Nuke then
            require(ReplicatedStorage.Game.Notification).new({
                Text = "Nuke is incoming! (client sided)",
            })
            Client.Nuke({
                Nuke = {
                    Origin = Vector3.new(),
                    Speed = 650,
                    Duration = 10,
                    Target = Mouse.Hit.p,
                    TimeDilation = 1.5
                },
                Shockwave = {
                    Duration = 20,
                    MaxRadius = 500
                }
            })
        end
        if NiggaToggle.ClickTp then
            TP(Mouse.Hit)
        end
        if NiggaToggle.ClickDestroy and UIS:IsKeyDown(Enum.KeyCode.LeftAlt) then
            Mouse.Target:Destroy()
        end
    end)
    spawn(function()
        while wait(0.5) do
            writefile("Tesla.json", HttpService:JSONEncode(NiggaToggle))
            if NiggaToggle.Autorob then
                MoneyEarned:Set(MoneyEarnedString:format(FormatMoney(LocalPlayer.leaderstats.Money.Value - CurrentMoney)))
            end
            if NiggaToggle.KillAura then
                Client.GiveGun({ Part = { Parent = { Name = "PlasmaPistol" } }, CanGrab = true }, true)
                for _,k in pairs(LocalPlayer.PlayerGui.HotbarGui.Container:GetChildren()) do
                    if k:IsA("ImageButton") and k.Icon.Image == "rbxassetid://4751591788" then
                        Client.Network:FireServer(Client.Hashes.Equip, {i = k.Name, Name = "PlasmaPistol"})
                        pcall(function()
                            for _,v in pairs(Players:GetPlayers()) do
                                local HRP = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                                if v ~= LocalPlayer and HRP and not table.find(whitelisted, v.Name) and v.Team ~= LocalPlayer.Team and v.Character.Humanoid.Health ~= 0 then
                                    for i = 1, 17 do
                                        Client.Network:FireServer(Client.Hashes.Damage, HRP.Position, HRP)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
            if NiggaToggle.KillAuraLTP then
                Client.GiveGun({ Part = { Parent = { Name = "PlasmaPistol" } }, CanGrab = true }, true)
                pcall(function()
                    for _,v in pairs(Players:GetPlayers()) do
                        local HRP = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                        if v ~= LocalPlayer and HRP and not table.find(whitelisted, v.Name) and v.Team ~= LocalPlayer.Team and v.Character.Humanoid.Health ~= 0 and v.Team ~= game.Teams.Prisoner then
                            if v.Character:FindFirstChild('InVehicle') then
                                Client.Network:FireServer(Client.Hashes.Eject, v.Name)
                            end
                            for _,k in pairs(LocalPlayer.PlayerGui.HotbarGui.Container:GetChildren()) do
                                if k:IsA("ImageButton") and k.Icon.Image == "rbxassetid://4751591788" then
                                    Client.Network:FireServer(Client.Hashes.Equip, {['i'] = k.Name, Name = "PlasmaPistol"})
                                    TP(HRP.CFrame)
                                    for i = 1, 17 do
                                        Client.Network:FireServer(Client.Hashes.Damage, HRP.Position, HRP)
                                    end
                                end
                            end
                        end
                    end
                end)
            end
            if NiggaToggle.Eject then
                for i,v in pairs(Players:GetPlayers()) do
                    if not table.find(whitelisted, v.Name) then
                        Client.Network:FireServer(Client.Hashes.Eject, v.Name)
                    end
                end
            end
            for i,v in pairs(LoopEject) do
                Client.Network:FireServer(Client.Hashes.Eject, v)
            end
            if NiggaToggle.TazeAll then
                for i,v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and not table.find(whitelisted, v.Name) then
                        Taze(v);
                    end;
                end;
            end
            if NiggaToggle.TazeAura then
                pcall(function()
                    for i,v in next, Players:GetPlayers() do
                        local HRP = v.Character and v.Character:FindFirstChild("HumanoidRootPart")
                        if v ~= Players and HRP and (LocalPlayer.Character:WaitForChild('HumanoidRootPart').Position - HRP.Position).magnitude < 50 and not table.find(whitelisted, v.Name) then
                            Taze(v);
                        end
                    end
                end)
            end
        end
    end)
    spawn(function()
        local uic = 0
        while wait() do
            local gv = Client.GetVehiclePacket()
            if gv then
                gv.GarageEngineSpeed = _G.EngineSpeed or gv.GarageEngineSpeed
                gv.Height = _G.Height or gv.Height
                gv.TurnSpeed = _G.TurnSpeed or gv.TurnSpeed
                gv.GarageBrakes = _G.Brake or gv.GarageBrakes
                if NiggaToggle.TirePop then
                    gv.TirePopDuration = 0
                end
                if NiggaToggle.AntiFlip then
                    Client.OnAction({Name = "Flip"}, true)
                end
                if NiggaToggle.RainbowCar then 
                    local v = { Name = Colors[math.random(1,#Colors)] }
                    Client.ModifyCar(v, { Name = "BodyColor" })
                    Client.ModifyCar(v, { Name = "WindowColor" })
                    Client.ModifyCar(v, { Name = "SpoilerColor" })
                    Client.ModifyCar(v, { Name = "WheelColor" })
                    Client.ModifyCar(v, { Name = "SecondBodyColor" })
                    Client.ModifyCar(v, { Name = "Glow" })
                    Client.ModifyCar(v, { Name = "HeadlightsColor" })
                end
            end
            if NiggaToggle.NoWait then
                for i,v in pairs(require(ReplicatedStorage.Module.UI).CircleAction.Specs) do
                    v.Timed = false;
                end
            end
            if NiggaToggle.GodMode then
                Client.GiveDonut()
                Client.Network:FireServer(Client.Hashes.EatDonut)
            end
            if NiggaToggle.Annoy then
                Client.PlaySound("FireworkBang", {
                    Source = workspace, 
                    Volume = math.huge, 
                    Multi = true,
                }, false)
                Client.PlaySound("Horn", {
                    Pitch = math.huge,
                    Source = workspace, 
                    Volume = math.huge, 
                    Multi = true,
                    MaxTime = 0.1
                }, false)
            end
            if NiggaToggle.RainbowUI then
                cp:Set(Color3.fromHSV(zigzag(uic),1,1))
                uic = uic + 0.01
            end
        end
    end)
    spawn(function()
        while wait() do
            if NiggaToggle.Autorob and LocalPlayer.Team ~= game.Teams.Police then
                RobBank()
                wait(AutoRobCooldown)
                RobJew()
                wait(AutoRobCooldown)
                RobMuseum()
                wait(AutoRobCooldown)
                RobPlane()
                wait(AutoRobCooldown)
                RobTrain()
                wait(AutoRobCooldown)
                RobShip()
                wait(AutoRobCooldown)
                if _G.ShipRobbed == 1 then
                    RobShip()
                    wait(AutoRobCooldown)
                end
                RobPowerPlant()
                wait(AutoRobCooldown)
                RobSmall()
                wait(AutoRobCooldown)
                PickCash()
                RobAirdrop()
                wait(10)
            end
        end
    end)
    spawn(function()
        while wait() do
            if NiggaToggle.AutoArrest then
                for i,v in pairs(Players:GetPlayers()) do
                    if not table.find(whitelisted, v.Name) and v.Team == game.Teams.Criminal and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(Equip, "Handcuffs")
                        if not v.Character:FindFirstChild("Handcuffs") then
                            for i = 1, 10 do
                                if v.Character:FindFirstChild('InVehicle') then
                                    Client.Network:FireServer(Client.Hashes.Eject, v.Name)
                                end
                                TP(v.Character:WaitForChild('HumanoidRootPart').CFrame)
                                Client.Arrest(v)
                                wait(0.2)
                            end
                        end
                    end
                end
            end
        end
    end)
    spawn(function()
        while wait(3) do
            if NiggaToggle.OpenDoors then
                for i,v in ipairs(Client.Doors) do
                    Client.OpenDoor(v)
                end
            end
            if NiggaToggle.Autobreakout then
                if LocalPlayer.Character and LocalPlayer.Team == game.Teams.Prisoner then
                    TP(CFrame.new(1730.87537, 20.45331, -1727.92773))
                    Notification("Escaping...")
                end
            end
        end
    end)
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__newindex
    mt.__newindex = newcclosure(function(self, index, newindex)
        if index == "WalkSpeed" then
            if _G.WalkSpeed == 16 then
                return old(self, index, newindex)
            end
            newindex = _G.WalkSpeed
        end
        return old(self, index, newindex)
    end)
    LocalPlayer.Idled:connect(function()
        VU:Button2Down(Vector2.new(), workspace.CurrentCamera.CFrame)
        wait(1)
        VU:Button2Up(Vector2.new(), workspace.CurrentCamera.CFrame)
    end)
    LocalPlayer.Character:WaitForChild("Humanoid").Died:Connect(function()
        if NiggaToggle.Autorob and _G.AutoRobbing then
            _G.AutoRobbing = false
        end
    end)
    LocalPlayer.CharacterAdded:Connect(function(c)
		c:WaitForChild("Humanoid").Died:Connect(function()
            if NiggaToggle.Autorob and _G.AutoRobbing then
                _G.AutoRobbing = false
            end
		end)
	end)
    Notification(IsSiff and "hi love!" or "Thanks for using Tesla!")
    library:FormatWindows();
    library:Ready();
    Client.Fireworks(10);
end
local function LoadIntro()
    getgenv().TeslaLoaded = true

    local blur = Instance.new("BlurEffect", game.Lighting)
    blur.Size = 0
    local ScreenGui = Instance.new("ScreenGui")
    local ImageLabel = Instance.new("ImageLabel")
    ScreenGui.Parent = game.CoreGui
    ImageLabel.Parent = ScreenGui
    ImageLabel.BackgroundColor3 = Color3.new(1, 1, 1)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Position = UDim2.new(0.5, -(303 / 2), 0.5, -(263 / 2))
    ImageLabel.Rotation = 0
    ImageLabel.Size = UDim2.new(0, 303,0, 263)
    ImageLabel.Image = "rbxassetid://4733685600"
    ImageLabel.ImageTransparency = 1
    for i = 1, 50, 2 do
        blur.Size = i
        ImageLabel.ImageTransparency = ImageLabel.ImageTransparency - 0.1
        wait()
    end
    wait(0.1)
    
    for i = 1, 50, 2 do
        blur.Size = 50 - i
        ImageLabel.ImageTransparency = ImageLabel.ImageTransparency + 0.1
        wait()
    end
    blur:Destroy()
    ScreenGui:Destroy()
    LoadTesla()
end
if IsJailbreak and HasAll and not table.find(blacklisted, HWID) then
    if getgenv().TeslaLoaded then
        Notification("Tesla is already loaded!")
    else
        LoadIntro()
    end
else
    LocalPlayer:Kick("Not Jailbreak/Exploit Not Supported")
    return
end


-- Extra Security, cause why not? Removed the last hook since it didn't work. (Something I added a while ago, don't know why I just wanted an Anti-HTTP Logger n shit. Lol
--[[
local ol;
ol = hookfunction(print, function(self, ...)
        local args = {...};
    if string.match(tostring(self),"http") then
        self = 'github'
        if game.CoreGui:FindFirstChild('DevConsoleMaster') then
            game.CoreGui:FindFirstChild('DevConsoleMaster'):Destroy()
        end
        LocalPlayer:Kick("no")
    end
    return ol(self,...)
end)
local ol2;
ol2 = hookfunction(warn, function(self, ...)
        local args = {...};
    if string.match(tostring(self),"http") then
        self = 'tesla'
        LocalPlayer:Kick("no")
    end
    return ol(self,...)
end)
local ol3;
ol3 = hookfunction(warn, function(self, ...)
        local args = {...};
    if string.match(tostring(self),"http") then
        self = '.com'
        LocalPlayer:Kick("no")
    end
    return ol(self,...)
end)
]]
