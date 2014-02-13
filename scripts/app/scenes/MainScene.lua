require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local bg = display.newSprite("#background.png")
    bg:setPosition(display.cx, display.top - bg:getContentSize().height/2)
    self:addChild(bg)

    local logo = display.newSprite("#shoot_copyright.png")
    logo:setPosition(display.cx, display.cy)
    bg:addChild(logo)
end

function MainScene:onEnter()
    if device.platform == "android" then
        -- avoid unmeant back
        self:performWithDelay(function()
            -- keypad layer, for android
            local layer = display.newLayer()
            layer:addKeypadEventListener(function(event)
                if event == "back" then app.exit() end
            end)
            self:addChild(layer)

            layer:setKeypadEnabled(true)
        end, 0.5)
    end

    app:enterScene("GameScene", nil, "fade", 5, display.COLOR_BLACK)
end

function MainScene:onExit()
    --display.pause()
    --os.execute("sleep 5")
end

return MainScene
