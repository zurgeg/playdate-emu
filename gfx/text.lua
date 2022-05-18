-- Helper for displaying text

stage = {}

-- for those wondering why the below exists:
-- I was not aware that the # could be used to get the length of a table (nor was I aware of it)
-- so I just had a table that described the last x and the last y
-- yes it's stupid i know
stageMeta = {
    lastX = 0,
    lastY = 0,
    isFirst = true
}

function getStage()
    return stage
end

function getStageMeta()
    return stageMeta
end

function setStageMetaProp(prop, value)
    -- internal function
    stageMeta[prop] = value
end

function drawStage()
    -- draw the stage
    for i, content in ipairs(stage) do
        playdate.graphics.drawText(content.text, content.x, content.y)
    end
end

function rawUpdateStage(text, idx, x, y, display)
    -- update raw stage
    -- for use inside gfx libraries (will probably work elsewhere though)
    local content = {}
    content.type = "text" -- unused for now
    content.text = text
    content.x = x
    content.y = y
    stage[idx] = content
    display = display or false -- display immediately?
    if display then
        drawStage()
    end
end

function addText(text, xoff, yoff, drawImmediately)
    xoff = xoff or 0
    yoff = yoff or 20 -- 20px is good for newlines
    x = stageMeta.lastX + xoff
    if stageMeta.isFirst then
        y = stageMeta.lastY
        stageMeta.isFirst = false
    else
        y = stageMeta.lastY + yoff
    end
    rawUpdateStage(text, #stage + 1, x, y)
    setStageMetaProp("lastX", x)
    setStageMetaProp("lastY", y)
    setStageMetaProp("isFirst", false)
    drawImmediately = drawImmediately or false
    if drawImmediately then
        drawStage()
    end
end

function clearStage()
    stage = {}
    stageMeta.lastX = 0
    stageMeta.lastY = 0
    stageMeta.isFirst = true
    playdate.graphics.clear()
end