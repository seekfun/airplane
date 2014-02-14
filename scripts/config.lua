
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 2
DEBUG_FPS = true
DEBUG_MEM = true

-- design resolution
CONFIG_SCREEN_WIDTH  = 640
CONFIG_SCREEN_HEIGHT = 960

-- auto scale mode
CONFIG_SCREEN_AUTOSCALE = "FIXED_WIDTH"

-- sounds
GAME_SFX = {
    tapButton      = "res/sound/TapButtonSound.mp3",
    backButton     = "res/sound/BackButtonSound.mp3",
    countdownButton= "res/sound/countdown.mp3",
    rightButton   = "res/sound/right.caf",
    wrongButton     = "res/sound/wrong.wav",
    levelWinCompleted = "res/sound/LevelWinSound.mp3",
    levelFailCompleted = "res/sound/wrong.wav",
}


SHOOT_TEXTURE_DATA_FILENAME  = "res/shoot.plist"
SHOOT_TEXTURE_IMAGE_FILENAME = "res/shoot.png"

BACKGROUND_TEXTURE_DATA_FILENAME  = "res/shoot_background.plist"
BACKGROUND_TEXTURE_IMAGE_FILENAME = "res/shoot_background.png"

PLANETEXTURE = "res/img/hero1.png"

--tags
AIRPLANE = 1000
