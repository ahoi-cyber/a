-- =========================================================================
-- LUMINA UI LIBRARY V2.6 PREMIUM (FULL CONFIG SYSTEM + DYNAMIC ISLAND)
-- Compatible 100% with Lumina Hub API & Executor FileSystem
-- =========================================================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")

local Lumina = {
    Version = "v2.6 Premium",
    Flags = {},
    Elements = {},
    ThemeObjects = {},
    CurrentTheme = "Dark",
    CustomColors = {},
    ConfigFolder = "LuminaHub",
    MemoryConfigs = {}, -- Dự phòng khi test trên Roblox Studio không có writefile
    ActiveWindow = nil,
    Icons = {
        home = "🏠",
        swords = "⚔️",
        user = "👤",
        settings = "⚙️",
        grid = "💠",
        palette = "🎨",
        folder = "📁",
        info = "ℹ️",
        star = "⭐"
    }
}

-- =========================================================================
-- 1. HỆ THỐNG BẢNG MÀU (50+ PRESETS & CUSTOM RGB)
-- =========================================================================
local BasePresets = {
    Dark        = {Main = Color3.fromRGB(26, 26, 32), Sidebar = Color3.fromRGB(20, 20, 25), Header = Color3.fromRGB(18, 18, 22), Element = Color3.fromRGB(36, 36, 44), Outline = Color3.fromRGB(58, 58, 68), Accent = Color3.fromRGB(85, 170, 255), Text = Color3.fromRGB(245, 245, 250), SubText = Color3.fromRGB(165, 165, 178)},
    Light       = {Main = Color3.fromRGB(242, 244, 248), Sidebar = Color3.fromRGB(230, 233, 240), Header = Color3.fromRGB(220, 224, 232), Element = Color3.fromRGB(255, 255, 255), Outline = Color3.fromRGB(200, 205, 215), Accent = Color3.fromRGB(37, 99, 235), Text = Color3.fromRGB(25, 28, 35), SubText = Color3.fromRGB(95, 102, 115)},
    Midnight    = {Main = Color3.fromRGB(14, 16, 26), Sidebar = Color3.fromRGB(10, 12, 20), Header = Color3.fromRGB(8, 10, 16), Element = Color3.fromRGB(22, 26, 40), Outline = Color3.fromRGB(42, 48, 72), Accent = Color3.fromRGB(99, 102, 241), Text = Color3.fromRGB(240, 244, 255), SubText = Color3.fromRGB(148, 163, 184)},
    Ocean       = {Main = Color3.fromRGB(15, 28, 42), Sidebar = Color3.fromRGB(12, 22, 34), Header = Color3.fromRGB(10, 18, 28), Element = Color3.fromRGB(22, 40, 58), Outline = Color3.fromRGB(45, 75, 105), Accent = Color3.fromRGB(56, 189, 248), Text = Color3.fromRGB(240, 249, 255), SubText = Color3.fromRGB(145, 180, 210)},
    Crimson     = {Main = Color3.fromRGB(30, 18, 22), Sidebar = Color3.fromRGB(24, 14, 18), Header = Color3.fromRGB(18, 10, 14), Element = Color3.fromRGB(44, 26, 32), Outline = Color3.fromRGB(78, 44, 54), Accent = Color3.fromRGB(244, 63, 94), Text = Color3.fromRGB(255, 241, 242), SubText = Color3.fromRGB(190, 150, 160)},
    Forest      = {Main = Color3.fromRGB(18, 28, 22), Sidebar = Color3.fromRGB(14, 22, 17), Header = Color3.fromRGB(11, 18, 14), Element = Color3.fromRGB(26, 40, 32), Outline = Color3.fromRGB(46, 72, 56), Accent = Color3.fromRGB(52, 211, 153), Text = Color3.fromRGB(236, 253, 245), SubText = Color3.fromRGB(150, 185, 165)},
    Emerald     = {Main = Color3.fromRGB(14, 30, 26), Sidebar = Color3.fromRGB(10, 24, 20), Header = Color3.fromRGB(8, 18, 15), Element = Color3.fromRGB(20, 44, 38), Outline = Color3.fromRGB(40, 82, 70), Accent = Color3.fromRGB(16, 185, 129), Text = Color3.fromRGB(236, 253, 245), SubText = Color3.fromRGB(145, 190, 175)},
    Violet      = {Main = Color3.fromRGB(26, 20, 38), Sidebar = Color3.fromRGB(20, 15, 30), Header = Color3.fromRGB(16, 12, 24), Element = Color3.fromRGB(38, 28, 54), Outline = Color3.fromRGB(68, 52, 95), Accent = Color3.fromRGB(168, 85, 247), Text = Color3.fromRGB(250, 245, 255), SubText = Color3.fromRGB(180, 160, 205)},
    Dracula     = {Main = Color3.fromRGB(40, 42, 54), Sidebar = Color3.fromRGB(33, 34, 44), Header = Color3.fromRGB(25, 26, 34), Element = Color3.fromRGB(52, 55, 70), Outline = Color3.fromRGB(98, 114, 164), Accent = Color3.fromRGB(189, 147, 249), Text = Color3.fromRGB(248, 248, 242), SubText = Color3.fromRGB(175, 182, 205)},
    Nord        = {Main = Color3.fromRGB(46, 52, 64), Sidebar = Color3.fromRGB(38, 43, 54), Header = Color3.fromRGB(32, 36, 46), Element = Color3.fromRGB(59, 66, 82), Outline = Color3.fromRGB(76, 86, 106), Accent = Color3.fromRGB(136, 192, 208), Text = Color3.fromRGB(236, 239, 244), SubText = Color3.fromRGB(180, 190, 205)},
    Matrix      = {Main = Color3.fromRGB(12, 18, 12), Sidebar = Color3.fromRGB(8, 14, 8), Header = Color3.fromRGB(5, 10, 5), Element = Color3.fromRGB(18, 28, 18), Outline = Color3.fromRGB(30, 65, 30), Accent = Color3.fromRGB(0, 255, 102), Text = Color3.fromRGB(210, 255, 210), SubText = Color3.fromRGB(115, 175, 115)},
    Sakura      = {Main = Color3.fromRGB(34, 24, 30), Sidebar = Color3.fromRGB(28, 19, 24), Header = Color3.fromRGB(22, 15, 19), Element = Color3.fromRGB(48, 34, 42), Outline = Color3.fromRGB(85, 58, 72), Accent = Color3.fromRGB(244, 114, 182), Text = Color3.fromRGB(253, 242, 248), SubText = Color3.fromRGB(205, 165, 185)}
}

