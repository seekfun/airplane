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

local Plane = import("..layers.Plane")
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

    if not app:isObjectExists("plane") then
        local plane = Plane.new("#hero1.png")
        app:setObject("plane", plane)
    end

    local plane = app:getObject("plane")

    local function onTouch(event, x, y)
        print(event)
        if event == "began" then
            return true
        end
        return plane:onTouch(event, x, y)
    end

    plane:setPosition(display.cx, plane:getContentSize().height/2)
    self:addChild(plane, 10, AIRPLANE)

    local blink = CCBlink:create(1, 3)
    local frames = display.newFrames("hero%d.png", 1, 2)
    local animation = display.newAnimation(frames, 0.5 / 8)
    animation:setDelayPerUnit(0.1)
    local animate = CCAnimate:create(animation)

    -- 执行闪烁动画
    plane:runAction(blink)
    plane:runAction(CCRepeatForever:create(animate))
    plane:setTouchEnabled(true)
    plane:addTouchEventListener(onTouch)

    self:addChild(BulletLayer)
    BulletLayer:startShoot()
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



return GameLayer