require 'src.game-objects.paddle.Paddle'
require 'src.game-objects.ball.Ball'

PlayState = class{__includes=State}

local paddle = Paddle()
local ball   = Ball(math.random(7))

function PlayState:init()
end

function PlayState:update(deltaTime)
    paddle:update(deltaTime)
    ball:update(deltaTime)
end

function PlayState:render()
    paddle:draw()
    ball:draw()
end