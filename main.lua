
-- -- -- -- -- -- -- 
-- GLOBAL VARIABLES
mouse = {}
-- -- -- -- -- -- -- 
-- -- -- -- -- -- -- 
-- ENUM DEFINES
TailName = {
    GREENLAND = 1,
    RIVERBEG = 2,
    RIVERSTR = 3,
    RIVEREND = 4,
    WATHER = 5,
    ROCKS = 6,
}

EnemyMov = {
    NOWALK = 0,
    FULLSPEEDWALK = 1,
    HALFSPEEDWALK = 2,
}
-- -- -- -- -- -- -- 
-- -- -- -- -- -- -- 
-- MAP OBJECT PROPERTIES 
-- for each type of map object are stored here in columns ([object type] = {prperty1, property2}) in the order: 
-- texture name and location
-- enemy can walk through [0-no; 1-yes, 2-slowed down],
-- object can be build on it [ 0-no, 1-yes,]
-- map object can be cleared from osbstacles [0-no, 1-yes]
-- type of object that this obcject can be changed to [0-default, object number]
ObjProperties = {
    [1] = {asset= "assets/grass_N.png", walk= EnemyMov.FULLSPEEDWALK, build= true, clear= false, typec= 0},
    [2] = {asset= "assets/river_start_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [3] = {asset= "assets/river_straight_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [4] = {asset= "assets/river_end_S.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= false, typec= 0},
    [5] = {asset= "assets/water_N.png",walk= EnemyMov.NOWALK, build= false, clear= false, typec= 0},
    [6] = {asset= "assets/stone_rocks_N.png",walk= EnemyMov.HALFSPEEDWALK, build= false, clear= true, typec= 1},
    [7] = {asset= "assets/gun_tower_N.png",walk= EnemyMov.NOWALK, build= false, clear= true, typec= 1},
    [8] = {asset= "assets/gun_tower2_N.png",walk= EnemyMov.NOWALK, build= false, clear= true, typec= 1},

    -- [7] = {1,1,1,1,1},
    -- [8] = {1,1,1,1,1},
    -- [9] = {1,1,1,1,1},
    -- [10] = {1,1,1,1,1}, 
}

-- -- -- -- -- -- -- 
-- GLOBAL VARIABLES END

-- -- -- -- -- -- -- 
-- LOAD
function love.load()

    red = 40/255
    green = 160/255
    blue = 255/255
    alpha = 0/100
    love.graphics.setBackgroundColor( red, green, blue, alpha )
    success = love.window.setMode( 1366, 768 ) 
    gameState = 1
    scale = 0.5
    scrollscale = 1
    elemoffsety = math.floor( 320 * scale )
    elemoffsetx = math.floor( 160 * scale )
    offsetcol = math.floor( 182 * scale )
    offsetrow = math.floor( 79 * scale )
    offsetcoleven = math.floor( 91 * scale )
    mapoffsetx = 683
    mapoffsety = 384
    menuXoffset = 1000
    midpixX = 0
    midpixY = 0
    

    Map1 = {
       [1] = {1,1,1,1,1,1,1,1,1,1},
       [2] = {1,2,3,3,4,1,1,1,1,1},
       [3] = {1,1,1,1,1,1,1,1,1,1},
       [4] = {1,1,1,1,1,1,1,1,1,1},
       [5] = {1,1,1,1,6,1,1,1,6,1},
       [6] = {1,1,1,1,1,1,1,1,1,1},
       [7] = {1,1,1,1,5,1,1,1,1,1},
       [8] = {1,1,1,1,1,1,1,1,1,1},
       [9] = {1,1,5,1,1,1,1,1,1,1},
       [10] = {1,1,1,1,1,1,1,1,6,1},
       size = 10,   
       timer = 15,
       defenceTowers = {7,7,8,8,7,7,8,8},

    }
    Map2 = {
        [1] = {1,1,1,1,1,1,1,1,1,1,1,1},
        [2] = {1,2,3,3,4,1,1,1,1,1,1,1},
        [3] = {1,1,1,1,1,1,1,1,1,1,1,1},
        [4] = {1,1,1,1,1,1,1,1,1,1,1,1},
        [5] = {1,1,1,1,6,1,1,1,6,1,1,1},
        [6] = {1,1,1,1,1,1,1,1,1,1,1,1},
        [7] = {1,1,1,1,5,1,1,1,1,1,1,1},
        [8] = {1,1,1,1,1,1,1,1,1,1,1,1},
        [9] = {1,1,5,1,1,1,1,1,1,1,1,1},
        [10] = {1,1,1,1,1,1,1,1,6,1,1,1}, 
        [11] = {1,1,1,1,1,1,1,1,6,1,1,1},
        [12] = {1,1,1,1,1,1,1,1,6,1,1,1},  
        size = 12,
        timer = 10,
        defenceTowers = {7,8,7,8},
     }

    GameStages = { Map1, Map2, n = 2 }
    currStageTimer = GameStages[1].timer
    stCtr = 1
    stage = GameStages[stCtr]
    pointingMenuElemVar = {isOnMenu = false, tower = nil}
    towerSelected = false
    
    -- -- -- -- -- -- --
    -- CREATE DRAWABLE OBJECT's
    image = {}

    for i, n in ipairs(ObjProperties) do
         
        local type  =  n.asset
        if type ~= nil then
            image[i] = love.graphics.newImage( type )
        end
    end
    transparent = love.graphics.newImage("assets/transparent_bcgr.png")
    -- -- -- -- -- -- --
end
-- -- -- -- -- -- -- 
-- LOAD END

-- -- -- -- -- -- -- 
-- helping functions
function lookuptable( row, col )
    local type = stage[row][col]
    return type
end



function moveTroughField( type )
    if type == TailName.GREENLAND then
        return true
    else
        return false
    end
end
scrollX = 0
scrollY = 0

function love.wheelmoved( x, y )
    if y > 0 and scrollscale < 2 then
        scrollscale = scrollscale + ( y / 10 )
        scrollX = mouse.x
        scrollY = mouse.y
    elseif y < 0  and scrollscale > 0.7 then
        scrollscale = scrollscale - ( math.abs( y ) / 10 )
        scrollX = mouse.x
        scrollY = mouse.y
    end   
end

function pointingMapElem( row, col )
    if (mouse.y >= row + mapoffsety + (elemoffsety * scrollscale) ) and ( mouse.y <= row + mapoffsety + (elemoffsety * scrollscale)  + (offsetrow * scrollscale) ) and ( mouse.x >= col + mapoffsetx + (elemoffsetx * scrollscale) ) and ( mouse.x <= col + mapoffsetx + (elemoffsetx * scrollscale) + (offsetcol * scrollscale) ) then
        return true
    else
        return false
    end
end
function pointingMenuElem(X, Y)
    if ( mouse.y >= Y + elemoffsety) and ( mouse.y <= Y + elemoffsety + offsetrow ) and ( mouse.x >= X + elemoffsetx ) and ( mouse.x <= X + elemoffsetx + offsetcol ) then
        return true
    else
        return false
    end
end

function love.mousepressed( x, y, button , istouch )

    if gameState == 1 or gameState == 3 or gameState == 4 then
        gameState = 2
    end 
    if gameState == 2 and button == 1 and pointingMenuElemVar.isOnMenu == true and pointingMenuElemVar.tower ~= nil  then
        towerSelected = true
    end

end
-- -- -- -- -- -- -- 
-- helping functions END

-- -- -- -- -- -- -- 
-- UPDATE world with dt
function love.update( dt )
    mouse.x, mouse.y = love.mouse.getPosition()
        
    if gameState == 2 then
        currStageTimer = currStageTimer - dt

        if currStageTimer <= 0 then
            if stCtr <= table.getn{GameStages} then
                stCtr = stCtr + 1
                stage = GameStages[stCtr]
                currStageTimer = stage.timer
                gameState = 3
            else
                gameState = 4
            end
        end
    end
    if gameState == 4 then
        stCtr = 1
        stage = GameStages[1]
        currStageTimer = GameStages[1].timer
    end

end
-- -- -- -- -- -- -- 
-- UPDATE END

debugPrint = 1
-- -- -- -- -- -- -- 
-- DRAW
function love.draw()
    local col = 0
    local row = 0
    local menuXlocal = menuXoffset
    local menuYlocal = 0
    local menuModifier = 0

    -- debug prints
    if debugPrint == 1 then
        love.graphics.print( "Mouse Coordinates: " .. mouse.x .. ", " .. mouse.y, 500 )
        love.graphics.print( "Mouse scrollscale: " .. scrollscale, 500, 15 )
    end

    -- game stats prints
    love.graphics.print( "CURRENT STAGE " .. stCtr, 10, 15 )
    if currStageTimer > 60 then
        love.graphics.print( "Time left for current satage " .. math.ceil( currStageTimer/60 ) .. " minutes", 10, 30 )
    else
        love.graphics.print( "Time left for current satage " .. math.ceil( currStageTimer ) .. " seconds", 10, 30 )
    end



    if gameState == 1 then
        love.graphics.print( "CLICK ENYWHERE TO START THE GAME" , 200, 200 )
    end
    if gameState == 3 then
        love.graphics.print( "YOU WON THE STAGE ".. stCtr-1 .. "!!!" .. " CLICK ENYWHERE TO START STAGE" .. stCtr , 200, 200 )
    end
    if gameState == 4 then
        love.graphics.print( "YOU WON THE GAME!!!" .. " CLICK ENYWHERE TO START NEW GAME" , 200, 200 )
    end
    -- -- -- -- -- -- --
    -- DRAWABLE OBJECT for current map
    if gameState == 2 then
        midpixY = offsetrow * (stage.size+1) /2 + elemoffsetx
        midpixX = offsetcol * (stage.size+1) /2 + elemoffsety

        local acctualScale = scale * scrollscale
        for i = 1, stage.size , 1 do

            row = (offsetrow * i - midpixY) * scrollscale
            -- row = mouse.y - (offsetrow * i ) * scrollscale

            for y = 1, stage.size  , 1 do
                if i % 2 == 0 then
                    col = (offsetcol * y - midpixX ) * scrollscale 
                    -- col = mouse.x - (offsetcol * y ) * scrollscale 
                else
                    col = (offsetcoleven + offsetcol * y - midpixX ) * scrollscale
                    -- col = mouse.x - (offsetcoleven + offsetcol * y ) * scrollscale
                end
                
                if moveTroughField(lookuptable(i,y)) and pointingMapElem(row, col) then
                    love.graphics.draw( image[lookuptable( i, y )], col, row + (15 * scrollscale) , 0, acctualScale ,acctualScale, -mapoffsetx/acctualScale, -mapoffsety/acctualScale)
                else
                    love.graphics.draw( image[lookuptable( i, y )], col, row, 0, acctualScale, acctualScale, -mapoffsetx/acctualScale, -mapoffsety/acctualScale)
                end
                col = 0
            end    
        end
        
        for i, n in ipairs(stage.defenceTowers) do
            local X = menuXlocal + offsetcol * (i - menuModifier)
            local Y = menuYlocal + (offsetrow * menuModifier)

            love.graphics.draw( transparent, X , Y , 0, scale )

            if pointingMenuElem(X,Y) then
                love.graphics.draw( image[n], X-40*scale, Y-40*scale, 0, scale * 1.1)
                pointingMenuElemVar = {isOnMenu = true, tower = image[n]}
            else
                love.graphics.draw( image[n], X, Y, 0, scale )
            end              

            if i % 2 == 0 then
                menuModifier = menuModifier + 2
            end

        end

        if towerSelected then
            love.graphics.draw( pointingMenuElemVar.tower, mouse.x - elemoffsetx -70*scale, mouse.y - elemoffsety - 30*scale, 0, scale)
        end
    end        
    -- -- -- -- -- -- --

end
-- -- -- -- -- -- -- 
-- DRAW END