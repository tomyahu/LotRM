require "lib.classes.class"
require "Global.LOVEWrapper.LOVEWrapper"
local RectangleMenuView = require("PauseMenu.view.menus.RectangleMenuView")
local SpriteFactory = require("Global.LOVEWrapper.sprite.SpriteFactory")
--------------------------------------------------------------------------------------------------------

-- Sprite factory to generate the entity's sprite
local sprite_factory = SpriteFactory.new()

-- class: RectangleIconMenuView
-- param: menu:Menu -> The menu to show in this rectangle Icon view
-- param: menu_border:MenuBorderView -> The borders of the menu
-- param: font:love.font -> The font of the menu options
-- param: space_y:int -> The vertical space between the menu options
local RectangleIconMenuView = extend(RectangleMenuView,
function(self, menu, menu_border, font, space_y)
    self.icon_image_dict = {}
end,

function(menu, menu_border, font, space_y)
    return RectangleMenuView.new(menu, menu_border, font, space_y)
end)

-- draw: None -> None
-- Draws the menu's rectangle, borders, options and the icons associated
function RectangleIconMenuView.draw(self)
    self.menu_border:draw()

    -- set font
    love.graphics.setFont( self.font )

    local start_x = self.menu_border:getOffsetX() + self.menu_border:getDimension() + 32
    local start_y = self.menu_border:getOffsetY()

    local space_y = self.space_y

    -- draws menu options
    for index, option in pairs(self.menu.options) do
        if self.icon_image_dict[option:toString()] == nil then
            self.icon_image_dict[option:toString()] = sprite_factory:getRegularRectSprite(option:getIconPath(), 16, 16, 1)
        end

        if self.menu:getCurrentState():toString() == option:toString() then
            love.graphics.print( option:toString(), getRelativePosX(start_x + 10), getRelativePosY(start_y + index*space_y), 0, getScale(), getScale())
            self.icon_image_dict[option:toString()]:draw(getRelativePosX(start_x - 22), getRelativePosY(start_y + index*space_y - 4), 2*getScale(), 2*getScale())
        else
            love.graphics.print( option:toString(), getRelativePosX(start_x), getRelativePosY(start_y + index*space_y), 0, getScale(), getScale())
            self.icon_image_dict[option:toString()]:draw(getRelativePosX(start_x - 32), getRelativePosY(start_y + index*space_y - 4), 2*getScale(), 2*getScale())
        end
    end
end

return RectangleIconMenuView