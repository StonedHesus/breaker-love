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
luaunit = require 'lib.luaunit'

-- Require statements.
require 'src/constants'
require 'src.util'

-- Set the default graphical filter to be nearest-nearest.
love.graphics.setDefaultFilter('nearest', 'nearest')

-- Global tables, utilised to contain resources, such as fonts, graphics, sounds, etcetera.
gFonts = {
    ['small']  = love.graphics.newFont('fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('fonts/font.ttf', 16),
    ['large']  = love.graphics.newFont('fonts/font.ttf', 32),
}

gSounds = {
    ['brick-hit-1']     = love.audio.newSource('sounds/brick-hit-1.wav', 'static'),
    ['brick-hit-2']     = love.audio.newSource('sounds/brick-hit-2.wav', 'static'),
    ['confirm']         = love.audio.newSource('sounds/confirm.wav', 'static'),
    ['high-score']      = love.audio.newSource('sounds/high_score.wav', 'static'),
    ['hurt']            = love.audio.newSource('sounds/hurt.wav', 'static'),
    ['no-select']       = love.audio.newSource('sounds/no-select.wav', 'static'),
    ['paddle-hit']      = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
    ['pause']           = love.audio.newSource('sounds/pause.wav', 'static'),
    ['recover']         = love.audio.newSource('sounds/recover.wav', 'static'),
    ['score']           = love.audio.newSource('sounds/score.wav', 'static'),
    ['select']          = love.audio.newSource('sounds/select.wav', 'static'),
    ['victory']         = love.audio.newSource('sounds/victory.wav', 'static'),
    ['wall-hit']        = love.audio.newSource('sounds/wall_hit.wav', 'static'),

    ['music']           = love.audio.newSource('sounds/music.wav', 'static')
}

gGraphics = {
    ['background'] = love.graphics.newImage('graphics/background.png'),
    ['main']       = love.graphics.newImage('graphics/breakout.png')
}

gSprites = {
    ['paddle'] = generateQuadsForPaddles(gGraphics['main']),
    ['ball']   = generateQuadsForBalls(gGraphics['main'])
}

-- Require statements.
require 'src.StateMachine'
require 'src.states.model.State'
require 'src.states.start-state.StartState'
require 'src.states.play-state.PlayState'
require 'src.game-objects.model.GameObject'
require 'src.game-objects.paddle.Paddle'
require 'src.game-objects.ball.Ball'

-- Global variable containing the state machine for the current program.
gStateMachine = StateMachine {
    ['start'] = function() return StartState() end,
    ['play']  = function() return PlayState() end
}
