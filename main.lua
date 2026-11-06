-- ==========================================
-- [BAGIAN 1] Memuat Kavo UI Library
-- ==========================================
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Dashboard Auto Farm", "Ocean")

local TabUtama = Window:NewTab("Menu Utama")
local SectionFitur = TabUtama:NewSection("Fitur Auto")

SectionFitur:NewToggle("Auto Farm (Persiapan)", "Tombol untuk farming", function(state)
    print("Status Auto Farm: ", state)
end)

-- ==========================================
-- [BAGIAN 2] Setup Folder Aman Khusus Delta
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Menggunakan gethui() milik Delta jika ada, jika tidak pakai CoreGui
local safeGui = (gethui and gethui()) or CoreGui

if safeGui:FindFirstChild("TombolMobile") then
    safeGui.TombolMobile:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TombolMobile"
ScreenGui.Parent = safeGui

-- Membuat Icon Gear (Seperti gambar Anda)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.Image = "rbxassetid://6031280882" 
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.BackgroundTransparency = 0.2

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ToggleBtn

-- ==========================================
-- [BAGIAN 3] Logika Timer Sentuh & Geser Delta
-- ==========================================
local dragging = false
local dragInput, dragStart, startPos
local waktuSentuh = 0
local uiTerbuka = true

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        waktuSentuh = tick() -- Mencatat waktu persis saat layar disentuh
    end
end)

ToggleBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        ToggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        
        -- LOGIKA KETUK: Jika jari menempel di layar kurang dari 0.3 detik (Ketuk Cepat)
        if tick() - waktuSentuh < 0.3 then
            uiTerbuka = not uiTerbuka
            
            -- Mencari UI Kavo di semua folder yang mungkin digunakan Delta
            local kavoUI = safeGui:FindFirstChild("Kavo") or CoreGui:FindFirstChild("Kavo") or Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Kavo")
            
            if kavoUI then
                kavoUI.Enabled = uiTerbuka
            end
        end
    end
end)