-- Tự động sinh màu cho toàn bộ 51 Presets để không thiếu bất kỳ Theme nào trong danh sách
local AllPresetNames = {
    "Dark", "Light", "Midnight", "Forest", "Emerald", "Mint", "Sage",
    "Ocean", "Sky", "DeepBlue", "Arctic", "Crimson", "Rose", "Cherry",
    "Pink", "Blush", "Violet", "Lavender", "Plum", "Sunset", "Amber",
    "Gold", "Peach", "Chocolate", "Coffee", "Cream", "PastelBlue",
    "PastelPink", "PastelGreen", "PastelPurple", "NeonBlue", "NeonGreen",
    "NeonPink", "NeonOrange", "Matrix", "Dracula", "Nord", "Solarized",
    "Gruvbox", "Paper", "Monochrome", "Silver", "Graphite", "Sakura",
    "Aurora", "Galaxy", "Candy", "Oceanic", "Desert", "Tropical", "Winter", "Custom"
}

local HueSeeds = {
    Mint = 0.44, Sage = 0.36, Sky = 0.55, DeepBlue = 0.62, Arctic = 0.52,
    Rose = 0.95, Cherry = 0.98, Pink = 0.90, Blush = 0.92, Lavender = 0.76,
    Plum = 0.82, Sunset = 0.05, Amber = 0.10, Gold = 0.13, Peach = 0.07,
    Chocolate = 0.06, Coffee = 0.08, Cream = 0.12, PastelBlue = 0.58,
    PastelPink = 0.91, PastelGreen = 0.38, PastelPurple = 0.77, NeonBlue = 0.56,
    NeonGreen = 0.33, NeonPink = 0.88, NeonOrange = 0.06, Solarized = 0.52,
    Gruvbox = 0.09, Paper = 0.11, Monochrome = 0.0, Silver = 0.60,
    Graphite = 0.64, Aurora = 0.47, Galaxy = 0.74, Candy = 0.89,
    Oceanic = 0.53, Desert = 0.08, Tropical = 0.45, Winter = 0.57
}

Lumina.Themes = {}
for _, name in ipairs(AllPresetNames) do
    if BasePresets[name] then
        Lumina.Themes[name] = BasePresets[name]
    elseif name == "Custom" then
        Lumina.Themes["Custom"] = table.clone(BasePresets.Dark)
    else
        local h = HueSeeds[name] or 0.6
        local s = (name == "Monochrome" or name == "Silver" or name == "Graphite") and 0.05 or 0.35
        Lumina.Themes[name] = {
            Main    = Color3.fromHSV(h, s, 0.13),
            Sidebar = Color3.fromHSV(h, s, 0.10),
            Header  = Color3.fromHSV(h, s, 0.08),
            Element = Color3.fromHSV(h, s, 0.18),
            Outline = Color3.fromHSV(h, s, 0.28),
            Accent  = Color3.fromHSV(h, math.clamp(s + 0.45, 0.1, 0.9), 0.95),
            Text    = Color3.fromRGB(245, 245, 250),
            SubText = Color3.fromRGB(170, 175, 188)
        }
    end
end

-- =========================================================================
-- 2. TIỆN ÍCH CỐT LÕI (UTILITIES)
-- =========================================================================
local function GetSafeGuiParent()
    local ok, res = pcall(function()
        if gethui then return gethui() end
        return game:GetService("CoreGui")
    end)
    if ok and res then return res end
    return Players.LocalPlayer:WaitForChild("PlayerGui")
end

local function Create(className, props, children)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do inst[k] = v end
    for _, c in ipairs(children or {}) do c.Parent = inst end
    return inst
end

local function BindTheme(instance, property, key)
    table.insert(Lumina.ThemeObjects, {Instance = instance, Property = property, Key = key})
    local pal = Lumina.Themes[Lumina.CurrentTheme] or Lumina.Themes.Dark
    if pal[key] then instance[property] = pal[key] end
end

local function ApplyThemePalette(themeName)
    local pal = Lumina.Themes[themeName] or Lumina.Themes.Dark
    Lumina.CurrentTheme = themeName
    for i = #Lumina.ThemeObjects, 1, -1 do
        local item = Lumina.ThemeObjects[i]
        if item.Instance and item.Instance.Parent then
            if pal[item.Key] then
                TweenService:Create(item.Instance, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {
                    [item.Property] = pal[item.Key]
                }):Play()
            end
        else
            table.remove(Lumina.ThemeObjects, i)
        end
    end
end

local function MakeDraggable(handle, target, connections)
    local dragging, dragInput, dragStart, startPos
    local c1 = handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    local c2 = handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    local c3 = UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            TweenService:Create(target, TweenInfo.new(0.08, Enum.EasingStyle.Quad), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            }):Play()
        end
    end)
    if connections then
        table.insert(connections, c1)
        table.insert(connections, c2)
        table.insert(connections, c3)
    end
end

-- =========================================================================
-- 3. HỆ THỐNG LƯU / TẢI CONFIG (CONFIG MANAGER ENGINE)
-- =========================================================================
local function HasFileSystem()
    return type(writefile) == "function" and type(readfile) == "function"
end

local function EnsureConfigDirs()
    if not HasFileSystem() then return end
    pcall(function()
        if isfolder and not isfolder(Lumina.ConfigFolder) then
            makefolder(Lumina.ConfigFolder)
        end
        local sub = Lumina.ConfigFolder .. "/Configs"
        if isfolder and not isfolder(sub) then
            makefolder(sub)
        end
    end)
end

local function GetConfigPath(name)
    return Lumina.ConfigFolder .. "/Configs/" .. tostring(name) .. ".json"
end

