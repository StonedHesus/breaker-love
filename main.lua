--[[

    Author: Andrei-Paul Ionescu.
]]

require 'src.dependencies'

local SHOULD_DISPLAY_FPS = true
local MUTE = false

function love.load()
    -- Set the title of the current window to the name of the game.
    love.window.setTitle(GAME_TITLE)

    -- Setup the push configuration for the project.
    push:setupScreen(VIRTUAL_WIDHT, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false, 
        resizable  = true,
        vsync = true
    })

    gStateMachine:change('start')

    -- Initialise the input map.
    love.keyboard.keypressed = {}
end

function love.keypressed(key)
    if key == 'f' then 
        SHOULD_DISPLAY_FPS = not SHOULD_DISPLAY_FPS
    end
    if key == 'm' then 
        MUTE = not MUTE
    end

    love.keyboard.keypressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keypressed[key]
end

function love.update(deltaTime)
    gStateMachine:update(deltaTime)
    if not MUTE then 
        gSounds['music']:play()
    else 
        gSounds['music']:pause()
    end
end

function love.draw()
    push:start()
        -- Draw first the background sprite. The sprite is common to all states/views.
        love.graphics.draw(gGraphics['background'],
            -- Draw the image at coordinates (0, 0) aka the top left corner.
            0, 0,
            -- We do not want any rotation.
            0,
            -- Specify a sequence of scale factors so as to ensure that our image covers the whole screen.
            VIRTUAL_WIDHT / (gGraphics['background']:getWidth() - 1), VIRTUAL_HEIGHT / (gGraphics['background']:getHeight() - 1)
        )

        gStateMachine:render()

        -- If the flag for showing the FPS counter is true then display it.
        if SHOULD_DISPLAY_FPS then 
            displayFPS()
        end
    push:finish()
end

--[[
    This here routine is a local method of the current lua compilation unit.

    Its task is to display an FPS counter, whose text is coloured in neon green and whose position 
    is always the top left corner.

    This method is defined within the main file of the program, and not within any particular state for 
    we wish to see the frame rate during the execution of the entire program, regardless of the state 
    in which we currently preside.

    If, by any chance, the user wants to turn off the FPS counter, it can just simply press command + f.

    Author: Andrei-Paul Ionescu
]]
function displayFPS()
    -- Set the current colour to a neon green.
    love.graphics.setColor(0, 255, 0)
    -- Set the font which we are going to utilise so as to draw the text to the screen.
    --love.graphics.setFont(gFonts['small'])
    -- Display the current frame rate in the upper left corner.
    love.graphics.print ( "FPS: " .. tostring(love.timer.getFPS()), 4, 4)
    -- Change the colour back to the original, i.e. plain old white.
    love.graphics.setColor(0, 0, 0)
end