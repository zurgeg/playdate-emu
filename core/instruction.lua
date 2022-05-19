debug = true -- set to true to enable debugging
isSub = false
savedPC = 0 -- where to jump back to at the end of a subroutine
currentPC = 0

function forceUpdatePC(pc)
    currentPC = pc
end

function handleInstruction(instruction)
    nybble1 = instruction &= 0xF000
    jmparg = instruction &= 0x0FFF
    if debug then
        print("nybble1: " .. nybble1)
        print("jmparg: " .. jmparg)
    end
    if instruction == 0x00E0 then
        clearStage()
        return currentPC + 2
    elseif instruction == 0x00EE then
        if debug then
            print("return from sub (unimplemented)")
        end
        return currentPC + 2
    elseif nybble1 == 0x1000 then
        if debug then
            print("jmp " .. jmparg)
        end
        return jmparg
    elseif nybble1 == 0x2000 then
        if debug then
            print("call " .. jmparg .. " (unimplemented)")
        end
        return currentPC + 2
    else
        print("unimplemented instruction: " .. instruction)
        return currentPC + 2
    end
end


    
    