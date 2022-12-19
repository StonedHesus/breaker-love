Brick = class{__includes=GameObject}
-- A Lua table object containing a collection of RGB defined colour triplets, 
-- which correspond to the colour of the bricks found within the game's atlas.
local colours = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}

function Brick:init(x, y)
    self.x = x
    self.y = y

    self.width = 32
    self.height = 16

    self.tier = 1
    self.colour = 1

    self.exists = true
	
	self.particleSystem = love.graphics.newParticleSystem(gGraphics['particle'], 64)
	self.particleSystem:setParticleLifetime(0.5, 1)
	self.particleSystem:setLinearAcceleration(-15, 0, 15, 80)
	self.particleSystem:setEmissionArea('normal', 10, 10)
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

function Brick:hit()
    -- Set the colours for the particle system, based on the colour of the tile that 
    -- was hit.
    self.particleSystem:setColors(
        colours[self.colour].r / 255,
        colours[self.colour].g / 255,
        colours[self.colour].b / 255,
        55 * (self.tier + 1) / 255,
        colours[self.colour].r / 255,
        colours[self.colour].g / 255,
        colours[self.colour].b / 255,
        0
    )
    -- Trigger the emission of the particles.
    self.particleSystem:emit(64)
    -- Respond to the event in accordance to the tier of the brick that was hit.
    if self.tier == 1 then 
        gSounds['brick-hit-2']:play()
        self.exists = false
        self:destroy()
    else 
        gSounds['brick-hit-1']:play()
        self.tier = self.tier - 1
    end
end

function Brick:update(deltaTime)
	self.particleSystem:update(deltaTime)
end

function Brick:drawParticles()
	love.graphics.draw(self.particleSystem, self.x + 16, self.y + 8)
end

function Brick:draw()
    if self.exists then 
        love.graphics.draw(gGraphics['main'], gSprites['brick'][self.tier + 4 * (self.colour - 1)], self.x, self.y)
    end
end