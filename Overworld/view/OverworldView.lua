local View = require "Global.view.view"
require "Global.application.application"
--------------------------------------------------------------------------------------------------------
local OverworldView = View.new()
OverworldView.__index = OverworldView

-- OverworldView: OverworldView
-- Creates a new OverworldView
function OverworldView.new(room_manager)
    local o = View.new()
    local self = setmetatable(o, OverworldView)
    self.__index = self
    self.room_manager = room_manager
    return self
end

function OverworldView.getContextVars(self, _)
    local context = {}
    local local_context = application:getCurrentLocalContext()
    context['current_room'] = self.room_manager:getCurrentRoom()
    context['current_room']:initialize(context)

    context['SolidObjects'] = local_context['SolidObjects']
    return context
end

function OverworldView.draw(_, context)
    context['current_room']:draw()
end

return OverworldView