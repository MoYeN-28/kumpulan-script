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
-- [BAGIAN 2] Sistem Tombol Toggle (Buka/Tutup) Anti-Gagal
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

-- Menghapus tombol lama jika script dijalankan ulang
if CoreGui:FindFirstChild("TombolBukaTutup") then
    CoreGui.TombolBukaTutup:Destroy()
end

-- Membuat wadah UI baru
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TombolBukaTutup"
ScreenGui.Parent = CoreGui

-- Membuat Tombol Bulat Melayang
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.Size = UDim2.new(0, 50, 0, 50) -- Ukuran tombol 50x50
ToggleBtn.Position = UDim2.new(0, 15, 0, 15) -- Posisi di pojok kiri atas
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "UI"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextScaled = true
ToggleBtn.Active = true
ToggleBtn.Draggable = true -- Menggunakan fitur geser bawaan engine Roblox (Sangat stabil)

-- Membuat tombol menjadi bulat sempurna
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = ToggleBtn

-- ==========================================
-- [BAGIAN 3] Logika Ketuk (Klik)
-- ==========================================
local uiTerbuka = true

ToggleBtn.MouseButton1Click:Connect(function()
    uiTerbuka = not uiTerbuka
    
    -- Mencari UI Kavo dan menyembunyikan/menampilkannya
    local kavoUI = CoreGui:FindFirstChild("Kavo") or Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Kavo")
    if kavoUI then
        kavoUI.Enabled = uiTerbuka
    end
end)
