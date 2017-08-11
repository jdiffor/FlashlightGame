-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- seed the random number generator
math.randomseed(os.time())

-- go to menu screen
composer.gotoScene("menu")