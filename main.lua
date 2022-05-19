import("core/rom")
import("core/instruction")
import("core/runtime")
import("CoreLibs/ui")
import("CoreLibs/timer")
import("CoreLibs/graphics")
playdate.ui.crankIndicator:start()

-- newline is ~20 px
-- playdate.graphics.drawText("hi, this is useless right now, come back later :)", 0, 0)

local roms = getROMs()
selectedROM = 1 -- i don't feel like implementing a proper selection system right now
local romdata = loadROM(roms[selectedROM])

function playdate.update()
    playdate.graphics.clear()
    playdate.timer.updateTimers()
    drawStage()
    if playdate.isCrankDocked() then
        -- TODO: indicate that the game is paused
        playdate.ui.crankIndicator:update()
    else
        clearStage() 
        runNextInstruction(romdata)
    end

end