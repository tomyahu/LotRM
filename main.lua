require "Global.consts"
require "Global.application.application"
---------------------------------------------------------------------------
if TEST then
    require("test")
    love.event.quit()
end

-- Love Default Conf
love.graphics.setDefaultFilter('nearest', 'nearest')


local initial_app = require( APPS[INITIAL_APP] )

for appName, appInit in pairs(APPS) do
    application:registerApp(appName, appInit)
end

-- TODO: add application initialization
function love.load()
    application:init()
  
    application:setCtrl(initial_app["ctrl"])
    application:setView(initial_app["view"])

    application:getCurrentCtrl():setup()
    application:getCurrentView():setup()
end

function love.draw()
    application:getCurrentView():draw()
end

function love.keypressed(key)
    application:getCurrentCtrl():callbackPressedKey(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "s" then
        application:saveGlobalContext()
    end
end

function love.keyreleased(key)
    application:getCurrentCtrl():callbackReleasedKey(key)
end


function love.update( dt )
    application:setInGlobalContext('dt', dt)

    application:getCurrentCtrl():update(dt)
    application:getCurrentView():update(dt)
end
