function getROMs()
    playdate.graphics.drawText("Getting ROMs...", 0, 0)
    local roms = {}
    local romPath = "roms/"
    local files = playdate.file.listFiles(romPath)
    local idx = 0
    for i in files do
        roms[idx] = i
        idx = idx + 1
    end
    playdate.graphics.drawText("Found " .. idx .. " ROMs.", 0, 0)
end