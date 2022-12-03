Ball = class{__includes=GameObject}

function Ball:init(skin) 
    self.skin = skin

   self.width, self.height = 8, 8

    self.x = VIRTUAL_WIDHT / 2 - self.width/2
    self.y = VIRTUAL_HEIGHT - 42

    self.deltaX = math.random(-200, 200) 
    self.deltaY = math.random(-50, -60)
end

function Ball:setSkin(skin)
    self.skin = skin
end

function Ball:reset()
    self.x = VIRTUAL_WIDHT / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2

    self.deltaX = math.random(-200, 200)  
    self.deltaY = math.random(-50, -60)
end

--[[
    Arguments:
        -- entity - a game object.

    Returns:
        -- a boolean which indicates whether the ball collides with the entity, or not.

    This here routine is performing a simple AABB collision check, so as to verify whether the ball intersects 
    with the entity passed as argument to the function or not.

    Author: Andrei-Paul Ionescu.
]]
function Ball:collides(entity)
    return 
    (self.x > entity.x + entity.width or entity.x > self.x + self.width) == false
    and 
    (self.y > entity.y + entity.height or entity.y > self.y + self.height) == false
end

function Ball:update(deltaTime)
    self.x = self.x + self.deltaX * deltaTime
    self.y = self.y + self.deltaY * deltaTime   

    if self.x >= VIRTUAL_WIDHT - self.width then
        self.x = VIRTUAL_WIDHT - self.width
        self.deltaX = -self.deltaX
        gSounds['wall-hit']:play()
    end
    
    if self.x <= 0 then 
        self.x = 0
        self.deltaX = -self.deltaX
        gSounds['wall-hit']:play()
    end

    if self.y <= 0 then 
        self.y = 0
        self.deltaY = -self.deltaY
        gSounds['wall-hit']:play()
    end

    if self.y >= VIRTUAL_HEIGHT then 
        self:reset()
        gSounds['hurt']:play()
    end

end

function Ball:draw() 
    love.graphics.draw(gGraphics['main'], gSprites['ball'][self.skin], self.x, self.y)
end