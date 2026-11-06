-- Memuat Orion UI Library dari internet
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Membuat Jendela Dashboard Utama
local Window = OrionLib:MakeWindow({
    Name = "Dashboard Script Saya", 
    HidePremium = false, 
    SaveConfig = true, 
    ConfigFolder = "FolderScriptSaya"
})

-- Membuat Tab Menu Pertama
local TabUtama = Window:MakeTab({
    Name = "Menu Utama",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Menambahkan Tombol Biasa di Menu Utama
TabUtama:AddButton({
    Name = "Klik Saya untuk Notifikasi",
    Callback = function()
        -- Apa yang terjadi saat tombol diklik
        OrionLib:MakeNotification({
            Name = "Notifikasi",
            Content = "Tombol berhasil ditekan!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end    
})

-- Menambahkan Tombol Saklar (Toggle) untuk fitur seperti Auto-Farm
TabUtama:AddToggle({
    Name = "Fitur Auto (Contoh)",
    Default = false,
    Callback = function(Value)
        if Value == true then
            print("Fitur Auto Dinyalakan")
        else
            print("Fitur Auto Dimatikan")
        end
    end    
})

-- Membuat Tab Menu Kedua
local TabPengaturan = Window:MakeTab({
    Name = "Pengaturan",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

TabPengaturan:AddLabel("Ini adalah menu pengaturan script.")

-- Menyelesaikan dan menampilkan UI
OrionLib:Init()
