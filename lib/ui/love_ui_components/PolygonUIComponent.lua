require "lib.classes.class"
local LoveUIComponent = require("lib.ui.love_ui_components.LoveUIComponent")
--------------------------------------------------------------------------------------------------------

-- class: PolygonUIComponent
-- param: mode:("fill" or "line") -> defines the way to define the polygon, "fill" fills the area and
--                                      "line" just draws the outline
-- param: vertices:list(num) -> an array of intercalated x and y coordinates that represent the polygon's vertices
-- param: x:num -> the offset x coordinate to move all vertices
-- param: y:num -> the offset y coordinate to move all vertices
-- A wrapper of love's polygon drawable
local PolygonUIComponent = extend(LoveUIComponent, function(self, mode, vertices, x, y)
    self.mode = mode
    self.x = x
    self.y = y

    local offset = {self.x, self.y}
    self.raw_vertices = vertices
    self.vertices = {}
    for i = 1,(# vertices) do
        table.insert(self.vertices, vertices[i] + offset[(i-1)%2 + 1])
    end
end)

-- draw: None -> None
-- Draws the polygon defined by the object's variables
function PolygonUIComponent.draw(self)
    love.graphics.polygon( self.mode, self.vertices )
end

-- getters
function PolygonUIComponent.getMode(self)
    return self.mode
end

function PolygonUIComponent.getX(self)
    return self.x
end

function PolygonUIComponent.getY(self)
    return self.y
end

function PolygonUIComponent.getRawVertices(self)
    return self.raw_vertices
end

function PolygonUIComponent.getVertices(self)
    return self.vertices
end

-- setters
function PolygonUIComponent.setMode(self, new_mode)
    self.mode = new_mode
end

function PolygonUIComponent.setX(self, new_x)
    for i = 1,(# self.raw_vertices),2 do
        self.vertices[i] = self.raw_vertices[i] - self.x + new_x
    end
    self.x = new_x
end

function PolygonUIComponent.setY(self, new_y)
    for i = 2,(# self.raw_vertices),2 do
        self.vertices[i] = self.raw_vertices[i] - self.y + new_y
    end
    self.y = new_y
end

function PolygonUIComponent.setRawVertices(self, new_raw_vertices)
    self.raw_vertices = new_raw_vertices

    local offset = {self.x, self.y}
    self.vertices = {}
    for i = 1,(# self.raw_vertices) do
        table.insert(self.vertices, self.raw_vertices[i] + offset[(i-1)%2 + 1])
    end
end

return PolygonUIComponent