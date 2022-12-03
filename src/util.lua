--[[ 
    Arguments:
        -- table  - a Lua table object. 
        -- start  - an index belonging to the range [1, #table], which indicates the desired starting
                    position for the slice operation.
        -- finish - an index belonging to the range[start, #table], which indicates the desired ending 
                    position whose value ought to be included in the sliced table.
        -- step   - the amount by which we iterate through the interval [1, #table].

    Returns:
        A Lua table object, which contains the values of all the elements which were meant to be targetted by
        the slice operation.

    It is important to note, that, all the formal arguments, with the exception of table, are optional, 
    yet not providing any of them, might result in simply cloning the provided table!

    In addition to that, it is important to note that negative steps are allowed, and hence we can 
    slice a list from a start value which is greater than the finish value!

    Author: Andrei-Paul Ionescu.
 ]]
function table.slice(table, start, finish, step)
    assert(table)

    sliced = {}

    for current = start or 1, finish or #table, step or 1
    do
        sliced[#sliced + 1] = table[current]
    end

    return sliced
end

function generateQuads(atlas, width, height)
    local sw = atlas:getWidth() / width
    local sh = atlas:getHeight() / height

    local counter = 1
    local quads = {}

    for y = 0, sh - 1
    do
        for x = 0, sw - 1
        do
            quads[counter] = love.graphics.newQuad(x * width, y * height, width, height, atlas:getDimensions())
            counter = counter + 1
        end
    end

    return quads
end

function generateQuadsForBricks(atlas)
    return table.slice(generateQuads(atlas, 32, 16), 1, 21)
end

function generateQuadsForBalls(atlas)
    assert(table)

    local x = 96
    local y = 48

    local counter = 1
    local quads = {}

    for i = 0, 3 
    do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())

        counter = counter + 1
        x = x + 8
    end

    x = 96
    y = 56

    for i = 0, 2
    do
        quads[counter] = love.graphics.newQuad(x, y, 8, 8, atlas:getDimensions())
        counter = counter + 1
        x = x + 8
    end

    return quads
end

--[[
    Arguments:
        -- atlas - a spritesheet.

    Returns:
        -- A Lua table object containing all the sixteen sprites for the various skins and sizes of the 
        -- paddle game object.

    This here routine is responsible for retrieving the sprites of the paddle game object from within the 
    atlas. The retrieved sprites are then stored within a Lua table object, where the key for each one 
    is an integer value in the range [1, 16].

    Author: Andrei-Paul Ionescu.
]]
function generateQuadsForPaddles(atlas)
    assert(atlas)

    local x = 0
    local y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3
    do 
        -- Small size paddle sprite.
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1
        -- Medium size paddle sprite.
        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1
        -- Large size paddle sprite.
        quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16, atlas:getDimensions())
        counter = counter + 1
        -- Extra-large paddle sprite.
        quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16, atlas:getDimensions())
        counter = counter + 1
        
        x = 0
        y = y + 32
    end

    return quads
end