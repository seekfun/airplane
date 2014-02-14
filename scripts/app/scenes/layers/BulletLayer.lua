--
-- Created by IntelliJ IDEA.
-- User: joylee
-- Date: 14-2-13
-- Time: 下午3:17
-- To change this template use File | Settings | File Templates.
--

local BulletLayer = class("BulletLayer", function()
    return display.newLayer()
end)

local bulletBatchNode
local scheduler = require("framework.scheduler")
local schedulerHandle
local allBullet = CCArray:create()

function BulletLayer:ctor()
    local imageName = SHOOT_TEXTURE_IMAGE_FILENAME
    display.addSpriteFramesWithFile(SHOOT_TEXTURE_DATA_FILENAME, imageName)
    bulletBatchNode = display.newBatchNode(imageName)
    --[[
    for i = 1, 100 do
        local sprite = display.newSprite("#bullet1.png")
        bulletBatchNode:addChild(sprite)
    end
    --]]
    self:addChild(bulletBatchNode)

    --[[
    local sprite = display.newSprite("#bullet1.png")
    sprite:setAnchorPoint(CCPoint(0,0))
    sprite:setPosition(CCPoint(display.cx, display.cy))
    self:addChild(sprite)
    --]]

    self:onEnter()
end

function BulletLayer:onEnter()

end

function BulletLayer:addBullet(dt)
    local bullet = display.newSprite("#bullet1.png")
    local plane = app:getObject("plane")
    local planeX,planeY = plane:getPosition()
    local bulletPosition = CCPoint(planeX, planeY + plane:getContentSize().height/2)
    bullet:setPosition(bulletPosition)
    --allBullet:addObject(bullet)

    local actionArray = CCArray:create()
    local length = display.height + bullet:getContentSize().height/2 - bulletPosition.y     -- 子弹飞行距离，超出屏幕即结束
    local velocity = 520/1
    local realMoveDuration = length / velocity   -- 飞行时间
    local actionMove = CCMoveTo:create(realMoveDuration, CCPoint(bulletPosition.x, display.height + bullet:getContentSize().height/2))
    actionArray:addObject(actionMove)

    local function bulletMoveFinished(sender)
        --local bullet = sender
        --print(allBullet:count())
        --allBullet:removeObject(bullet)
        bulletBatchNode:removeChild(bullet, true)
        bullet:removeSelf()
    end

    local actionDone = CCCallFunc:create(bulletMoveFinished)
    actionArray:addObject(actionDone)
    local sequence = CCSequence:create(actionArray)
    bullet:runAction(sequence)

    bulletBatchNode:addChild(bullet)
end

function BulletLayer:startShoot(delay)
    schedulerHandle = scheduler.scheduleGlobal(self.addBullet, 0.1, CCRepeatForever, delay)
end

function BulletLayer:stopShoot()
    scheduler.unscheduleGlobal(schedulerHandle)
end

function BulletLayer:removeBullet(bullet)
    if (bullet) then
        --allBullet:removeObject(bullet)
        bulletBatchNode:removeChild(bullet, true)
    end
end



return BulletLayer