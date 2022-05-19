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
    print("instruction:" .. instruction .. " savedPC:" .. savedPC .. " currentPC:" .. currentPC)
    print("first nybble:" .. (bitand(instruction, 0x00F0)) .. " second nybble:" .. (instruction & 0x0F00))
    if (instruction & 0x00F0 == 0x0 and not instruction & 0xF000 == 0xE) then
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
    elseif instruction & 0x00F0 == 0x1 then
        -- JP NNN: Jump to address NNN
        print("jp: " .. instruction & 0xFF0F)
        currentPC = instruction & 0x0FF0F
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


    
    