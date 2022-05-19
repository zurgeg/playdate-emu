function handleRomData(rom)
    clearStage() -- clean up
    firstInstruction, err = rom:read(2)
    print("instruction" .. firstInstruction)
    if firstInstruction == nil then
        addText("Failed to read first instruction! (failure: " .. err .. ")")
        return
    end
    firstInstruction = firstInstruction.unpack("<i2", firstInstruction)
    pc = handleInstruction(firstInstruction)
    while true do
        rom:seek(pc)
        print(pc)
        local instruction = rom:read(2)
        instruction = instruction.unpack("<i2", instruction)
        print("instruction" .. instruction)
        pc = handleInstruction(instruction)
    end
end
