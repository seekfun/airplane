--
-- Created by IntelliJ IDEA.
-- User: joylee
-- Date: 14-2-12
-- Time: 下午10:20
-- To change this template use File | Settings | File Templates.
--

local PlaneLayer = class("PlaneLayer", function()
    return display.newLayer()
end)

function PlaneLayer:ctor()
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

end

return PlaneLayer