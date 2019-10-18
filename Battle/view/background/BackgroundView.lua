require "lib.classes.class"
local SpriteFactory = require("Global.LOVEWrapper.sprite.SpriteFactory")
--------------------------------------------------------------------------------------------------------

-- Sprite factory to generate the entity's sprite
local sprite_factory = SpriteFactory.new()

-- class: BackgroundView
-- param: path:str -> The path of the image
local BackgroundView = class(function(self, path)
    self.sprite = sprite_factory:getRegularRectSprite(path, 800, 600, 1)
end)

-- draw: None -> None
-- Draws the full background image
function BackgroundView.draw(self)
    self.sprite:draw(0, 0, 1, 1)
end

return BackgroundView