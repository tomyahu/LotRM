require "lib.classes.class"
-------------------------------------------------------------------------------------------------------

-- class: ActionSequenceCreator
-- param: actions:list(Action) -> A list of actions available for a character
-- An action sequence builder
local ActionSequenceCreator = class(function(self, actions)

    -- Create new action list with the actions provided
    self.actions = {}
    for _, action in pairs(actions) do
        table.insert(self.actions, action)
    end

    -- Order action list alphabetically
    local order_function = function( a,b ) return a:getName() < b:getName() end
    table.sort(self.actions, order_function)

    -- Set up table to see which actions have been used
    self.used_actions = {}
    for _, action in pairs(actions) do
        self.used_actions[action] = false
    end

    -- Set up action sequence parameters
    self.action_sequence = {}
    self.action_sequence_size = 0
end)

-- getStartActions: str -> list(Actions)
-- Gets a list of all the start actions available
function ActionSequenceCreator.getStartActions(self)
    local condition_fun = function(action, state) return (not state) and action:isStartAction() end

    return self:getActionsWithCondition(condition_fun)
end

-- getStartAttackActions: str -> list(Actions)
-- Gets a list of all the start actions of the attack type
function ActionSequenceCreator.getStartAttackActions(self)
    local condition_fun = function(action, state) return (not state) and action:isStartAction() and action:isAttackAction() end

    return self:getActionsWithCondition(condition_fun)
end

-- getStartSupportActions: str -> list(Actions)
-- Gets a list of all the start actions of the support type
function ActionSequenceCreator.getStartSupportActions(self)
    local condition_fun = function(action, state) return (not state) and action:isStartAction() and action:isSupportAction() end

    return self:getActionsWithCondition(condition_fun)
end

-- getEndActions: str -> list(Actions)
-- Gets a list of all the end actions available
function ActionSequenceCreator.getEndActions(self)
    local condition_fun = function(action, state) return (not state) and action:isEndAction() end

    return self:getActionsWithCondition(condition_fun)
end

-- getActionsCompatibleWithLastAction: None -> list(Action)
-- Gets a list with all actions compatible with last action
function ActionSequenceCreator.getActionsCompatibleWithLastAction(self)
    if self:getLastAction() == nil then
        return self:getStartActions()
    end

    local last_action = self:getLastAction()
    local condition_fun = function(action, state) return (not state) and (action:compatiblePrevious(last_action)) end

    return self:getActionsWithCondition(condition_fun)
end

-- getActionsWithStartType: str -> list(Actions)
-- Gets a list of all the actions tha have not been used yet with the specified start piece type
function ActionSequenceCreator.getActionsWithStartType(self, type)
    local condition_fun = function(action, state) return (not state) and (action:getStartPiece() == type) end

    return self:getActionsWithCondition(condition_fun)
end

-- getActionsWithEndType: str -> list(Actions)
-- Gets a list of all the actions tha have not been used yet with the specified end piece type
function ActionSequenceCreator.getActionsWithEndType(self, type)
    local condition_fun = function(action, state) return (not state) and (action:getEndPiece() == type) end

    return self:getActionsWithCondition(condition_fun)
end

-- getActionsWithCondition: function(Action, bool) -> list(Action)
-- Gets a list of all the actions that passes the condition function
function ActionSequenceCreator.getActionsWithCondition(self, condition_fun)
    local available_actions = {}

    for _, action in pairs(self.actions) do
        local state = self.used_actions[action]

        if condition_fun(action, state) then
            table.insert(available_actions, action)
        end
    end

    return available_actions
end

-- addAction: Action -> None
-- Adds an action to the action sequence
function ActionSequenceCreator.addAction(self, action)
    if self.used_actions[action] then
        error("This action has already been used.")
    end

    -- Check if it is compatible with last action (If there are no actions it is also compatible)
    local last_action = self:getLastAction()

    if last_action == nil then
        if action:isStartAction() then
            self.action_sequence_size = self.action_sequence_size + 1
            self.action_sequence[self.action_sequence_size] = action
            self.used_actions[action] = true
            return
        else
            error("Tried to add a non starting action to an empty action sequence.")
        end
    end

    if (not last_action:compatibleNext(action)) and (self.action_sequence_size > 0) then
        error("Tried to add an incompatible action to the action sequence.")
    end
    if (self.action_sequence_size == 0) and (not action:isStartAction()) then
        error("Tried to start an action sequence without a start action.")
    end

    self.action_sequence_size = self.action_sequence_size + 1
    self.action_sequence[self.action_sequence_size] = action
    self.used_actions[action] = true
end

-- removeLastAction: None -> None
-- Removes the last action of the sequence
-- Removes the last action of the sequence
function ActionSequenceCreator.removeLastAction(self)
    if self.action_sequence_size == 0 then
        return
    end

    self.used_actions[self:getLastAction()] = false
    self.action_sequence[self.action_sequence_size] = nil
    self.action_sequence_size = self.action_sequence_size - 1
end

-- getActionSequence: None -> list(Action)
-- Returns the resulting action sequence of the creator
function ActionSequenceCreator.getActionSequence(self)
    -- Check if it finishes with end action.
    if not self:getLastAction():isEndAction() then
        error("Tried to return action sequence where last action isnt an end action.")
    end

    return self.action_sequence
end

-- getLastAction: None -> Action
-- Returns the last action of the action sequence of the creator
function ActionSequenceCreator.getLastAction(self)
    return self.action_sequence[self.action_sequence_size]
end

return ActionSequenceCreator
