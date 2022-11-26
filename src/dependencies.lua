--[[
    This here Lua compilation unit contains a collection diverse require statements, entire libraries which 
    are stored in specific global handles, and global tables, which are prefixed with a lowercase g.

    All these requirements ought to be accessible by any file within the projects, hence the motivation 
    behind utilising yet another anti-pattern for the modern OOP developer.

    In order to have access to the bulk of information stored within this unit one simply has to require 
    it in the file in which he, or she ,or it is working.

    Author: Andrei-Paul Ionescu.
]]
-- External libraries having their reference stored within a global variable.
push = require 'lib/push'
class = require 'lib/class'

-- Require statements.
require 'src/constants'

-- Global tables, utilised to contain resources, such as fonts, graphics, sounds, etcetera.
gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('fonts/font.ttf', 32),
}