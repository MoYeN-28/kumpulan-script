-- ==========================================
-- [BAGIAN 1] Memuat Kavo UI & Membuat Menu
-- ==========================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Dashboard Auto Farm", "Ocean")

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local TabUtama = Window:NewTab("Menu Utama")
local SectionFitur = TabUtama:NewSection("Fitur Auto")

SectionFitur:NewToggle("Auto Farm (Persiapan)", "Tombol untuk farming", function(state)
    print("Status Auto Farm: ", state)
end)

-- ==========================================
-- [BAGIAN 2] Setup Icon Melayang (Awalnya Disembunyikan)
-- ==========================================
if CoreGui:FindFirstChild("IconMobile") then
    CoreGui.IconMobile:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IconMobile"
ScreenGui.Parent = CoreGui
ScreenGui.Enabled = false -- Icon disembunyikan saat dashboard pertama kali terbuka

local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.Image = "rbxassetid://6031280882" -- Gambar Gear
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.BackgroundTransparency = 0.2

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ToggleBtn

-- ==========================================
-- [BAGIAN 3] Tombol MINIMIZE di dalam Dashboard
-- ==========================================
local SectionTampilan = TabUtama:NewSection("Kontrol Layar")

SectionTampilan:NewButton("Minimize Dashboard", "Tutup menu dan jadikan icon", function()
    -- Sembunyikan Dashboard Kavo
    local kavoUI = CoreGui:FindFirstChild("Kavo") or Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Kavo")
    if kavoUI then
        kavoUI.Enabled = false
    end
    
    -- Munculkan Icon Melayang
    ScreenGui.Enabled = true
end)

-- ==========================================
-- [BAGIAN 4] Logika Buka UI dari Icon (Klik & Geser)
-- ==========================================
local dragging = false
local isMoved = false
local dragStart, startPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        isMoved = false
        dragStart = input.Position
        startPos = ToggleBtn.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                
                -- Jika icon DITEKAN (bukan digeser)
                if not isMoved then
                    -- Munculkan Dashboard Kavo
                    local kavoUI = CoreGui:FindFirstChild("Kavo") or Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Kavo")
                    if kavoUI then
                        kavoUI.Enabled = true
                    end
                    
                    -- Sembunyikan Icon Melayang
                    ScreenGui.Enabled = false
                end
            end
        end)
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            local delta = input.Position - dragStart
            -- Jika jari bergeser lebih dari 5 pixel, itu berarti MENGGESER icon
            if delta.Magnitude > 5 then
                isMoved = true
                ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end
end)
