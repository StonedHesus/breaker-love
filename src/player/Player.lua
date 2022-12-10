Player = class{}

function Player:init()
    self.username = ""
    self.defaultHP = 3
    self.currentHP = 3
    self.maxHP = 4
    self.score = 0
end

function Player:setUsername(username)
    self.username = username
end 

function Player:getUsername()
    return self.username
end

function Player:loseHP(amount)
    self.currentHP = self.currentHP - amount
end

function Player:gainHP(amount)
    self.currentHP = self.currentHP + amount
end

function Player:resetHP()
    self.currentHP = self.defaultHP
end

function Player:addScore(amount)
    self.score = self.score + amount
end

function Player:subtractScore(amount)
    self.score = self.score - amount
end

function Player:resetScore()
    self.score = 0
end

--[[
    This here routine is responsible for converting the essential information which we will perceive as non-volatile, i.e. the name, and the score;
    into a formatted string, which resembles the CSV format.
    This result will be later utilised so as to store it within the game's high-score database.

    Author: Andrei-Paul Ionescu.
]]
function Player:toRecord()
    return self.username .. ";" .. tostring(self.score) .. ";"
end

function Player:update(deltaTime)

end

--[[
    This here routine is responsible for drawing to the screen all the information regarding the user, 
    in addition to invoking the paddle's draw method.

    Author: Andrei-Paul Ionescu.
]]
function Player:draw()
    local x = 432 - 122

    for i = 1, self.currentHP
    do
        love.graphics.draw(gGraphics['hearts'], gSprites['heart'][1], x, 4)
        x = x + 11
    end

    x = 432 - 122

    local offset = 0

    if self.currentHP == 0 then
        offset = 1
    else 
        offset = 0
    end

    for i = self.currentHP, self.defaultHP - offset
    do 
        love.graphics.draw(gGraphics['hearts'], gSprites['heart'][2], x, 4)
        x = x + 11
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.print("Score: " .. tostring(self.score), x + 50, 4)
end