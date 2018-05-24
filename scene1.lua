-----------------------------------------------------------------------------------------
--
-- scene1.lua
--
-- Created By Gillian Gonzales	
-- Created On May 15 2018
--
-- This file will show a level
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local physics = require( "physics" )
local json = require( "json" )
local tiled = require ( "com.ponywolf.ponytiled")

local scene = composer.newScene()
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
	physics.start()
	physics.setGravity(0, 50)

    local filename = "assets/maps/level0.json"
    local mapData = json.decodeFile( system.pathForFile( filename, system.ResourceDirectory ))
    map = tiled.new( mapData, "assets/maps")
    
    local sheetOptionsIdle = require("assets.spritesheets.ninjaBoy.ninjaBoyIdle")
    local sheetIdleNinja = graphics.newImageSheet("./assets/spritesheets/ninjaBoy/ninjaBoyIdle.png", sheetOptionsIdle:getSheet() )

    local sheetOptionsRun = require("assets.spritesheets.ninjaBoy.ninjaBoyRun")
    local sheetRunNinja = graphics.newImageSheet("./assets/spritesheets/ninjaBoy/ninjaBoyRun.png", sheetOptionsRun:getSheet() )

    local sequence_data = {
        {
            name = "idle",
            start = 1,
            count = 10,
            time = 800,
            loopCount = 0,
            sheet = sheetIdleNinja
        },
        {
            name = "Run",
            start = 1,
            count = 10,
            time = 800,
            loopCount = 1,
            sheet = sheetRunNinja
        }
    }

    local ninjaBoy = display.newSprite( sheetIdleNinja, sequence_data)
    physics.addBody( ninjaBoy, "dynamic", { density = 3, bounce = 0, friction = 1.0 })
    ninjaBoy.isFixedRotation = true
    ninjaBoy.x = display.contentWidth * .5
    ninjaBoy.y = 0 
    ninjaBoy:setSequence("idle")
    ninjaBoy:play()

    sceneGroup:insert( map )
    sceneGroup:insert( ninjaBoy ) 
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
        


    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
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