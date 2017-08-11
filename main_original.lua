-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

local gameLoopTimer

local time = 20
local score = 0
local gameOver = false

local background = display.newImageRect("background.png", 360, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

local beam = display.newImageRect("beam.png", 112, 200)
beam.x = display.contentCenterX
beam.y = display.contentHeight - 140
beam.radius = 56
physics.addBody(beam, {radius = 56, isSensor = true})
beam.myName = beam

local dot = display.newImageRect("dot.png", 36, 36)
dot.x = math.random(display.contentWidth)
dot.y = math.random(display.contentHeight - 80 - 18)
dot.radius = 18
physics.addBody(beam, {radius = 18, isSensor = true})

local flashlight = display.newImageRect("flashlight.png", 48, 82)
flashlight.x = beam.x
flashlight.y = beam.y + 140
flashlight.myName = "flashlight"

local timeText = display.newText("Time: " .. time, display.contentCenterX - 70, 10, native.systemFont, 28)
local tapText = display.newText("Score: " .. score, display.contentCenterX + 70, 10, native.systemFont, 28)

display.setStatusBar(display.HiddenStatusBar)

local function moveBeam(event)
	local beam = event.target
 	local phase = event.phase

 	if (phase == "began") then
 		display.currentStage:setFocus(beam)

 		beam.touchOffsetX = event.x - beam.x
 		beam.touchOffsetY = event.y - beam.y
 	elseif (phase == "moved") then
 		beam.x = event.x - beam.touchOffsetX
 		beam.y = event.y - beam.touchOffsetY
 		flashlight.x = beam.x
 		flashlight.y = beam.y + 140
 	elseif (phase == "ended" or phase == "cancelled") then
 		display.currentStage:setFocus(nil)
 	end

 	return true
end

local function moveFlashlight(event)
	local flashlight = event.target
 	local phase = event.phase

 	if (phase == "began") then
 		display.currentStage:setFocus(flashlight)

 		flashlight.touchOffsetX = event.x - flashlight.x
 		flashlight.touchOffsetY = event.y - flashlight.y
 	elseif (phase == "moved") then
 		flashlight.x = event.x - flashlight.touchOffsetX
 		flashlight.y = event.y - flashlight.touchOffsetY
 		beam.x = flashlight.x
 		beam.y = flashlight.y - 140
 	elseif (phase == "ended" or phase == "cancelled") then
 		display.currentStage:setFocus(nil)
 	end

 	return true
end

local function touchDot(event)
	local dot = event.target
	score = score + 1
	repeat
		dot.x = math.random(dot.radius, display.contentWidth - dot.radius)
		dot.y = math.random(dot.radius, display.contentHeight - 80 -dot.radius)
	until (not (dot.x + 18 >= beam.x - 56 and
				dot.x - 18 <= beam.x + 56 and
				dot.y + 18 >= beam.y - 56 and
				dot.y - 18 <= beam.y + 56))

	tapText.text = "Score: " .. score
end

beam:addEventListener("touch", moveBeam)
flashlight:addEventListener("touch", moveFlashlight)
dot:addEventListener("tap", touchDot)

local function gameLoop()
	time = time - 1
	timeText.text = "Time: " .. time
end

gameLoopTimer = timer.performWithDelay(1000, gameLoop, 20)
