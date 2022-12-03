Brick = class{__includes=GameObject}

function Brick:init(x, y)
    self.x = x
    self.y = y

    self.width = 32
    self.height = 16

    self.tier = 1
    self.colour = 1

    self.exists = true
end

function Brick:setColour(colour)
    assert(colour >= 1 and colour < 5)
    self.colour = colour
    return self
end

function Brick:setTier(tier)
    assert(tier >= 1 and tier < 5)
    self.tier = tier
    return self
end

function Brick:destroy()
    self = nil
end

function Brick:update(deltaTime)
    if self.tier == 1 then 
        gSounds['brick-hit-2']:play()
        self.exists = false
        self:destroy()
    else 
        gSounds['brick-hit-1']:play()
        self.tier = self.tier - 1
    end
end

function Brick:draw()
    if self.exists then 
        love.graphics.draw(gGraphics['main'], gSprites['brick'][self.tier + 4 * (self.colour - 1)], self.x, self.y)
    end
end