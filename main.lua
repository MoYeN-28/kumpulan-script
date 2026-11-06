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
-- [BAGIAN 2] Membuat Icon Melayang (Toggle UI)
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Menghapus icon lama jika script dijalankan ulang agar tidak menumpuk
if CoreGui:FindFirstChild("IconMobile") then
    CoreGui.IconMobile:Destroy()
end

-- Membuat wadah untuk Icon
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IconMobile"
ScreenGui.Parent = CoreGui

-- Mendesain Icon (Tombol Bergambar Gear)
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 45, 0, 45) -- Ukuran icon (45x45 pixel)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15) -- Posisi awal (Kiri atas)
ToggleBtn.Image = "rbxassetid://6031280882" -- ID Gambar Gear/Setting bawaan Roblox
ToggleBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ToggleBtn.BackgroundTransparency = 0.2

-- Membuat ujung icon membulat agar lebih elegan
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = ToggleBtn

-- ==========================================
-- [BAGIAN 3] Logika Geser Sentuh (Responsive Drag)
-- ==========================================
local dragging, dragInput, dragStart, startPos

ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = ToggleBtn.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
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

-- ==========================================
-- [BAGIAN 4] Logika Buka/Tutup Dashboard (Minimize)
-- ==========================================
local uiTerbuka = true
ToggleBtn.MouseButton1Click:Connect(function()
    uiTerbuka = not uiTerbuka
    
    -- Mencari UI Kavo dan menyembunyikannya
    for _, gui in pairs(CoreGui:GetChildren()) do
        if gui.Name == "Kavo" then
            gui.Enabled = uiTerbuka
        end
    end
end)
