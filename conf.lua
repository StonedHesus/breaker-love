require 'src.constants'

function love.conf(table)
    -- Set the title of the current window to the name of the game.
    table.window.title = GAME_TITLE
    -- Indicate the Lua version for which this software was developed.
    table.version = "11.4"
    table.gammacorrect = true
    table.window.icon =  'icon/icon.png'
    table.window.highdpi = false 
end