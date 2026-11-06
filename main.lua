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
-- [BAGIAN 2] Tombol Statis Khusus Delta
-- ==========================================
local CoreGui = game:GetService("CoreGui")
-- Menggunakan gethui() milik Delta agar aman
local safeGui = (gethui and gethui()) or CoreGui

-- Hapus tombol lama jika ada
if safeGui:FindFirstChild("TombolMobile") then
    safeGui.TombolMobile:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TombolMobile"
ScreenGui.Parent = safeGui

-- Tombol Bulat di Tengah Atas Layar
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
-- Posisi dikunci di tengah atas (Center Top)
ToggleBtn.Position = UDim2.new(0.5, -25, 0, 20) 
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "UI"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextScaled = true
ToggleBtn.Active = true -- Memastikan tombol bisa disentuh

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleBtn

-- ==========================================
-- [BAGIAN 3] Logika Buka/Tutup Paling Stabil (Activated)
-- ==========================================
local uiTerbuka = true

-- Menggunakan 'Activated' (Event resmi Roblox untuk tap layar HP)
ToggleBtn.Activated:Connect(function()
    uiTerbuka = not uiTerbuka
    
    -- Mencari UI Kavo
    local kavoUI = safeGui:FindFirstChild("Kavo") or CoreGui:FindFirstChild("Kavo")
    
    if kavoUI then
        kavoUI.Enabled = uiTerbuka
    end
end)