local function GetAutoLoadPath()
    return Lumina.ConfigFolder .. "/autoload.txt"
end

function Lumina:GetConfigs()
    EnsureConfigDirs()
    local list = {}
    if HasFileSystem() and type(listfiles) == "function" then
        local ok, files = pcall(function() return listfiles(Lumina.ConfigFolder .. "/Configs") end)
        if ok and type(files) == "table" then
            for _, filepath in ipairs(files) do
                local name = tostring(filepath):match("([^/\\]+)%.json$")
                if name then table.insert(list, name) end
            end
        end
    else
        for name, _ in pairs(Lumina.MemoryConfigs) do
            table.insert(list, name)
        end
    end
    if #list == 0 then table.insert(list, "default") end
    table.sort(list)
    return list
end

function Lumina:SaveConfig(name)
    name = (name and name ~= "") and name or "default"
    EnsureConfigDirs()

    local serializedCustomColors = {}
    for k, col in pairs(Lumina.CustomColors) do
        if typeof(col) == "Color3" then
            serializedCustomColors[k] = {
                R = math.floor(col.R * 255 + 0.5),
                G = math.floor(col.G * 255 + 0.5),
                B = math.floor(col.B * 255 + 0.5)
            }
        end
    end

    local payload = {
        Theme = Lumina.CurrentTheme,
        CustomColors = serializedCustomColors,
        Flags = Lumina.Flags
    }

    local ok, encoded = pcall(function() return HttpService:JSONEncode(payload) end)
    if not ok then
        Lumina:Notify({Title = "Config Error", Text = "Không thể mã hóa JSON!", Duration = 3})
        return false
    end

    if HasFileSystem() then
        pcall(function() writefile(GetConfigPath(name), encoded) end)
    else
        Lumina.MemoryConfigs[name] = encoded
    end

    Lumina:Notify({Title = "Config Saved", Text = "Đã lưu cấu hình '" .. name .. ".json'!", Duration = 3})
    return true
end

function Lumina:LoadConfig(name)
    name = (name and name ~= "") and name or "default"
    EnsureConfigDirs()

    local rawJson = nil
    if HasFileSystem() then
        local path = GetConfigPath(name)
        local exists = (type(isfile) == "function") and isfile(path) or true
        if exists then
            local ok, content = pcall(function() return readfile(path) end)
            if ok then rawJson = content end
        end
    else
        rawJson = Lumina.MemoryConfigs[name]
    end

    if not rawJson or rawJson == "" then
        Lumina:Notify({Title = "Config Warning", Text = "Không tìm thấy file '" .. name .. ".json'!", Duration = 3})
        return false
    end

    local ok, decoded = pcall(function() return HttpService:JSONDecode(rawJson) end)
    if not ok or type(decoded) ~= "table" then
        Lumina:Notify({Title = "Config Error", Text = "File cấu hình bị hỏng!", Duration = 3})
        return false
    end

    -- 1. Khôi phục Theme & Custom RGB
    if type(decoded.CustomColors) == "table" and Lumina.ActiveWindow then
        for k, rgb in pairs(decoded.CustomColors) do
            if type(rgb) == "table" and rgb.R and rgb.G and rgb.B then
                Lumina.ActiveWindow:SetCustomColor(k, Color3.fromRGB(rgb.R, rgb.G, rgb.B))
            end
        end
    end
    if decoded.Theme and Lumina.ActiveWindow then
        Lumina.ActiveWindow:SetTheme(decoded.Theme)
    end

    -- 2. Khôi phục toàn bộ trạng thái UI Elements (Toggle, Slider, Dropdown, TextBox)
    if type(decoded.Flags) == "table" then
        for flag, val in pairs(decoded.Flags) do
            Lumina.Flags[flag] = val
            local controller = Lumina.Elements[flag]
            if controller and type(controller.Set) == "function" then
                pcall(function() controller:Set(val) end)
            end
        end
    end

    Lumina:Notify({Title = "Config Loaded", Text = "Đã tải cấu hình '" .. name .. "' thành công!", Duration = 3})
    return true
end

function Lumina:DeleteConfig(name)
    if not name or name == "" then return false end
    if HasFileSystem() and type(delfile) == "function" then
        pcall(function()
            local path = GetConfigPath(name)
            if not isfile or isfile(path) then delfile(path) end
        end)
    else
        Lumina.MemoryConfigs[name] = nil
    end
    Lumina:Notify({Title = "Config Deleted", Text = "Đã xóa cấu hình '" .. name .. "'!", Duration = 3})
    return true
end

function Lumina:SetAutoLoadConfig(name)
    EnsureConfigDirs()
    if HasFileSystem() then
        pcall(function() writefile(GetAutoLoadPath(), name or "") end)
    end
end

function Lumina:GetAutoLoadConfig()
    if HasFileSystem() then
        local ok, txt = pcall(function()
            local p = GetAutoLoadPath()
            if not isfile or isfile(p) then return readfile(p) end
            return nil
        end)
        if ok and txt and txt ~= "" then return txt end
    end
    return nil
end

-- =========================================================================
-- 4. NOTIFICATION & DYNAMIC ISLAND MORPHING
-- =========================================================================
local ActiveIsland = nil
local NotifyGui = Create("ScreenGui", {
    Name = "LuminaNotifyGui",
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    ResetOnSpawn = false
})
NotifyGui.Parent = GetSafeGuiParent()

local NotifyContainer = Create("Frame", {
    Parent = NotifyGui,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -20, 1, -20),
    Size = UDim2.new(0, 310, 1, -40),
    AnchorPoint = Vector2.new(1, 1)
}, {
    Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8)
    })
})

