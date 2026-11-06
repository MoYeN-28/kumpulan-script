-- Memunculkan notifikasi di layar
game.StarterGui:SetCore("SendNotification", {
    Title = "Loader Sukses!",
    Text = "Script dari GitHub berhasil dimuat.",
    Duration = 5
})

-- Mencetak pesan di konsol executor
print("Berhasil! Menjalankan script sebagai: " .. game.Players.LocalPlayer.Name)
