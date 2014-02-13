--
-- Created by IntelliJ IDEA.
-- User: joylee
-- Date: 14-2-12
-- Time: 下午10:00
-- To change this template use File | Settings | File Templates.
--

local GameLayer = class("GameLayer", function()
    return display.newLayer()
end)

local scheduler = require("framework.scheduler")
local background1, background2
local schedulerHandle

local PlaneLayer = import("..layers.PlaneLayer")
local BulletLayer = import("..layers.BulletLayer").new()

function GameLayer:ctor()
    -- load background1
    background1 = display.newSprite("#background.png")
    background1:setAnchorPoint(CCPoint(0,0))
    background1:setPosition(CCPoint(0,0))
    self:addChild(background1)

    -- load background2
    background2 = display.newSprite("#background.png")
    background2:setAnchorPoint(CCPoint(0,0))
    background2:setPosition(CCPoint(0, background2:getContentSize().height - 2))    -- in order to prevent black line appear
    self:addChild(background2)

    if not app:isObjectExists("planeLayer") then
        local planeLayer = PlaneLayer.new()
        app:setObject("planeLayer", planeLayer)
    end

    self:addChild(app:getObject("planeLayer"))
    self:addChild(BulletLayer)
    BulletLayer:startShoot()
    self:setTouchEnabled(true)

    self:onEnter()
end

function GameLayer:onEnter()
    schedulerHandle = scheduler.scheduleGlobal(self.backgroundMove, 0.01)
end

function GameLayer:backgroundMove()
    background1:setPositionY(background1:getPositionY() - 2)
    background2:setPositionY(background1:getPositionY() + background1:getContentSize().height - 2)
    if (background2:getPositionY() == 0) then
        background1:setPositionY(0)
    end

end

function GameLayer:registerWithTouchDispatcher()
    local pDir = CCDirector:sharedDirector()
    pDir:getTouchDispatcher():addTargetedDelegate(self, 0, true)
end

function GameLayer:ccTouchBegan() end

return GameLayer