function Lumina:Notify(options)
    options = options or {}
    local title = options.Title or "Lumina"
    local text = options.Text or options.Description or ""
    local duration = options.Duration or 3
    local pal = Lumina.Themes[Lumina.CurrentTheme] or Lumina.Themes.Dark

    if ActiveIsland and ActiveIsland.IsCollapsed() then
        ActiveIsland.Morph(title, text, pal.Accent, duration)
        return
    end

    local Holder = Create("Frame", {
        Parent = NotifyContainer,
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundTransparency = 1
    })

    local Card = Create("Frame", {
        Parent = Holder,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(1, 340, 0, 0),
        BackgroundColor3 = pal.Main,
        ClipsDescendants = true
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 8)}),
        Create("UIStroke", {Color = pal.Accent, Thickness = 1.2, Transparency = 0.25}),
        Create("TextLabel", {
            Text = title,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            TextColor3 = pal.Text,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -24, 0, 20),
            Position = UDim2.new(0, 12, 0, 8),
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        Create("TextLabel", {
            Text = text,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            TextColor3 = pal.SubText,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -24, 0, 26),
            Position = UDim2.new(0, 12, 0, 28),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true
        }),
        Create("Frame", {
            Name = "Bar",
            BackgroundColor3 = pal.Accent,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 1, -3),
            Size = UDim2.new(1, 0, 0, 3)
        })
    })

    TweenService:Create(Card, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    TweenService:Create(Card.Bar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3)
    }):Play()

    task.delay(duration, function()
        if not Card or not Card.Parent then return end
        TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 340, 0, 0)
        }):Play()
        task.wait(0.32)
        if Holder then Holder:Destroy() end
    end)
end

