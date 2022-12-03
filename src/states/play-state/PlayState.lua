require 'src.game-objects.paddle.Paddle'
require 'src.game-objects.ball.Ball'
require 'src.game-objects.brick.Brick'
require 'src.level.Level'

PlayState = class{__includes=State}

local paddle = Paddle:newDefaultPaddle()
local ball   = Ball(math.random(7))
local brick  = Brick()
local level  = Level.createLevel()

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
        -- Position the ball higher than the paddle, so as to account for the case in which it might get lower than that.
        ball.y = ball.y - ball.height/4
        ball.deltaY = -ball.deltaY 

        -- Correct the angle at which the ball bounces back.
        if ball.x < paddle.x + (paddle.width / 2) and paddle.deltaX < 0 then 
            ball.deltaX = -50 + -8 * (paddle.x + paddle.width / 2 - ball.x)
        elseif ball.x > paddle.x + paddle.width / 2 and paddle.deltaX > 0 then
            ball.deltaX = 50 + 8 * math.abs(paddle.x + paddle.width / 2 - ball.x)
        end     

        gSounds['paddle-hit']:play()
    end

    for key, value in ipairs(level)
    do
        if value == nil then
            table.remove(level, key)
        end

        if ball:collides(value) and value.exists then
            value:update(deltaTime)
            gSounds['brick-hit-1']:play()
        end
    end
end

function PlayState:render()
    paddle:draw()
    ball:draw()
    
    for key, value in ipairs(level)
    do
        value:draw()
    end
end