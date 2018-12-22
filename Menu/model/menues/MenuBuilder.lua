require "Menu.mode.menues.Menu"
require "Menu.model.automaton.AutomatonBuilder"
--------------------------------------------------------------------------------------------------------
-- MenuBuilder: MenuBuilder
-- Creates new MenuBuilder
MenuBuilder = class(function(ab)
    ab.menu = Menu()
    ab.stateNumber = 0
end)

-- addState: MenuState -> self
-- Adds a menu state to the menu
function MenuBuilder:addState(state)
    self.menu.options[self.stateNumber + 1] = state
    self.stateNumber = self.stateNumber + 1
    return self
end

-- addTransition: int int key -> self
-- Adds a transition to the menu
function MenuBuilder:addTransition(i, j, key)
    self.menu.options[i+1].setTransition(key, self.menu.options[j+1])
    return self
end

-- setCurrentState: int -> self
-- Sets the current option of the menu
function MenuBuilder:setCurrentState(i)
    self.automaton.setCurrentState(self.menu.options[i+1])
    return self
end

-- getMenu: None -> Menu
-- Gets the builder's menu
function MenuBuilder:getMenu()
    return self.automaton
end