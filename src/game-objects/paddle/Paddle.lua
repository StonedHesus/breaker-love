--[[
    This here compilation unit, contains the implementation of the conceptual design of the 
    paddle object.

    Author: Andrei-Paul Ionescu.
]]

Paddle = class{__includes = GameObject}

function Paddle:init(skin, size)
    self.skin = skin

    self.size = size

    _, _,self.width, self.height = gSprites['paddle'][self.size + 4 * (self.skin - 1)]:getViewport()

    self.x = VIRTUAL_WIDHT / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT -  32

    self.deltaX = 0
    self.speed  = PADDLE_SPEED
end

function Paddle:newDefaultPaddle()
    return Paddle(1, 2)
end

function Paddle:setSkin(skin)
    assert(skin > 0 and skin < 5)
    self.skin = skin
end

function Paddle:setSize(size)
    assert(size > 0 and size < 5)
    self.size = size
    _, _,self.width, self.height = gSprites['paddle'][self.size + 4 * (self.skin - 1)]:getViewport()
end

function Paddle:update(deltaTime)
    if love.keyboard.isDown('left') then 
        self.deltaX = - self.speed
    elseif love.keyboard.isDown('right') then 
        self.deltaX =  self.speed
    else 
        self.deltaX = 0
    end

    if self.deltaX < 0 then 
        self.x = math.max(0, self.x + self.deltaX * deltaTime)
    else
        self.x = math.min(self.x + self.deltaX * deltaTime, VIRTUAL_WIDHT - self.width - 4)
    end
end

function Paddle:draw()
    love.graphics.draw(gGraphics['main'], gSprites['paddle'][self.size + 4 * (self.skin - 1)], self.x, self.y)
end