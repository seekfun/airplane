--
-- Created by IntelliJ IDEA.
-- User: joylee
-- Date: 14-2-12
-- Time: 下午10:20
-- To change this template use File | Settings | File Templates.
--

local Plane = class("Plane", function(texture)
    return display.newSprite(texture)
end)

local winSize = CCDirector:sharedDirector():getWinSize()
local scheduler = require("framework.scheduler")
local schedulerHandle

function Plane:ctor()
    --[[
    local plane = display.newSprite("#hero1.png")
    plane:setPosition(display.cx, plane:getContentSize().height/2)
    self:addChild(plane, 10, AIRPLANE)

    local blink = CCBlink:create(1, 3)
    --local animation = CCAnimation:create()

    local frames = display.newFrames("hero%d.png", 1, 2)
    local animation = display.newAnimation(frames, 0.5 / 8)
    animation:setDelayPerUnit(0.1)
    local animate = CCAnimate:create(animation)

    -- 执行闪烁动画
    plane:runAction(blink)
    plane:runAction(CCRepeatForever:create(animate))


    self:onEnter()
    self:setTouchEnabled(true)
    --schedulerHandle = scheduler.scheduleGlobal(self.planeMove, 0.01)
    --]]
    self:setTouchEnabled(true)
end

--[[
function PlaneLayer:moveTo(location)
    if (isAlive and not CCDirector:sharedDirector():isPaused()) then
        print("moved...")
    end

end
--]]

function Plane:rect()
    local  s = self:getTexture():getContentSize()
    return CCRectMake(-s.width / 2, -s.height / 2, s.width, s.height)
end

function Plane:containsTouchLocation(x,y)
    local position = ccp(self:getPosition())
    local  s = self:getTexture():getContentSize()
    local touchRect = CCRectMake(-s.width / 2 + position.x, -s.height / 2 + position.y, s.width, s.height)
    local b = touchRect:containsPoint(ccp(x,y))
    return b
end

function Plane:ccTouchBegan(x, y)
    return true;
end

function Plane:ccTouchMoved(x, y)
    local plane = app:getObject("plane")
    local pDir = CCDirector:sharedDirector()


    if (Plane.isAlive and not CCDirector:sharedDirector():isPaused()) then
        local beginPoint = CCPoint(x, y)
        beginPoint = pDir:convertToGL(beginPoint)   -- 获取触摸坐标
        -- juggle the area of drag
        local planeRect = planeLayer:getChildByTag(AIRPLANE):boundingBox()  -- 获取飞机当前位置
        planeRect.origin.x = 15
        planeRect.origin.y = 15
        planeRect.size.width = 30
        planeRect.size.height = 30
        if (planeRect:containsPoint(CCPoint(x, y)) == true) then
            print("x=%d, y=%d", x, y)
        end
    end

    plane:setPosition(ccp(x, y))
end

function Plane:ccTouchEnded(x, y)
    --print("move ended!")
end

--[[
function PlaneLayer:planeMove()
    local planeLayer = app:getObject("planeLayer")
    local point = ccp(planeLayer:getPosition())
    --echo(point)
    if point.x > winSize.width then
        point.x = 0
        planeLayer:setPosition(point)
    else
        point.x = point.x + 1
        planeLayer:setPosition(point)
    end
end
--]]

function Plane:onTouch(eventType, x, y)
    if eventType == "began" then
        return self:ccTouchBegan(x,y)
    elseif eventType == "moved" then
        return self:ccTouchMoved(x,y)
    elseif eventType == "ended" then
        return self:ccTouchEnded(x, y)
    end
end

return Plane