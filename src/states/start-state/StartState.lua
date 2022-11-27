--[[

    Author: Andrei-Paul Ionescu
]]

-- Require statements of the unit.
require 'src.states.model.State'

-- Indicate to the environment that StartState is a class that extends the class State.
StartState = class{__includes = State}

local currentlyHighlighted = 1
local options = {'Play', 'High Score', 'Exit'}

function StartState:update(deltaTime)
    -- If the user pressed escaped whilst in this state, then the whole application will cease to run.
    if love.keyboard.wasPressed('escape') then 
        love.event.quit()
    end

    if love.keyboard.wasPressed('up') then 
        if currentlyHighlighted == 1 then 
            currentlyHighlighted = #options
        else
            currentlyHighlighted = currentlyHighlighted -1 
        end
        love.keyboard.keypressed['up'] = false

        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('down') then 
        if currentlyHighlighted == #options then 
            currentlyHighlighted = 1 
        else 
            currentlyHighlighted = currentlyHighlighted + 1 
        end
        love.keyboard.keypressed['down'] = false

        gSounds['paddle-hit']:play()
    end

    if love.keyboard.wasPressed('return') then 
        gSounds['select']:play()

        if options[currentlyHighlighted] == 'Exit' then
            love.event.quit()
        end

        love.keyboard.keypressed['return'] = false
    end
end

function StartState:render()
    -- First print the game title at a fixed position; making sure that the large font is utilised.
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(GAME_TITLE, 0 , VIRTUAL_HEIGHT / 4, VIRTUAL_WIDHT, 'center')
    
    love.graphics.setFont(gFonts['medium'])

    for index, value in ipairs(options) 
    do
        if index == currentlyHighlighted then
            love.graphics.setColor(103/255, 1, 1, 1)
        else
            love.graphics.setColor(255, 255, 255)
        end

        love.graphics.printf(value, 0, VIRTUAL_HEIGHT / 2 + 25 * index, VIRTUAL_WIDHT, 'center')
    end

    -- Reset the font back to the small one, which acts as the default one.
    love.graphics.setFont(gFonts['small'])

    -- Reset the colour back to white.
    love.graphics.setColor(255, 255, 255)
end