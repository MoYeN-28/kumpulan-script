-- Memuat Kavo UI Library dari internet
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Membuat jendela utama (Ganti "BloodTheme" dengan "DarkTheme" atau "Ocean" jika ingin ubah warna)
local Window = Library.CreateLib("Dashboard Mobile Ringan", "BloodTheme")

-- Membuat Tab dan Kategori Menu
local TabUtama = Window:NewTab("Menu Utama")
local SectionFitur = TabUtama:NewSection("Fitur Dasar")

-- Tombol Biasa
SectionFitur:NewButton("Notifikasi Uji Coba", "Menampilkan tes notifikasi", function()
    game.StarterGui:SetCore("SendNotification", {
        Title = "Kavo UI",
        Text = "Tombol berfungsi dengan baik di HP!",
        Duration = 3
    })
end)

-- Tombol Saklar (Toggle)
SectionFitur:NewToggle("Saklar Auto-Jump", "Bikin karakter lompat terus", function(state)
    _G.AutoJump = state
    
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    
    while _G.AutoJump do
        if humanoid then
            humanoid.Jump = true
        end
        task.wait(0.5)
    end
end)

-- Tab Kedua untuk Pengaturan
local TabSetting = Window:NewTab("Pengaturan")
local SectionSetting = TabSetting:NewSection("Info Script")

SectionSetting:NewLabel("Script ini dibuat khusus untuk Executor HP")
