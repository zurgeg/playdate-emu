isSub = false
savedPC = 0 -- where to jump back to at the end of a subroutine
currentPC = 0

function handleInstruction(instruction)
    if (instruction & 0xF == 0x0 and not instruction & 0x00F0 == 0xE) then
        -- JSR NNN: Jump to subroutine NNN
        savedPC = currentPC -- save PC
        currentPC = instruction & 0x0FFF -- jump to sub address
        isSub = true -- set subroutine flag
    elseif instruction == 0x00E0 then
        -- CLS: Clear the display
        playdate.graphics.clear()
    elseif instruction == 0x00EE and isSub then
        -- RET: Return from subroutine
        currentPC = savedPC -- jump back to saved PC
        isSub = false -- clear subroutine flag
    elseif instruction & 0xF == 0x1 then
        -- JP NNN: Jump to address NNN
        currentPC = instruction & 0x0FFF
    elseif instruction & 0xF == 0x2 then
        -- CALL NNN: Call subroutine at NNN
        savedPC = currentPC -- save PC
        currentPC = instruction & 0x0FFF -- jump to sub address
        isSub = true -- set subroutine flag
    else
        print("Unknown instruction: " .. instruction)
    end
    return currentPC
end


    
    