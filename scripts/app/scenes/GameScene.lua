--
-- Created by IntelliJ IDEA.
-- User: joylee
-- Date: 14-2-12
-- Time: 下午9:57
-- To change this template use File | Settings | File Templates.
--


local GameScene = class("GameScene", function()
    return display.newScene("GameScene")
end)

require("config")
local GameLayer = import("..scenes.layers.GameLayer").new()

function GameScene:ctor()
    local bg = display.newSprite("#background.png")
    bg:setPosition(display.cx, display.top - bg:getContentSize().height/2)
    self:addChild(bg)
   self:addChild(GameLayer)
end

function GameScene:onEnter()

end

function GameScene:onExit()
end

return GameScene
