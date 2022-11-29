Paddle = class{__includes = GameObject}

function Paddle:init()
    -- Specify the default skin which we want to utilise, where a skin is a different colour for the
    -- current paddle.
    self.skin = 1

    -- Specify the size which we want to have by default.
    self.size = 2

    self.x = VIRTUAL_WIDHT / 2 - 32
    self.y = VIRTUAL_HEIGHT -  32

    self.deltaX = 0
    self.speed  = PADDLE_SPEED
    
end

function Paddle:setSkin(skin)
    assert(skin > 0 and skin < 5)
    self.skin = skin
end

function Paddle:setSize(size)
    assert(size > 0 and size < 5)
    self.size = size
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
        self.x = math.min(self.x + self.deltaX * deltaTime, VIRTUAL_WIDHT - 68)
    end
end

function Paddle:draw()
    love.graphics.draw(gGraphics['main'], gSprites['paddle'][self.size + 4 * (self.skin - 1)], self.x, self.y)
end