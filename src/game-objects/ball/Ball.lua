Ball = class{__includes=GameObject}

function Ball:init(skin) 
    self.skin = skin

    self.x = VIRTUAL_WIDHT / 2 - 4
    self.y = VIRTUAL_HEIGHT - 42

    self.deltaX = math.random(-200, 200) 
    self.deltaY = math.random(-50, -60)
end

function Ball:reset()
    self.x = VIRTUAL_WIDHT / 2 - 2
    self.y = VIRTUAL_HEIGHT / 2 - 2

    self.deltaX = 0 
    self.deltaY = 0
end

function Ball:update(deltaTime)
    self.x = self.x + self.deltaX * deltaTime
    self.y = self.y + self.deltaY * deltaTime   

    if self.x >= VIRTUAL_WIDHT then 
        self.deltaX = -self.deltaX
        gSounds['wall-hit']:play()
    end

end

function Ball:draw() 
    love.graphics.draw(gGraphics['main'], gSprites['ball'][self.skin], self.x, self.y)
end