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

    for key, brick in ipairs(level)
    do
        if brick == nil then
            table.remove(level, key)
        end

        if ball:collides(brick) and brick.exists then
            brick:update(deltaTime)
        
            -- Once collided with the brick, in accordance to the laws of the game, the ball ought to bounce, at an angle which is computed 
            -- based on which side of the brick it has collided with. This feature also allows us to not detect multiple hits for the same brick, 
            -- thus clearing the levels unfairly easy.
            if ball.x + 2 < brick.x and ball.deltaX > 0 then -- top-left collision.
                ball.deltaX = -ball.deltaX
                ball.x = ball.x - 8
            elseif ball.x + 6 > brick.x + brick.width and ball.deltaX < 0 then  -- top-right collision.
                ball.deltaX = -ball.deltaX
                ball.x = brick.x + 32
            elseif ball.y < brick.y then  -- top-edge, no X-axis collision.
                ball.deltaY = -ball.deltaY
                ball.y = ball.y - 8
            else  -- bottom-edge, no X-axis collision.
                ball.deltaY = -ball.deltaY
                ball.y = brick.y + 16
            end 

            ball.deltaY = ball.deltaY * 1.02

            break
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