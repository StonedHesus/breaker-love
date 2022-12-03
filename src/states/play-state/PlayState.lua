require 'src.game-objects.paddle.Paddle'
require 'src.game-objects.ball.Ball'

PlayState = class{__includes=State}

local paddle = Paddle:newDefaultPaddle()
local ball   = Ball(math.random(7))

function PlayState:init()
end

function PlayState:update(deltaTime)

    if love.keyboard.wasPressed('escape') then 
        love.keyboard.keypressed['escape'] = false
        gStateMachine:change('start')
    end

    paddle:update(deltaTime)
    ball:update(deltaTime)

    if ball:collides(paddle) then
        ball.deltaY = -ball.deltaY 
        gSounds['paddle-hit']:play()
    end
end

function PlayState:render()
    paddle:draw()
    ball:draw()
end