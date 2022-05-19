isSub = false
savedPC = 0 -- where to jump back to at the end of a subroutine
currentPC = 0
function bitand(a, b)
    local result = 0
    local bitval = 1
    while a > 0 and b > 0 do
      if a % 2 == 1 and b % 2 == 1 then -- test the rightmost bits
          result = result + bitval      -- set the current bit
      end
      bitval = bitval * 2 -- shift left
      a = math.floor(a/2) -- shift right
      b = math.floor(b/2)
    end
    return result
end

function handleInstruction(instruction)
    -- how the bytes are organized:
    -- 0xF000: upper second byte (0x124E -> 0x0040)
    -- 0x0F00: lower second byte (0x124E -> 0x000E)
    -- 0x00F0: upper first byte (0x124E -> 0x10)
    -- 0x000F: lower first byte (0x124E -> 0x02)
    if (instruction &= 0x00F0 == 0x0 and not instruction &= 0xF000 == 0xE) then
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
    elseif instruction &= 0x00F0 == 0x10 then
        -- JP NNN: Jump to address NNN
        print("JP : " .. (instruction &= 0xFF0F))
        currentPC = instruction & 0xFF0F
    elseif instruction &= 0xF == 0x2 then
        -- CALL NNN: Call subroutine at NNN
        savedPC = currentPC -- save PC
        currentPC = instruction & 0xFFF0 -- jump to sub address
        isSub = true -- set subroutine flag
    else
        print("Unknown instruction: " .. instruction)
    end
    return currentPC
end


    
    