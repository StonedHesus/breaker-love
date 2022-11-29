require 'src.game-objects.paddle.Paddle'

PlayState = class{__includes=State}

local paddle = Paddle()

function PlayState:init()
end

function PlayState:update(deltaTime)
    paddle:update(deltaTime)
end

function PlayState:render()
    paddle:draw()
end