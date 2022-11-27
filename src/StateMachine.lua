StateMachine = class{}

function StateMachine:init(states)
    self.empty = {
        render = function() end,
        update = function() end,
        enter  = function() end,
        exit   = function() end
    }

    self.states = states or {}
    self.current = self.empty
end

function StateMachine:change(stateName, parameters)
    assert(self.states[stateName])
    self.current:exit()
    self.current = self.states[stateName]()
    self.current:enter(parameters)
end

function StateMachine:update(deltaTime)
    self.current:update(deltaTime)
end

function StateMachine:render()
    self.current.render()
end