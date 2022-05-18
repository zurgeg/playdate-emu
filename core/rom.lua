import("gfx/text")

function getROMs()
    addText("Getting ROMs...")
    local roms = {}
    local romPath = "roms/"
    if not playdate.file.isdir(romPath) then
        playdate.file.mkdir(romPath)
        addText("No roms found!")
        return roms
    end
    local files = playdate.file.listFiles(romPath)
    local numRoms = 0
    for i, file in ipairs(files) do
        print(i)
        roms[i] = file
        numRoms  = numRoms + 1
    end
    -- playdate.graphics.clear()
    -- playdate.graphics.drawText("Found " .. numRoms .. " ROMs.", 0, 20)
    addText("Found " .. numRoms .. " ROMs.")
    return roms
end

function loadROM(rom)
    addText("Loading ROM...")
    local romPath = "roms/" .. rom
    local romData = playdate.file.open(romPath)
    if not romData then
        addText("Failed to load ROM!")
        return false
    end
    -- playdate.graphics.clear()
    -- playdate.graphics.drawText("Loaded ROM!", 0, 20)
    addText("Loaded ROM!")
    return romData
end