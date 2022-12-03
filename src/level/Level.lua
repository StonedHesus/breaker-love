Level = class{}

--[[
    Arguments:
        -- NONE

    Returns:
        -- A Lua table object which contains all the bricks within the randomly generated level.

    This here routine, is supposed to behave like a static method in a more structurally strict OOP language.
    Its role is to generate a given level, utilising the odds ration of the math.random() routine.

    Special attention ought to be redirected to the arguments which we passed to the Brick's constructor, for it also ensures that a padding will be 
    applied to both axis, and that the layout is properly centred.
    Do not that the (13 - columns) * 16, only applies, if and only if our random routine has yield the maximum bound for the number of columns, 
    and in that case we ought to paddle our pluton of brick to the left.

    Author: Andrei-Paul Ionescu.
]]
function Level.createLevel()
    local bricks = {}

    local rows = math.random(1, 5)
    local columns = math.random (7, 13)

    local x = 64
    local y = 32

    for i = 1, rows
    do
        for j = 1, columns
        do
            table.insert(bricks, Brick((j-1) * 32  + 8 + (13 - columns) * 16, i * 16):setColour(math.random(1, 4)):setTier(math.random(1, 4)))
        end
    end

    return bricks
end