local App = require "Global.application.App"
require "Global.consts"
--------------------------------------------------------------------------------------------------------
-- The aplication manager
application = {}

-- Current controller of the manager
CurrentCtrl = nil

-- Current view of the manager
CurrentView = nil

-- Current local context of the manager, every time the appChange function is called the function getContextVars method
-- from the controller of the next application is called to decide what to keep from the previous local context
-- TODO: Check if this can be done by just using the global context and clean local context every app change
LocalContext = {}

-- Current global context of the manager, is a global dictionary storage that is only accesed with the function
-- getGlobalContext
GlobalContext = {}

-- Sets the current view of the application manager
function application.setView(_,newView)
    CurrentView = newView
end

-- Sets the current controller of the application manager
function application.setCtrl(_,newCtrl)
    CurrentCtrl = newCtrl
end

-- Gets the current view of the application manager
function application.getCurrentView(_)
    return CurrentView
end

-- Gets the current controller of the application manager
function application.getCurrentCtrl(_)
    return CurrentCtrl
end

-- Gets the local context of the application
function application.getCurrentLocalContext(_)
    return LocalContext
end

-- Replaces the old local context with newContext if it is not nil, otherwise it cleans the local context
function application.setLocalContext(_, newContext)
    if newContext == nil then
        LocalContext = {}
    else
        LocalContext = newContext
    end
end

-- Gets the global context of the application
function application.getGocalContext(_)
    return LocalContext
end

-- appChange: str -> None
-- Changes the current application to the application appName
-- TODO: add exceptions to this part
-- TODO: manage memory better here
function application.appChange(self,appName)
    -- Gets the new application from the global constants
    local nextApp = APPS[appName]

    -- Manages the local context of the next application
    application:setLocalContext(nextApp:getCtrl():getContextVars(self:getCurrentLocalContext()))
    application:setLocalContext(nextApp:getView():getContextVars(self:getCurrentLocalContext()))

    -- Sets the current view and controller to those of the next application
    application:setView(nextApp:getView())
    application:setCtrl(nextApp:getCtrl())
end

-- Registers a new application in the global APPS variable
function application:registerApp(appName, appPath)
    APPS[appName] = App.new(appName, appPath)
end