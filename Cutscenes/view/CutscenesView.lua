require "lib.classes.class"
require "Global.consts"
local View = require "Global.view.view"
require "Global.LOVEWrapper.LOVEWrapper"
-------------------------------------------------------------------------------------------------------

local CutscenesView = extend(View, function(self, cutscene_admin, font)
    self.cutscene_admin = cutscene_admin
    self.font = font
end,

function(cutscene_admin, font)
    return View.new()
end)


function CutscenesView.draw(self,context)
    love.graphics.setFont( self.font )
    local scene = self.cutscene_admin:getCurrentCutscene():getCurrentScene()
    local scene_image = context[scene:getImagePath()]
    local scenepixelwidth, _ = scene_image:getPixelDimensions()

    local x_transition = getRelativePosX(getScale()*(GAME_WIDTH - 500)/2)
    love.graphics.draw(scene_image,x_transition,0,0, getScale()/scenepixelwidth*500)
    love.graphics.print( scene:getText(), getRelativePosX(50), getRelativePosY(550), 0, getScale(), getScale())
end

function CutscenesView.getContextVars(self, _)
    local context = {}
    local cutscene = self.cutscene_admin:getCurrentCutscene()
    for _, scene in pairs(cutscene:getScenes()) do
        context[scene:getImagePath()] = love.graphics.newImage(scene:getImagePath())
    end
    return context
end

return CutscenesView