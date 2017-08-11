
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local physics = require( "physics" )
physics.start()

local function gotoGame()
	composer.gotoScene("game")
end

local function gotoHighScores()
	composer.gotoScene("highscores")
end

local pivot
local titleFlashlight

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

	local sceneGroup = self.view
	-- Code here runs when the scene is first created but has not yet appeared on screen

	physics.pause()

	local background = display.newImageRect(sceneGroup, "background.png", 800, 1400)
	background.x = display.contentCenterX
	background.y = display.contentCenterY

	local title = display.newImageRect(sceneGroup, "title.png", 325, 110)
	title.x = display.contentCenterX
	title.y = 50

	local playButton = display.newImageRect(sceneGroup, "playButton.png", 121, 73)
    playButton.x = display.contentCenterX
    playButton.y = 165
 
    local highScoresButton = display.newImageRect(sceneGroup, "highscoresButton.png", 279, 73)
    highScoresButton.x = display.contentCenterX
    highScoresButton.y = 240

	pivot = display.newImageRect(sceneGroup, "transparent.png", 50, 50);
	pivot.x = display.contentCenterX
	pivot.y = display.contentCenterY
	physics.addBody(pivot, "static" )

    titleFlashlight = display.newImageRect(sceneGroup, "titleFlashlight.png", 84, 212)
    titleFlashlight.x = display.contentCenterX
    titleFlashlight.y = 400
	physics.addBody(titleFlashlight, "dynamic" )

	physics.newJoint( "pivot", pivot, titleFlashlight, display.contentCenterX, 300) --335 is center 

    playButton:addEventListener("tap", gotoGame)
	highScoresButton:addEventListener("tap", gotoHighScores)
end


-- show()
function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen
		physics.start()
		titleFlashlight:setLinearVelocity( math.random( -120,-40 ), math.random( 20,60 ) )
	end
end


-- hide()
function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen

	end
end


-- destroy()
function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
