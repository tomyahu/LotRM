require "lib.classes.class"
require "Global.consts"
require "Global.LOVEWrapper.LOVEWrapper"
local SpriteFactory = require("Global.LOVEWrapper.sprite.SpriteFactory")
--------------------------------------------------------------------------------------------------------

-- class: RectangleMenuView
-- param: menu:Menu -> The menu to represent
-- param: menu_border:MenuBorderView -> The border and background of the menu
-- param: font:love.Font -> The font to use
local RectangleMenuView = class(function(self, menu, menu_border, font)
    self.menu = menu
    self.menu_border = menu_border
    self.font = font
end)

-- draw: None -> None
-- TODO: Document this
function RectangleMenuView.draw(self)
  self.menu_border:draw()
  
  -- set font
  love.graphics.setFont( self.font )
  
  local start_x = self.menu_border:getOffsetX() + self.menu_border:getDimension()
  local start_y = self.menu_border:getOffsetY()
  
  local space_y = 30
  
  -- draws menu options
  for index, option in pairs(self.menu.options) do
        if self.menu:getCurrentState():getName() == option:getName() then
            love.graphics.print( option:getName(), getRelativePosX(start_x + 10), getRelativePosY(start_y + index*space_y), 0, getScale(), getScale())
        else
            love.graphics.print( option:getName(), getRelativePosX(start_x), getRelativePosY(start_y + index*space_y), 0, getScale(), getScale())
        end
    end
end

return RectangleMenuView