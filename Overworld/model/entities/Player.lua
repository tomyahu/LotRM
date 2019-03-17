require "lib.classes.class"
local SolidEntity = require "Overworld.model.entities.SolidEntity"
local NormalPlayerState = require "Overworld.model.entities.playerStates.NormalPlayerState"
--------------------------------------------------------------------------------------------------------

local Player = extend(SolidEntity, function(self, sprite, speed, hitboxes)
    self.speed = speed
    self.state = NormalPlayerState.new(self)
end,

function(sprite, speed, hitboxes)
    return SolidEntity.new(sprite, hitboxes)
end)

function Player.moveUp(self)
    self.state:moveUp()
end

function Player.moveDown(self)
    self.state:moveDown()
end

function Player.moveLeft(self)
    self.state:moveLeft()
end

function Player.moveRight(self)
    self.state:moveRight()
end

function Player.stopX(self)
    self.state:stopX()
end

function Player.stopY(self)
    self.state:stopY()
end

function Player.getSpeed(self)
    return self.solid_object:getSpeed()
end

function Player.getBaseSpeed(self)
    return self.speed
end

function Player.setState(self, new_state)
    self.state = new_state
end

function Player.registerAsSolidObject(_)
    return
end

return Player