-- =========================================================================
-- 5. KHỞI TẠO CỬA SỔ CHÍNH (CREATE WINDOW)
-- =========================================================================
function Lumina:CreateWindow(options)
    options = options or {}
    local titleText = options.Title or "Lumina Hub"
    local versionText = options.Version or Lumina.Version
    local winSize = options.Size or UDim2.new(0, 750, 0, 480)
    if options.ConfigFolder then Lumina.ConfigFolder = options.ConfigFolder end

    local Connections = {}
    local isVisible = true

    local ScreenGui = Create("ScreenGui", {
        Name = "LuminaLibrary_" .. titleText,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true,
        ResetOnSpawn = false
    })
    ScreenGui.Parent = GetSafeGuiParent()

    -- Dynamic Island ở đỉnh màn hình khi thu nhỏ
    local Island = Create("TextButton", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 145, 0, 34),
        Position = UDim2.new(0.5, 0, 0, 12),
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(14, 14, 18),
        Text = "",
        Visible = false,
        AutoButtonColor = false,
        ClipsDescendants = true,
        ZIndex = 1000
    }, {
        Create("UICorner", {CornerRadius = UDim.new(1, 0)}),
        Create("UIStroke", {Color = Color3.fromRGB(60, 60, 75), Thickness = 1.2}),
        Create("TextLabel", {
            Name = "MiniLabel",
            Text = "⚡ " .. titleText,
            Font = Enum.Font.GothamBold,
            TextSize = 12,
            TextColor3 = Color3.fromRGB(245, 245, 250),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0)
        }),
        Create("Frame", {
            Name = "Expanded",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false
        }, {
            Create("TextLabel", {
                Name = "ETitle",
                Text = "",
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -24, 0, 18),
                Position = UDim2.new(0, 12, 0, 8),
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            Create("TextLabel", {
                Name = "EText",
                Text = "",
                Font = Enum.Font.Gotham,
                TextSize = 11,
                TextColor3 = Color3.fromRGB(185, 185, 198),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -24, 0, 24),
                Position = UDim2.new(0, 12, 0, 26),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true
            })
        })
    })

    ActiveIsland = {
        IsCollapsed = function() return not isVisible end,
        Morph = function(t, d, _, dur)
            Island.MiniLabel.Visible = false
            Island.Expanded.Visible = true
            Island.Expanded.ETitle.Text = "🔔 " .. tostring(t)
            Island.Expanded.EText.Text = tostring(d)
            TweenService:Create(Island, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 310, 0, 58)
            }):Play()
            task.delay(dur or 3, function()
                if not Island or not Island.Parent then return end
                TweenService:Create(Island, TweenInfo.new(0.28, Enum.EasingStyle.Quint), {
                    Size = UDim2.new(0, 145, 0, 34)
                }):Play()
                Island.Expanded.Visible = false
                Island.MiniLabel.Visible = true
            end)
        end
    }

    -- Khung cửa sổ chính
    local Main = Create("Frame", {
        Name = "MainWindow",
        Parent = ScreenGui,
        Size = winSize,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ClipsDescendants = true
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 10)})
    })
    BindTheme(Main, "BackgroundColor3", "Main")

    local MainStroke = Create("UIStroke", {Parent = Main, Thickness = 1.2})
    BindTheme(MainStroke, "Color", "Outline")

    local MainScale = Create("UIScale", {Parent = Main, Scale = 1})
    local vp = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)
    if vp.Y < 540 then MainScale.Scale = 0.78 end

    -- Header / Topbar
    local Header = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 44),
        BorderSizePixel = 0
    }, {
        Create("UICorner", {CornerRadius = UDim.new(0, 10)})
    })
    BindTheme(Header, "BackgroundColor3", "Header")

    local HeaderTitle = Create("TextLabel", {
        Parent = Header,
        Text = titleText,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Size = UDim2.new(0, 220, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        BackgroundTransparency = 1
    })
    BindTheme(HeaderTitle, "TextColor3", "Text")

    local VersionBadge = Create("TextLabel", {
        Parent = Header,
        Text = versionText,
        Font = Enum.Font.GothamSemibold,
        TextSize = 11,
        Size = UDim2.new(0, 95, 0, 22),
        Position = UDim2.new(0, 150, 0.5, -11),
        BackgroundTransparency = 0.15
    }, {
        Create("UICorner", {CornerRadius = UDim.new(1, 0)})
    })
    BindTheme(VersionBadge, "BackgroundColor3", "Element")
    BindTheme(VersionBadge, "TextColor3", "Accent")

    local MinBtn = Create("TextButton", {
        Parent = Header,
        Text = "—",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -72, 0.5, -15),
        AutoButtonColor = false
    }, {Create("UICorner", {CornerRadius = UDim.new(0, 6)})})
    BindTheme(MinBtn, "BackgroundColor3", "Element")
    BindTheme(MinBtn, "TextColor3", "Text")

    local CloseBtn = Create("TextButton", {
        Parent = Header,
        Text = "✕",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = Color3.fromRGB(255, 95, 95),
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -36, 0.5, -15),
        AutoButtonColor = false
    }, {Create("UICorner", {CornerRadius = UDim.new(0, 6)})})
    BindTheme(CloseBtn, "BackgroundColor3", "Element")

    -- Sidebar
    local Sidebar = Create("ScrollingFrame", {
        Parent = Main,
        Size = UDim2.new(0, 190, 1, -44),
        Position = UDim2.new(0, 0, 0, 44),
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    }, {
        Create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5)}),
        Create("UIPadding", {PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)})
    })
    BindTheme(Sidebar, "BackgroundColor3", "Sidebar")

    Sidebar.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Sidebar.CanvasSize = UDim2.new(0, 0, 0, Sidebar.UIListLayout.AbsoluteContentSize.Y + 20)
    end)

    -- Content Area
    local ContentArea = Create("Frame", {
        Parent = Main,
        Size = UDim2.new(1, -190, 1, -44),
        Position = UDim2.new(0, 190, 0, 44),
        BackgroundTransparency = 1
    })

    MakeDraggable(Header, Main, Connections)

    local function SetWindowVisible(state)
        isVisible = state
        Main.Visible = isVisible
        Island.Visible = not isVisible
    end

    MinBtn.MouseButton1Click:Connect(function() SetWindowVisible(false) end)
    Island.MouseButton1Click:Connect(function() SetWindowVisible(true) end)

    local keyConn = UserInputService.InputBegan:Connect(function(inp, gp)
        if not gp and inp.KeyCode == Enum.KeyCode.RightShift then
            SetWindowVisible(not isVisible)
        end
    end)
    table.insert(Connections, keyConn)

    local WindowObj = {
        Tabs = {},
        Connections = Connections
    }
    Lumina.ActiveWindow = WindowObj

    function WindowObj:Destroy()
        for _, c in ipairs(Connections) do
            if c.Connected then c:Disconnect() end
        end
        ActiveIsland = nil
        if ScreenGui then ScreenGui:Destroy() end
    end
    Lumina.DestroyUI = function() WindowObj:Destroy() end

    CloseBtn.MouseButton1Click:Connect(function() WindowObj:Destroy() end)

    function WindowObj:SetTheme(themeName)
        ApplyThemePalette(themeName)
    end

    function WindowObj:SetCustomColor(key, color3)
        Lumina.CustomColors[key] = color3
        Lumina.Themes["Custom"][key] = color3
        -- Cập nhật trực tiếp lên theme hiện hành để người dùng thấy màu đổi ngay khi kéo Slider
        local cur = Lumina.Themes[Lumina.CurrentTheme]
        if cur then cur[key] = color3 end
        ApplyThemePalette(Lumina.CurrentTheme)
    end

    function WindowObj:SelectTab(index)
        local target = WindowObj.Tabs[index]
        if target and target.Activate then
            target.Activate()
        end
    end

    -- =====================================================================
    -- HÀM DỰNG TAB & COMPONENTS
    -- =====================================================================
    local function CreateTabInternal(parentContainer, tabOptions, isSubTab)
        tabOptions = tabOptions or {}
        local tabTitle = tabOptions.Title or tabOptions.Name or "Tab"
        local iconKey = string.lower(tostring(tabOptions.Icon or ""))
        local iconChar = Lumina.Icons[iconKey] or (isSubTab and "↳" or "•")

        local TabBtn = Create("TextButton", {
            Parent = parentContainer,
            Size = UDim2.new(1, 0, 0, isSubTab and 30 or 34),
            BackgroundTransparency = 1,
            Text = iconChar .. "   " .. tabTitle,
            Font = Enum.Font.GothamSemibold,
            TextSize = isSubTab and 12 or 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false
        }, {
            Create("UIPadding", {PaddingLeft = UDim.new(0, isSubTab and 22 or 12)}),
            Create("UICorner", {CornerRadius = UDim.new(0, 6)})
        })
        BindTheme(TabBtn, "BackgroundColor3", "Element")
        BindTheme(TabBtn, "TextColor3", "SubText")

        local Page = Create("ScrollingFrame", {
            Parent = ContentArea,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            ScrollBarThickness = 3,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        }, {
            Create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}),
            Create("UIPadding", {PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 16), PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16)})
        })
        BindTheme(Page, "ScrollBarImageColor3", "Accent")

        Page.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, Page.UIListLayout.AbsoluteContentSize.Y + 24)
        end)

        local function Activate()
            local pal = Lumina.Themes[Lumina.CurrentTheme] or Lumina.Themes.Dark
            for _, t in ipairs(WindowObj.Tabs) do
                t.Page.Visible = false
                TweenService:Create(t.Button, TweenInfo.new(0.2), {
                    BackgroundTransparency = 1,
                    TextColor3 = pal.SubText
                }):Play()
            end
            Page.Visible = true
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {
                BackgroundTransparency = 0.15,
                TextColor3 = pal.Accent
            }):Play()
        end

        TabBtn.MouseButton1Click:Connect(Activate)

        local TabAPI = {Button = TabBtn, Page = Page, Activate = Activate}
        table.insert(WindowObj.Tabs, TabAPI)
        if #WindowObj.Tabs == 1 then Activate() end

        -- 1. ADD SECTION
        function TabAPI:AddSection(secOpts)
            secOpts = secOpts or {}
            local sTitle = secOpts.Title or "Section"
            local Sec = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1
            })
            local Lbl = Create("TextLabel", {
                Parent = Sec,
                Text = string.upper(sTitle),
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Size = UDim2.new(1, 0, 1, 0),
                Position = UDim2.new(0, 2, 0, 4),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(Lbl, "TextColor3", "Accent")
            return Sec
        end

        -- 2. ADD LABEL
        function TabAPI:AddLabel(lblOpts)
            lblOpts = lblOpts or {}
            local Frame = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 32)
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 6)})})
            BindTheme(Frame, "BackgroundColor3", "Element")

            local Lbl = Create("TextLabel", {
                Parent = Frame,
                Text = lblOpts.Text or "Label",
                Font = Enum.Font.Gotham,
                TextSize = 13,
                RichText = true,
                Size = UDim2.new(1, -24, 1, 0),
                Position = UDim2.new(0, 12, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(Lbl, "TextColor3", "Text")

            local Controller = {}
            function Controller:Set(newText) Lbl.Text = tostring(newText) end
            return Controller
        end

        -- 3. ADD BUTTON
        function TabAPI:AddButton(btnOpts)
            btnOpts = btnOpts or {}
            local bTitle = btnOpts.Title or btnOpts.Name or "Button"
            local callback = btnOpts.Callback or function() end

            local Btn = Create("TextButton", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 38),
                Text = bTitle,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                AutoButtonColor = false
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 7)})})
            BindTheme(Btn, "BackgroundColor3", "Element")
            BindTheme(Btn, "TextColor3", "Text")

            local Stroke = Create("UIStroke", {Parent = Btn, Thickness = 1})
            BindTheme(Stroke, "Color", "Outline")

            Btn.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
            return Btn
        end

        -- 4. ADD TOGGLE (Tự động lưu vào Flags & Elements)
        function TabAPI:AddToggle(tglOpts)
            tglOpts = tglOpts or {}
            local tTitle = tglOpts.Title or tglOpts.Name or "Toggle"
            local flag = tglOpts.Flag or tTitle
            local state = tglOpts.Default or false
            local callback = tglOpts.Callback or function() end

            Lumina.Flags[flag] = state

            local Row = Create("TextButton", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 40),
                Text = "",
                AutoButtonColor = false
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 7)})})
            BindTheme(Row, "BackgroundColor3", "Element")

            local Stroke = Create("UIStroke", {Parent = Row, Thickness = 1})
            BindTheme(Stroke, "Color", "Outline")

            local Lbl = Create("TextLabel", {
                Parent = Row,
                Text = tTitle,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                Size = UDim2.new(1, -70, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(Lbl, "TextColor3", "Text")

            local Switch = Create("Frame", {
                Parent = Row,
                Size = UDim2.new(0, 42, 0, 20),
                Position = UDim2.new(1, -54, 0.5, -10),
                BackgroundColor3 = state and Color3.fromRGB(75, 215, 135) or Color3.fromRGB(80, 80, 92)
            }, {Create("UICorner", {CornerRadius = UDim.new(1, 0)})})

            local Dot = Create("Frame", {
                Parent = Switch,
                Size = UDim2.new(0, 14, 0, 14),
                Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }, {Create("UICorner", {CornerRadius = UDim.new(1, 0)})})

            local Controller = {}
            function Controller:Set(val)
                state = not not val
                Lumina.Flags[flag] = state
                local pal = Lumina.Themes[Lumina.CurrentTheme] or Lumina.Themes.Dark
                TweenService:Create(Switch, TweenInfo.new(0.2), {
                    BackgroundColor3 = state and pal.Accent or Color3.fromRGB(80, 80, 92)
                }):Play()
                TweenService:Create(Dot, TweenInfo.new(0.2), {
                    Position = state and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
                }):Play()
                pcall(callback, state)
            end

            Row.MouseButton1Click:Connect(function()
                Controller:Set(not state)
            end)

            Lumina.Elements[flag] = Controller
            return Controller
        end

        -- 5. ADD SLIDER (Tự động lưu vào Flags & Elements)
        function TabAPI:AddSlider(sldOpts)
            sldOpts = sldOpts or {}
            local sTitle = sldOpts.Title or sldOpts.Name or "Slider"
            local flag = sldOpts.Flag or sTitle
            local min = sldOpts.Min or 0
            local max = sldOpts.Max or 100
            local default = math.clamp(sldOpts.Default or min, min, max)
            local callback = sldOpts.Callback or function() end

            Lumina.Flags[flag] = default

            local Box = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 54)
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 7)})})
            BindTheme(Box, "BackgroundColor3", "Element")

            local Stroke = Create("UIStroke", {Parent = Box, Thickness = 1})
            BindTheme(Stroke, "Color", "Outline")

            local Lbl = Create("TextLabel", {
                Parent = Box,
                Text = sTitle,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                Size = UDim2.new(1, -80, 0, 24),
                Position = UDim2.new(0, 14, 0, 4),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(Lbl, "TextColor3", "Text")

            local ValLbl = Create("TextLabel", {
                Parent = Box,
                Text = tostring(default),
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                Size = UDim2.new(0, 60, 0, 24),
                Position = UDim2.new(1, -74, 0, 4),
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1
            })
            BindTheme(ValLbl, "TextColor3", "Accent")

            local Bar = Create("TextButton", {
                Parent = Box,
                Size = UDim2.new(1, -28, 0, 8),
                Position = UDim2.new(0, 14, 0, 36),
                Text = "",
                AutoButtonColor = false
            }, {Create("UICorner", {CornerRadius = UDim.new(1, 0)})})
            BindTheme(Bar, "BackgroundColor3", "Main")

            local Fill = Create("Frame", {
                Parent = Bar,
                Size = UDim2.new((default - min) / math.max(max - min, 1), 0, 1, 0)
            }, {Create("UICorner", {CornerRadius = UDim.new(1, 0)})})
            BindTheme(Fill, "BackgroundColor3", "Accent")

            local Controller = {}
            function Controller:Set(val)
                local v = math.clamp(math.floor(tonumber(val) or min), min, max)
                local pct = (v - min) / math.max(max - min, 1)
                Lumina.Flags[flag] = v
                ValLbl.Text = tostring(v)
                TweenService:Create(Fill, TweenInfo.new(0.08), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
                pcall(callback, v)
            end

            local dragging = false
            local function UpdateFromInput(input)
                local pct = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                Controller:Set(min + (max - min) * pct)
            end

            Bar.InputBegan:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    UpdateFromInput(inp)
                end
            end)
            table.insert(Connections, UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end))
            table.insert(Connections, UserInputService.InputChanged:Connect(function(inp)
                if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
                    UpdateFromInput(inp)
                end
            end))

            Lumina.Elements[flag] = Controller
            return Controller
        end

        -- 6. ADD DROPDOWN (Có SearchBox + Refresh + Lưu vào Flags & Elements)
        function TabAPI:AddDropdown(dropOpts)
            dropOpts = dropOpts or {}
            local dTitle = dropOpts.Title or dropOpts.Name or "Dropdown"
            local flag = dropOpts.Flag or dTitle
            local options = dropOpts.Options or {}
            local selected = dropOpts.Default or options[1] or "None"
            local callback = dropOpts.Callback or function() end
            local isOpen = false

            Lumina.Flags[flag] = selected

            local DropFrame = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 40),
                ClipsDescendants = true
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 7)})})
            BindTheme(DropFrame, "BackgroundColor3", "Element")

            local Stroke = Create("UIStroke", {Parent = DropFrame, Thickness = 1})
            BindTheme(Stroke, "Color", "Outline")

            local HeaderBtn = Create("TextButton", {
                Parent = DropFrame,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundTransparency = 1,
                Text = ""
            })

            local TitleLbl = Create("TextLabel", {
                Parent = HeaderBtn,
                Text = dTitle .. ":  " .. tostring(selected),
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                Size = UDim2.new(1, -45, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(TitleLbl, "TextColor3", "Text")

            local Arrow = Create("TextLabel", {
                Parent = HeaderBtn,
                Text = "▼",
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Size = UDim2.new(0, 24, 0, 40),
                Position = UDim2.new(1, -30, 0, 0),
                BackgroundTransparency = 1
            })
            BindTheme(Arrow, "TextColor3", "SubText")

            local Search = Create("TextBox", {
                Parent = DropFrame,
                PlaceholderText = "🔍 Tìm nhanh...",
                Text = "",
                Font = Enum.Font.Gotham,
                TextSize = 12,
                Size = UDim2.new(1, -20, 0, 26),
                Position = UDim2.new(0, 10, 0, 44),
                ClearTextOnFocus = false
            }, {
                Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
                Create("UIPadding", {PaddingLeft = UDim.new(0, 8)})
            })
            BindTheme(Search, "BackgroundColor3", "Main")
            BindTheme(Search, "TextColor3", "Text")
            BindTheme(Search, "PlaceholderColor3", "SubText")

            local ListScroll = Create("ScrollingFrame", {
                Parent = DropFrame,
                Size = UDim2.new(1, -20, 0, 110),
                Position = UDim2.new(0, 10, 0, 74),
                BackgroundTransparency = 1,
                ScrollBarThickness = 2,
                CanvasSize = UDim2.new(0, 0, 0, 0)
            }, {
                Create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
            })
            BindTheme(ListScroll, "ScrollBarImageColor3", "Accent")

            local OptButtons = {}
            local Controller = {}

            local function UpdateSize()
                if not isOpen then
                    TweenService:Create(DropFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    Arrow.Rotation = 0
                else
                    local vis = 0
                    for _, b in ipairs(OptButtons) do if b.Visible then vis = vis + 1 end end
                    local h = math.clamp(vis * 28, 28, 120)
                    ListScroll.Size = UDim2.new(1, -20, 0, h)
                    TweenService:Create(DropFrame, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 0, 82 + h)}):Play()
                    Arrow.Rotation = 180
                end
            end

            local function Rebuild()
                for _, b in ipairs(OptButtons) do b:Destroy() end
                table.clear(OptButtons)

                for _, opt in ipairs(options) do
                    local isSel = (opt == selected)
                    local B = Create("TextButton", {
                        Name = tostring(opt),
                        Parent = ListScroll,
                        Size = UDim2.new(1, 0, 0, 24),
                        Text = (isSel and "✓ " or "   ") .. tostring(opt),
                        Font = isSel and Enum.Font.GothamBold or Enum.Font.Gotham,
                        TextSize = 12,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false
                    }, {
                        Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
                        Create("UIPadding", {PaddingLeft = UDim.new(0, 8)})
                    })
                    BindTheme(B, "BackgroundColor3", "Main")
                    BindTheme(B, "TextColor3", isSel and "Accent" or "Text")

                    B.MouseButton1Click:Connect(function()
                        Controller:Set(opt)
                        isOpen = false
                        UpdateSize()
                    end)
                    table.insert(OptButtons, B)
                end
                ListScroll.CanvasSize = UDim2.new(0, 0, 0, #OptButtons * 28)
            end

            function Controller:Set(val)
                selected = val
                Lumina.Flags[flag] = selected
                TitleLbl.Text = dTitle .. ":  " .. tostring(selected)
                Rebuild()
                pcall(callback, selected)
            end

            function Controller:Refresh(newOptions, newDefault)
                options = newOptions or {}
                if newDefault then selected = newDefault end
                Lumina.Flags[flag] = selected
                TitleLbl.Text = dTitle .. ":  " .. tostring(selected)
                Rebuild()
                UpdateSize()
            end

            Search:GetPropertyChangedSignal("Text"):Connect(function()
                local q = string.lower(Search.Text)
                for _, b in ipairs(OptButtons) do
                    b.Visible = string.find(string.lower(b.Name), q, 1, true) ~= nil
                end
                UpdateSize()
            end)

            HeaderBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                UpdateSize()
            end)

            Rebuild()
            Lumina.Elements[flag] = Controller
            return Controller
        end

        -- 7. ADD TEXTBOX (Lưu vào Flags & Elements)
        function TabAPI:AddTextBox(tbOpts)
            tbOpts = tbOpts or {}
            local tTitle = tbOpts.Title or "Input"
            local flag = tbOpts.Flag or tTitle
            local placeholder = tbOpts.Placeholder or "Type here..."
            local default = tbOpts.Default or ""
            local callback = tbOpts.Callback or function() end

            Lumina.Flags[flag] = default

            local Row = Create("Frame", {
                Parent = Page,
                Size = UDim2.new(1, 0, 0, 42)
            }, {Create("UICorner", {CornerRadius = UDim.new(0, 7)})})
            BindTheme(Row, "BackgroundColor3", "Element")

            local Stroke = Create("UIStroke", {Parent = Row, Thickness = 1})
            BindTheme(Stroke, "Color", "Outline")

            local Lbl = Create("TextLabel", {
                Parent = Row,
                Text = tTitle,
                Font = Enum.Font.GothamSemibold,
                TextSize = 13,
                Size = UDim2.new(0.42, 0, 1, 0),
                Position = UDim2.new(0, 14, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1
            })
            BindTheme(Lbl, "TextColor3", "Text")

            local Input = Create("TextBox", {
                Parent = Row,
                Text = default,
                PlaceholderText = placeholder,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                Size = UDim2.new(0.52, -14, 0, 28),
                Position = UDim2.new(0.48, 0, 0.5, -14),
                ClearTextOnFocus = false
            }, {
                Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
                Create("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8)})
            })
            BindTheme(Input, "BackgroundColor3", "Main")
            BindTheme(Input, "TextColor3", "Text")
            BindTheme(Input, "PlaceholderColor3", "SubText")

            local Controller = {}
            function Controller:Set(val)
                Input.Text = tostring(val or "")
                Lumina.Flags[flag] = Input.Text
                pcall(callback, Input.Text)
            end

            Input.FocusLost:Connect(function()
                Lumina.Flags[flag] = Input.Text
                pcall(callback, Input.Text)
            end)

            Lumina.Elements[flag] = Controller
            return Controller
        end

        -- 8. TÍCH HỢP SẴN BẢNG QUẢN LÝ CONFIG (ADD CONFIG SECTION)
        function TabAPI:AddConfigSection()
            TabAPI:AddSection({Title = "Config Manager (JSON Save/Load)"})

            local currentConfigName = "default"
            local selectedConfigFile = Lumina:GetConfigs()[1] or "default"

            TabAPI:AddTextBox({
                Title = "Config Name",
                Flag = "_InternalConfigName",
                Placeholder = "Nhập tên config (vd: legit, raid)...",
                Default = "default",
                Callback = function(txt)
                    if txt and txt ~= "" then currentConfigName = txt end
                end
            })

            local ConfigDropdown = TabAPI:AddDropdown({
                Title = "Saved Configs",
                Flag = "_InternalSelectedConfig",
                Options = Lumina:GetConfigs(),
                Default = selectedConfigFile,
                Callback = function(sel)
                    selectedConfigFile = sel
                end
            })

            TabAPI:AddButton({
                Title = "💾 Create / Save Config",
                Callback = function()
                    local target = (currentConfigName ~= "" and currentConfigName) or selectedConfigFile
                    if Lumina:SaveConfig(target) then
                        ConfigDropdown:Refresh(Lumina:GetConfigs(), target)
                        selectedConfigFile = target
                    end
                end
            })

            TabAPI:AddButton({
                Title = "📂 Load Selected Config",
                Callback = function()
                    Lumina:LoadConfig(selectedConfigFile)
                end
            })

            TabAPI:AddButton({
                Title = "🗑️ Delete Selected Config",
                Callback = function()
                    if Lumina:DeleteConfig(selectedConfigFile) then
                        local list = Lumina:GetConfigs()
                        selectedConfigFile = list[1] or "default"
                        ConfigDropdown:Refresh(list, selectedConfigFile)
                    end
                end
            })

            TabAPI:AddButton({
                Title = "🔄 Refresh Config List",
                Callback = function()
                    local list = Lumina:GetConfigs()
                    ConfigDropdown:Refresh(list, list[1] or "default")
                    Lumina:Notify({Title = "Config Manager", Text = "Đã làm mới danh sách Config!", Duration = 2})
                end
            })

            TabAPI:AddToggle({
                Title = "Auto-Load Selected Config On Execute",
                Flag = "_InternalAutoLoadToggle",
                Default = (Lumina:GetAutoLoadConfig() ~= nil),
                Callback = function(state)
                    if state then
                        Lumina:SetAutoLoadConfig(selectedConfigFile)
                        Lumina:Notify({Title = "Auto-Load", Text = "Sẽ tự động tải '" .. selectedConfigFile .. "' khi chạy script!", Duration = 3})
                    else
                        Lumina:SetAutoLoadConfig("")
                    end
                end
            })
        end

        return TabAPI
    end

    function WindowObj:MakeTab(tabOptions)
        return CreateTabInternal(Sidebar, tabOptions, false)
    end

    function WindowObj:MakeDropdownTab(groupOptions)
        groupOptions = groupOptions or {}
        local gTitle = groupOptions.Title or "Group"
        local isOpen = true

        local GroupWrapper = Create("Frame", {
            Parent = Sidebar,
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        })

        local GroupHeader = Create("TextButton", {
            Parent = GroupWrapper,
            Size = UDim2.new(1, 0, 0, 34),
            BackgroundTransparency = 0.4,
            Text = "📁   " .. gTitle,
            Font = Enum.Font.GothamBold,
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false
        }, {
            Create("UIPadding", {PaddingLeft = UDim.new(0, 12)}),
            Create("UICorner", {CornerRadius = UDim.new(0, 6)})
        })
        BindTheme(GroupHeader, "BackgroundColor3", "Element")
        BindTheme(GroupHeader, "TextColor3", "Text")

        local SubHolder = Create("Frame", {
            Parent = GroupWrapper,
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(0, 0, 0, 38),
            BackgroundTransparency = 1
        }, {
            Create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
        })

        local function RecalcHeight()
            local subH = SubHolder.UIListLayout.AbsoluteContentSize.Y
            TweenService:Create(GroupWrapper, TweenInfo.new(0.22, Enum.EasingStyle.Quart), {
                Size = UDim2.new(1, 0, 0, isOpen and (38 + subH) or 34)
            }):Play()
        end

        SubHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(RecalcHeight)
        GroupHeader.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            RecalcHeight()
        end)

        local GroupObj = {}
        function GroupObj:MakeTab(subTabOptions)
            local t = CreateTabInternal(SubHolder, subTabOptions, true)
            task.defer(RecalcHeight)
            return t
        end
        return GroupObj
    end

    -- Tự động kiểm tra Auto-Load Config sau khi tất cả Tabs/Elements được khởi tạo
    task.defer(function()
        task.wait(0.2)
        local autoCfg = Lumina:GetAutoLoadConfig()
        if autoCfg and autoCfg ~= "" then
            Lumina:LoadConfig(autoCfg)
        end
    end)

    return WindowObj
end

return Lumina
