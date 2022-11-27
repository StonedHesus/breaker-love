--[[
    This here Lua compilation unit contains a list of all the global constants that are going to be 
    utilised throughout the entire application.

    We acknowledge that by doing this we introduce an anti-pattern, but due to the nature in which 
    Lua code is structured, and to the level of complexity of the current project, we believe the 
    choice to be more than justified, so as to not clutter too much the code when not truly necessary.

    Author: Andrei-Paul Ionescu.
]]

-- Game title.
GAME_TITLE = "Breaker"

-- Virtual screen dimensions.
VIRTUAL_WIDHT  = 432
VIRTUAL_HEIGHT = 243

-- Actual window dimensions.
WINDOW_WIDTH  = 1280
WINDOW_HEIGHT = 720 