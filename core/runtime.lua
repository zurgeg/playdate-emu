pc = 0
lastPC = 0
didCrash = false

function handleRomData(rom)
    -- DON'T USE THIS FUNCTION
    clearStage() -- clean up
    firstInstruction, err = rom:read(2)
    print("instruction" .. firstInstruction)
    if firstInstruction == nil then
        addText("Failed to read first instruction! (failure: " .. err .. ")")
        return
    end
    firstInstruction = firstInstruction.unpack(">i2", firstInstruction)
    pc = handleInstruction(firstInstruction)
    while true do
        rom:seek(pc)
        print(pc)
        local instruction = rom:read(2)
        instruction = instruction.unpack(">i2", instruction)
        print("instruction" .. instruction)
        pc = handleInstruction(instruction)
    end
end

function runNextInstruction(rom, size)
    rom:seek(pc)
    local instruction = rom:read(2)
    instruction = instruction.unpack(">i2", instruction)
    print(instruction)
    lastPC = pc
    pc = handleInstruction(instruction)
    if pc > size or didCrash then
        --clearStage()
        --addText("Aborted! pc > size! (PC: " .. pc .. ") (size: " .. size .. ")")
        --didCrash = true
        --return false
        print("overjump... recovering...")
        pc = lastPC + 2
        forceUpdatePC(pc)
        lastPC = pc - 2
        print("recovered to " .. pc)
        return true
    end
    return true
end


