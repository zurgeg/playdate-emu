function handleRomData(rom)
    clearStage() -- clean up
    firstInstruction, err = rom:read(4)
    print("instruction" .. firstInstruction)
    if firstInstruction == nil then
        addText("Failed to read first instruction! (failure: " .. err .. ")")
        return
    end
    firstInstruction = firstInstruction.unpack("<i4", firstInstruction)
    pc = handleInstruction(firstInstruction)
    while true do
        rom:seek(pc)
        print(pc)
        local instruction = rom:read(4)
        instruction = instruction.unpack("<i4", instruction)
        print("instruction" .. instruction)
        pc = handleInstruction(instruction)
    end
end
