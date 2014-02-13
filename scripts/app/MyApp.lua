
require("config")
require("framework.init")
require("framework.shortcodes")
require("framework.cc.init")

local MyApp = class("MyApp", cc.mvc.AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
    self.objects_ = {}
end

function MyApp:run()
    CCFileUtils:sharedFileUtils():addSearchPath("res/")
    display.addSpriteFramesWithFile(SHOOT_TEXTURE_DATA_FILENAME, SHOOT_TEXTURE_IMAGE_FILENAME)
    display.addSpriteFramesWithFile(BACKGROUND_TEXTURE_DATA_FILENAME, BACKGROUND_TEXTURE_IMAGE_FILENAME)

    -- preload all sounds
    for k, v in pairs(GAME_SFX) do
        audio.preloadSound(v)
    end

    self:enterScene("MainScene")
end

function MyApp:setObject(id, object)
    assert(self.objects_[id] == nil, string.format("MyApp:setObject() - id \"%s\" already exists", id))
    self.objects_[id] = object
end

function MyApp:getObject(id)
    assert(self.objects_[id] ~= nil, string.format("MyApp:getObject() - id \"%s\" not exists", id))
    return self.objects_[id]
end

function MyApp:isObjectExists(id)
    return self.objects_[id] ~= nil
end

return MyApp
